import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_app/core/handlers/app_connectivity.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_event.dart';
import 'package:super_app/features/history/domain/entities/paginated_transactions/paginated_transactions.dart';
import 'package:super_app/features/history/domain/entities/transaction/transaction.dart';
import 'package:super_app/features/history/domain/entities/transaction_extensions.dart';
import 'package:super_app/features/history/domain/entities/transaction_filter/transaction_filter.dart';
import 'package:super_app/features/history/domain/entities/transaction_type.dart';
import 'package:super_app/features/history/domain/repositories/transaction_repository.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';
part 'transactions_bloc.freezed.dart';

/// A combined bloc for handling both transaction list and detail operations
@singleton
class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionRepository _transactionRepository;
  final AccountsBloc _accountsBloc;
  
  // Constants for SharedPreferences keys
  static const String _preserveFiltersKey = 'preserve_transaction_filters';
  static const String _lastFilterKey = 'last_transaction_filter';

  TransactionsBloc(
    this._transactionRepository,
    this._accountsBloc,
  ) : super(_initializeState(_accountsBloc)) {
    // List events
    on<TransactionsFetched>(_onTransactionsFetched);
    on<TransactionsRefreshed>(_onTransactionsRefreshed);
    on<TransactionsFiltered>(_onTransactionsFiltered);
    on<TransactionsLoadMore>(_onTransactionsLoadMore);
    on<TransactionsAccountChanged>(_onTransactionsAccountChanged);
    
    // Detail events
    on<TransactionDetailFetched>(_onTransactionDetailFetched);
    on<TransactionDetailSetFromCache>(_onTransactionDetailSetFromCache);
    
    // Filter-related events
    on<TransactionsRemoveFilterType>(_onRemoveFilterType);
    on<TransactionsRemoveFilterDirection>(_onRemoveFilterDirection);
    on<TransactionsRemoveFilterStatus>(_onRemoveFilterStatus);
    on<TransactionsRemoveFilterDates>(_onRemoveFilterDates);
    on<TransactionsRemoveFilterCounterparty>(_onRemoveFilterCounterparty);
    on<TransactionsRemoveFilterAmounts>(_onRemoveFilterAmounts);
    on<TransactionsClearAllFilters>(_onClearAllFilters);
    on<TransactionsScrolledToBottom>(_onScrolledToBottom);
    on<TransactionsScrollPositionChanged>(_onScrollPositionChanged);
    on<TransactionsOpenAccountSelection>(_onOpenAccountSelection);
    
    // New UI-related events
    on<TransactionsSaveFilterPreservation>(_onSaveFilterPreservation);
    on<TransactionsSaveLastAppliedFilter>(_onSaveLastAppliedFilter);
    on<TransactionsLoadLastAppliedFilter>(_onLoadLastAppliedFilter);
    on<TransactionsLoadFilterPreservationSetting>(_onLoadFilterPreservationSetting);
    on<TransactionsShareReceipt>(_onShareReceipt);
    on<TransactionsAccountSelectorClosed>(_onAccountSelectorClosed);
    on<TransactionsShowFilterDialog>(_onShowFilterDialog);
  }

  // Static method to initialize the state with the account ID from AccountsBloc
  static TransactionsState _initializeState(AccountsBloc accountsBloc) {
    int accountId = 0; // Initialize with 0, will be updated if accounts are available
    try {
      final accountsState = accountsBloc.state;
      
      if (accountsState.accounts.isNotEmpty) {
        accountId = accountsState.accounts.first.id;
      } else {
        // Try to trigger account loading if not already loading
        if (!accountsState.isLoading) {
          accountsBloc.add(const AccountsEvent.fetchAccounts());
        }
      }
    } catch (e) {
      // Error handling with empty catch block
    }
    
    return TransactionsState.initial().copyWith(accountId: accountId);
  }

  // List event handlers
  Future<void> _onTransactionsFetched(
    TransactionsFetched event,
    Emitter<TransactionsState> emit,
  ) async {
    if (state.listStatus == TransactionsListStatus.loading) {
      return;
    }

    if (state.listStatus != TransactionsListStatus.loading) {
    emit(state.copyWith(listStatus: TransactionsListStatus.loading));
    }

    final hasConnectivity = await AppConnectivity.connectivity();

    if (!hasConnectivity) {
      emit(
        state.copyWith(
          listStatus: TransactionsListStatus.failure,
          listErrorMessage: 'No internet connection. Please check your network.',
        ),
      );
      return;
    }

    int accountId = state.accountId;
    
    if (accountId <= 0) {
      try {
        final accountsState = _accountsBloc.state;
        
        if (accountsState.accounts.isNotEmpty) {
          accountId = accountsState.accounts.first.id;
        } else {
          emit(
            state.copyWith(
              listStatus: TransactionsListStatus.failure,
              listErrorMessage: 'No accounts available. Please add an account or try again later.',
            ),
          );
          return;
        }
      } catch (e) {
        emit(
          state.copyWith(
            listStatus: TransactionsListStatus.failure,
            listErrorMessage: 'Unable to load account information. Please try again later.',
          ),
        );
        return;
      }
    }

    try {
      final result = await _transactionRepository.getTransactions(
        pageId: 1,
        pageSize: state.pageSize,
        accountId: accountId,
        filter: state.filter,
      );

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              listStatus: TransactionsListStatus.failure,
              listErrorMessage: NetworkExceptions.getRawErrorMessage(failure),
            ),
          );
        },
        (paginatedTransactions) {
          final filteredTransactions = state.filter != null 
              ? _applyLocalFilter(paginatedTransactions.transactions, state.filter!)
              : paginatedTransactions.transactions;
              
          final filteredPaginatedTransactions = PaginatedTransactions(
            transactions: filteredTransactions,
            totalCount: filteredTransactions.length,
            currentPage: paginatedTransactions.currentPage,
            pageSize: paginatedTransactions.pageSize,
            hasReachedMax: paginatedTransactions.hasReachedMax,
          );
          
          emit(
            state.copyWith(
              listStatus: TransactionsListStatus.success,
              paginatedTransactions: filteredPaginatedTransactions,
              accountId: accountId,
              currentPage: 1,
              hasReachedMax: paginatedTransactions.hasReachedMax || filteredTransactions.isEmpty,
              listErrorMessage: '',
              activeFilterLabels: _generateFilterLabels(state.filter),
              isFilterActive: _isFilterActive(state.filter),
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          listStatus: TransactionsListStatus.failure,
          listErrorMessage: 'An unexpected error occurred. Please try again later.',
        ),
      );
    }
  }

  Future<void> _onTransactionsRefreshed(
    TransactionsRefreshed event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(state.copyWith(
      listStatus: TransactionsListStatus.initial,
      paginatedTransactions: null,
      currentPage: 1,
      hasReachedMax: false,
    ));
    
    add(const TransactionsEvent.fetched());
  }

  Future<void> _onTransactionsFiltered(
    TransactionsFiltered event,
    Emitter<TransactionsState> emit,
  ) async {
    final activeFilterLabels = _generateFilterLabels(event.filter);
    final isFilterActive = _isFilterActive(event.filter);
    
    emit(state.copyWith(
      filter: event.filter,
      listStatus: TransactionsListStatus.loading,
      paginatedTransactions: null,
      currentPage: 1,
      hasReachedMax: false,
      activeFilterLabels: activeFilterLabels,
      isFilterActive: isFilterActive,
    ));
    
    try {
      int accountId = state.accountId;
      
      if (accountId <= 0) {
        final accountsState = _accountsBloc.state;
        if (accountsState.accounts.isNotEmpty) {
          accountId = accountsState.accounts.first.id;
        } else {
          emit(
            state.copyWith(
              listStatus: TransactionsListStatus.failure,
              listErrorMessage: 'No accounts available. Please add an account or try again later.',
            ),
          );
          return;
        }
      }
      
      final result = await _transactionRepository.getTransactions(
        pageId: 1,
        pageSize: state.pageSize,
        accountId: accountId,
        filter: event.filter,
      );
      
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              listStatus: TransactionsListStatus.failure,
              listErrorMessage: NetworkExceptions.getRawErrorMessage(failure),
            ),
          );
        },
        (paginatedTransactions) {
          final filteredTransactions = event.filter != null 
              ? _applyLocalFilter(paginatedTransactions.transactions, event.filter!)
              : paginatedTransactions.transactions;
              
          final filteredPaginatedTransactions = PaginatedTransactions(
            transactions: filteredTransactions,
            totalCount: filteredTransactions.length,
            currentPage: paginatedTransactions.currentPage,
            pageSize: paginatedTransactions.pageSize,
            hasReachedMax: paginatedTransactions.hasReachedMax,
          );
          
          // Emit success state immediately without artificial delay
          emit(
            state.copyWith(
              listStatus: TransactionsListStatus.success,
              paginatedTransactions: filteredPaginatedTransactions,
              accountId: accountId,
              currentPage: 1,
              hasReachedMax: paginatedTransactions.hasReachedMax || filteredTransactions.isEmpty,
              listErrorMessage: '',
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          listStatus: TransactionsListStatus.failure,
          listErrorMessage: 'An unexpected error occurred. Please try again later.',
        ),
      );
    }
  }

  Future<void> _onTransactionsLoadMore(
    TransactionsLoadMore event,
    Emitter<TransactionsState> emit,
  ) async {
    if (state.listStatus == TransactionsListStatus.loading || 
        state.listStatus == TransactionsListStatus.loadingMore ||
        state.hasReachedMax ||
        state.listStatus == TransactionsListStatus.initial) {
      return;
    }

    if (state.accountId <= 0) {
      emit(
        state.copyWith(
          listStatus: TransactionsListStatus.failure,
          listErrorMessage: 'No valid account found. Please refresh and try again.',
        ),
      );
      return;
    }
    
    final accountId = state.accountId;

    emit(state.copyWith(
      listStatus: TransactionsListStatus.loadingMore,
    ));

    final hasConnectivity = await AppConnectivity.connectivity();

    if (!hasConnectivity) {
      emit(
        state.copyWith(
          listStatus: TransactionsListStatus.success,
          listErrorMessage: 'No internet connection. Please check your network.',
        ),
      );
      return;
    }

    try {
      final existingTransactions = state.paginatedTransactions?.transactions ?? [];
      if (existingTransactions.isEmpty) {
        add(const TransactionsEvent.fetched());
        return;
      }

      final nextPage = state.currentPage + 1;
      
      final result = await _transactionRepository.getTransactions(
        pageId: nextPage,
        pageSize: state.pageSize,
        accountId: accountId,
        filter: state.filter,
      );

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              listStatus: TransactionsListStatus.success,
              listErrorMessage: 'Failed to load more transactions. ${NetworkExceptions.getRawErrorMessage(failure)}',
              hasReachedMax: true,
            ),
          );
        },
        (newPaginatedTransactions) {
          final newTransactions = newPaginatedTransactions.transactions;
          
          final filteredNewTransactions = state.filter != null 
              ? _applyLocalFilter(newTransactions, state.filter!)
              : newTransactions;
          
          if (filteredNewTransactions.isEmpty) {
            emit(
              state.copyWith(
                listStatus: TransactionsListStatus.success,
                hasReachedMax: true,
                listErrorMessage: '',
              ),
            );
            return;
          }
          
          final existingTransactions = state.paginatedTransactions?.transactions ?? [];
          
          final allTransactions = [...existingTransactions, ...filteredNewTransactions];
          
          final updatedPaginatedTransactions = PaginatedTransactions(
            transactions: allTransactions,
            totalCount: allTransactions.length,
            currentPage: nextPage,
            pageSize: state.pageSize,
            hasReachedMax: newPaginatedTransactions.hasReachedMax,
          );
          
          emit(
            state.copyWith(
              listStatus: TransactionsListStatus.success,
              paginatedTransactions: updatedPaginatedTransactions,
              currentPage: nextPage,
              hasReachedMax: newPaginatedTransactions.hasReachedMax || filteredNewTransactions.isEmpty,
              listErrorMessage: '',
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          listStatus: TransactionsListStatus.success,
          listErrorMessage: 'An unexpected error occurred while loading more transactions.',
          hasReachedMax: true,
        ),
      );
    }
  }

  Future<void> _onTransactionsAccountChanged(
    TransactionsAccountChanged event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(state.copyWith(
      accountId: event.accountId,
      listStatus: TransactionsListStatus.initial,
      paginatedTransactions: null,
      currentPage: 1,
      hasReachedMax: false,
    ));
    
    add(const TransactionsEvent.fetched());
  }

  // Detail event handlers
  Future<void> _onTransactionDetailFetched(
    TransactionDetailFetched event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(state.copyWith(detailStatus: TransactionsDetailStatus.loading));

    final hasConnectivity = await AppConnectivity.connectivity();

    if (!hasConnectivity) {
      emit(
        state.copyWith(
          detailStatus: TransactionsDetailStatus.failure,
          detailErrorMessage: 'No internet connection. Please check your network.',
        ),
      );
      return;
    }

    int accountId = event.accountId > 0 ? event.accountId : state.accountId;
    
    if (accountId <= 0) {
      try {
        final accountsState = _accountsBloc.state;
        if (accountsState.accounts.isNotEmpty) {
          accountId = accountsState.accounts.first.id;
        } else {
          emit(
            state.copyWith(
              detailStatus: TransactionsDetailStatus.failure,
              detailErrorMessage: 'No accounts available. Please add an account first.',
            ),
          );
          return;
        }
      } catch (e) {
        emit(
          state.copyWith(
            detailStatus: TransactionsDetailStatus.failure,
            detailErrorMessage: 'Unable to load account. Please try again later.',
          ),
        );
        return;
      }
    }

    try {
      final result = await _transactionRepository.getTransactionById(
        transactionId: event.transactionId,
        accountId: accountId,
      );

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              detailStatus: TransactionsDetailStatus.failure,
              detailErrorMessage: NetworkExceptions.getRawErrorMessage(failure),
            ),
          );
        },
        (transaction) {
          emit(
            state.copyWith(
              detailStatus: TransactionsDetailStatus.success,
              selectedTransaction: transaction,
              detailErrorMessage: '',
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          detailStatus: TransactionsDetailStatus.failure,
          detailErrorMessage: 'An unexpected error occurred. Please try again later.',
        ),
      );
    }
  }

  void _onTransactionDetailSetFromCache(
    TransactionDetailSetFromCache event,
    Emitter<TransactionsState> emit,
  ) {
    emit(
      state.copyWith(
        detailStatus: TransactionsDetailStatus.success,
        selectedTransaction: event.transaction,
        detailErrorMessage: '',
      ),
    );
  }

  // Filter event handlers
  void _onRemoveFilterType(
    TransactionsRemoveFilterType event,
    Emitter<TransactionsState> emit,
  ) {
    final currentFilter = state.filter;
    if (currentFilter == null) return;
    
    final updatedFilter = currentFilter.copyWith(type: null);
    add(TransactionsEvent.filtered(filter: updatedFilter));
  }
  
  void _onRemoveFilterDirection(
    TransactionsRemoveFilterDirection event,
    Emitter<TransactionsState> emit,
  ) {
    final currentFilter = state.filter;
    if (currentFilter == null) return;
    
    final updatedFilter = currentFilter.copyWith(direction: null);
    add(TransactionsEvent.filtered(filter: updatedFilter));
  }
  
  void _onRemoveFilterStatus(
    TransactionsRemoveFilterStatus event,
    Emitter<TransactionsState> emit,
  ) {
    final currentFilter = state.filter;
    if (currentFilter == null) return;
    
    final updatedFilter = currentFilter.copyWith(status: null);
    add(TransactionsEvent.filtered(filter: updatedFilter));
  }
  
  void _onRemoveFilterDates(
    TransactionsRemoveFilterDates event,
    Emitter<TransactionsState> emit,
  ) {
    final currentFilter = state.filter;
    if (currentFilter == null) return;
    
    final updatedFilter = currentFilter.copyWith(startDate: null, endDate: null);
    add(TransactionsEvent.filtered(filter: updatedFilter));
  }
  
  void _onRemoveFilterCounterparty(
    TransactionsRemoveFilterCounterparty event,
    Emitter<TransactionsState> emit,
  ) {
    final currentFilter = state.filter;
    if (currentFilter == null) return;
    
    final updatedFilter = currentFilter.copyWith(counterpartyName: null);
    add(TransactionsEvent.filtered(filter: updatedFilter));
  }
  
  void _onRemoveFilterAmounts(
    TransactionsRemoveFilterAmounts event,
    Emitter<TransactionsState> emit,
  ) {
    final currentFilter = state.filter;
    if (currentFilter == null) return;
    
    final updatedFilter = currentFilter.copyWith(minAmount: null, maxAmount: null);
    add(TransactionsEvent.filtered(filter: updatedFilter));
  }
  
  void _onClearAllFilters(
    TransactionsClearAllFilters event,
    Emitter<TransactionsState> emit,
  ) {
    add(TransactionsEvent.filtered(filter: TransactionFilter()));
  }
  
  void _onScrolledToBottom(
    TransactionsScrolledToBottom event,
    Emitter<TransactionsState> emit,
  ) {
    if (!state.hasReachedMax) {
      add(const TransactionsEvent.loadMore());
    }
  }
  
  void _onScrollPositionChanged(
    TransactionsScrollPositionChanged event,
    Emitter<TransactionsState> emit,
  ) {
    // Check if we've reached the bottom threshold
    if (_isBottomOfList(event.scrollOffset, event.maxScrollExtent)) {
      add(const TransactionsEvent.scrolledToBottom());
    }
  }
  
  // Helper method to determine if we're at the bottom of the list
  bool _isBottomOfList(double currentScroll, double maxScroll) {
    // Consider as "at the bottom" when we're within 10% of the max scroll extent
    return maxScroll > 0 && currentScroll >= (maxScroll * 0.9);
  }
  
  void _onOpenAccountSelection(
    TransactionsOpenAccountSelection event,
    Emitter<TransactionsState> emit,
  ) {
    emit(state.copyWith(shouldOpenAccountSelector: true));
  }

  void accountSelectorClosed() {
    if (state.shouldOpenAccountSelector) {
      emit(state.copyWith(shouldOpenAccountSelector: false));
    }
  }

  // Add this new method to apply local filtering
  List<Transaction> _applyLocalFilter(List<Transaction> transactions, TransactionFilter filter) {
    return transactions.where((transaction) {
      if (filter.type != null && transaction.type != filter.type!.value) {
        return false;
      }
      
      if (filter.direction != null && transaction.direction != filter.direction!.value) {
        return false;
      }
      
      if (filter.status != null && transaction.status != filter.status!.value) {
        return false;
      }
      
      if (filter.startDate != null && transaction.created_at.isBefore(filter.startDate!)) {
        return false;
      }
      
      if (filter.endDate != null) {
        final endDatePlusOne = filter.endDate!.add(const Duration(days: 1));
        if (transaction.created_at.isAfter(endDatePlusOne)) {
          return false;
        }
      }
      
      if (filter.counterpartyName != null && filter.counterpartyName!.isNotEmpty) {
        final counterpartyName = transaction.counterparty_name?.toLowerCase() ?? '';
        if (!counterpartyName.contains(filter.counterpartyName!.toLowerCase())) {
          return false;
        }
      }
      
      if (filter.bankCode != null && 
          filter.bankCode!.isNotEmpty && 
          transaction.bank_code != filter.bankCode) {
        return false;
      }
      
      if (filter.minAmount != null && transaction.amount < filter.minAmount!) {
        return false;
      }
      
      if (filter.maxAmount != null && transaction.amount > filter.maxAmount!) {
        return false;
      }
      
      return true;
    }).toList();
  }
  
  // Helper methods for filtering
  List<FilterLabel> _generateFilterLabels(TransactionFilter? filter) {
    final List<FilterLabel> labels = [];
    
    if (filter == null) {
      return labels;
    }
    
    if (filter.type != null) {
      String typeLabel;
      if (filter.type?.value == 'external_transfer') {
        typeLabel = 'External Transfer';
      } else if (filter.type?.value == 'internal_transfer') {
        typeLabel = 'Internal Transfer';
      } else {
        typeLabel = 'Top-up';
      }
      
      labels.add(FilterLabel(
        label: typeLabel,
        type: FilterLabelType.type,
      ));
    }
    
    if (filter.direction != null) {
      labels.add(FilterLabel(
        label: filter.direction?.value == 'incoming' ? 'Incoming' : 'Outgoing',
        type: FilterLabelType.direction,
      ));
    }
    
    if (filter.status != null) {
      String statusLabel;
      if (filter.status?.value == 'completed') {
        statusLabel = 'Completed';
      } else if (filter.status?.value == 'pending') {
        statusLabel = 'Pending';
      } else {
        statusLabel = 'Failed';
      }
      
      labels.add(FilterLabel(
        label: statusLabel,
        type: FilterLabelType.status,
      ));
    }
    
    if (filter.startDate != null || filter.endDate != null) {
      final DateFormat dateFormat = DateFormat('MMM d, yy');
      String dateLabel = 'Date: ';
      
      if (filter.startDate != null && filter.endDate != null) {
        dateLabel += '${dateFormat.format(filter.startDate!)} - ${dateFormat.format(filter.endDate!)}';
      } else if (filter.startDate != null) {
        dateLabel += 'From ${dateFormat.format(filter.startDate!)}';
      } else if (filter.endDate != null) {
        dateLabel += 'Until ${dateFormat.format(filter.endDate!)}';
      }
      
      labels.add(FilterLabel(
        label: dateLabel,
        type: FilterLabelType.dates,
      ));
    }
    
    if (filter.counterpartyName != null && filter.counterpartyName!.isNotEmpty) {
      labels.add(FilterLabel(
        label: 'Name: ${filter.counterpartyName}',
        type: FilterLabelType.counterparty,
      ));
    }
    
    if (filter.minAmount != null || filter.maxAmount != null) {
      String amountLabel = 'Amount: ';
      
      if (filter.minAmount != null && filter.maxAmount != null) {
        amountLabel += '${filter.minAmount} - ${filter.maxAmount}';
      } else if (filter.minAmount != null) {
        amountLabel += '≥ ${filter.minAmount}';
      } else if (filter.maxAmount != null) {
        amountLabel += '≤ ${filter.maxAmount}';
      }
      
      labels.add(FilterLabel(
        label: amountLabel,
        type: FilterLabelType.amounts,
      ));
    }
    
    return labels;
  }
  
  bool _isFilterActive(TransactionFilter? filter) {
    if (filter == null) {
      return false;
    }
    
    return filter.type != null ||
           filter.direction != null ||
           filter.status != null ||
           filter.startDate != null ||
           filter.endDate != null ||
           (filter.counterpartyName != null && filter.counterpartyName!.isNotEmpty) ||
           filter.minAmount != null ||
           filter.maxAmount != null;
  }

  // New UI-related event handlers
  Future<void> _onSaveFilterPreservation(
    TransactionsSaveFilterPreservation event,
    Emitter<TransactionsState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_preserveFiltersKey, event.preserveFilters);
      
      emit(state.copyWith(
        shouldPreserveFilters: event.preserveFilters,
      ));
    } catch (e) {
      // Handle error silently, state remains unchanged
    }
  }
  
  Future<void> _onSaveLastAppliedFilter(
    TransactionsSaveLastAppliedFilter event,
    Emitter<TransactionsState> emit,
  ) async {
    if (!state.shouldPreserveFilters) return; // Only save if preserving filters
    
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Create a simple map representation of the filter
      final filterMap = {
        'type': event.filter.type?.value,
        'direction': event.filter.direction?.value,
        'status': event.filter.status?.value,
        'startDate': event.filter.startDate?.millisecondsSinceEpoch,
        'endDate': event.filter.endDate?.millisecondsSinceEpoch,
        'counterpartyName': event.filter.counterpartyName,
        'minAmount': event.filter.minAmount,
        'maxAmount': event.filter.maxAmount,
      };
      
      // Save as a properly encoded JSON string
      await prefs.setString(_lastFilterKey, jsonEncode(filterMap));
    } catch (e) {
      // Handle error silently
    }
  }
  
  Future<void> _onLoadLastAppliedFilter(
    TransactionsLoadLastAppliedFilter event,
    Emitter<TransactionsState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final filterString = prefs.getString(_lastFilterKey);
      
      if (filterString == null || filterString.isEmpty) {
        return;
      }
      
      // Parse the JSON and work with it directly without type casting the map
      final dynamic json = jsonDecode(filterString);
      
      // Extract type
      TransactionType? type;
      final typeValue = json['type']?.toString();
      if (typeValue == 'external_transfer') {
        type = TransactionType.externalTransfer;
      } else if (typeValue == 'internal_transfer') {
        type = TransactionType.internalTransfer;
      } else if (typeValue == 'topup') {
        type = TransactionType.topUp;
      }
      
      // Extract direction
      TransactionDirection? direction;
      final directionValue = json['direction']?.toString();
      if (directionValue == 'incoming') {
        direction = TransactionDirection.incoming;
      } else if (directionValue == 'outgoing') {
        direction = TransactionDirection.outgoing;
      }
      
      // Extract status
      TransactionStatus? status;
      final statusValue = json['status']?.toString();
      if (statusValue == 'completed') {
        status = TransactionStatus.completed;
      } else if (statusValue == 'pending') {
        status = TransactionStatus.pending;
      } else if (statusValue == 'failed') {
        status = TransactionStatus.failed;
      }
      
      // Extract dates
      DateTime? startDate, endDate;
      if (json['startDate'] is int) {
        startDate = DateTime.fromMillisecondsSinceEpoch(json['startDate'] as int);
      }
      if (json['endDate'] is int) {
        endDate = DateTime.fromMillisecondsSinceEpoch(json['endDate'] as int);
      }
      
      // Extract other fields
      String? counterpartyName = json['counterpartyName']?.toString();
      
      double? minAmount;
      if (json['minAmount'] != null) {
        minAmount = double.tryParse(json['minAmount'].toString());
      }
      
      double? maxAmount;
      if (json['maxAmount'] != null) {
        maxAmount = double.tryParse(json['maxAmount'].toString());
      }
      
      // Create and return the filter
      final loadedFilter = TransactionFilter(
        type: type,
        direction: direction,
        status: status,
        startDate: startDate,
        endDate: endDate,
        counterpartyName: counterpartyName,
        minAmount: minAmount,
        maxAmount: maxAmount,
      );
      
      add(TransactionsEvent.filtered(filter: loadedFilter));
    } catch (e) {
      // Return null in case of any error
    }
  }
  
  Future<void> _onLoadFilterPreservationSetting(
    TransactionsLoadFilterPreservationSetting event,
    Emitter<TransactionsState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final shouldPreserveFilters = prefs.getBool(_preserveFiltersKey) ?? false;
      
      emit(state.copyWith(
        shouldPreserveFilters: shouldPreserveFilters,
      ));
      
      // If we should preserve filters, load the last applied filter
      if (shouldPreserveFilters) {
        add(const TransactionsEvent.loadLastAppliedFilter());
      }
    } catch (e) {
      // In case of error, default to false
      emit(state.copyWith(shouldPreserveFilters: false));
    }
  }
  
  Future<void> _onShareReceipt(
    TransactionsShareReceipt event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(state.copyWith(isShareInProgress: true));
    
    try {
      final transaction = event.transaction;
      
      // Format transaction data into a receipt-like string
      final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');
      final formattedDate = dateFormat.format(transaction.created_at);
      
      final statusEmoji = transaction.isCompleted 
        ? '✅' 
        : transaction.isPending 
          ? '⏳' 
          : '❌';
      
      final receipt = '''
TRANSACTION RECEIPT $statusEmoji

$formattedDate
ID: ${transaction.id}

Transaction Type: ${transaction.transactionTypeDisplay}
Status: ${transaction.status.toUpperCase()}

Amount: ${transaction.currency} ${transaction.amount}
${transaction.hasFees ? 'Fee: ${transaction.currency} ${transaction.transaction_fees}' : ''}
Total: ${transaction.currency} ${transaction.totalAmount}

${transaction.isOutgoing ? 'Recipient' : 'Sender'}: ${transaction.counterparty_name ?? 'Not Available'}
${transaction.bank_code != null ? 'Bank: ${transaction.bank_code}' : ''}
${transaction.account_number != null ? 'Account: ${transaction.account_number}' : ''}

Reference: ${transaction.reference ?? 'Not Available'}
''';

      await Share.share(receipt, subject: 'Transaction Receipt');
    } catch (e) {
      // Error handled at UI level through state
    } finally {
      emit(state.copyWith(isShareInProgress: false));
    }
  }
  
  void _onAccountSelectorClosed(
    TransactionsAccountSelectorClosed event,
    Emitter<TransactionsState> emit,
  ) {
    emit(state.copyWith(shouldOpenAccountSelector: false));
  }
  
  void _onShowFilterDialog(
    TransactionsShowFilterDialog event,
    Emitter<TransactionsState> emit,
  ) {
    emit(state.copyWith(shouldShowFilterDialog: true));
  }
  
  // Method to hide filter dialog
  void hideFilterDialog() {
    emit(state.copyWith(shouldShowFilterDialog: false));
  }
} 