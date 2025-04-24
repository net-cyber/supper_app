import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/app_connectivity.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_event.dart';
import 'package:super_app/features/history/domain/entities/paginated_transactions.dart';
import 'package:super_app/features/history/domain/entities/transaction.dart';
import 'package:super_app/features/history/domain/entities/transaction_filter.dart';
import 'package:super_app/features/history/domain/repositories/transaction_repository.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';
part 'transactions_bloc.freezed.dart';

/// A combined bloc for handling both transaction list and detail operations
@singleton
class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionRepository _transactionRepository;
  final AccountsBloc _accountsBloc;

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
  }

  // Static method to initialize the state with the account ID from AccountsBloc
  static TransactionsState _initializeState(AccountsBloc accountsBloc) {
    int accountId = 0; // Initialize with 0, will be updated if accounts are available
    try {
      final accountsState = accountsBloc.state;
      log('TransactionsBloc: Initializing with AccountsBloc state: ${accountsState.toString()}');
      
      if (accountsState.accounts.isNotEmpty) {
        accountId = accountsState.accounts.first.id;
        log('TransactionsBloc: Initialized with account ID: $accountId from AccountsBloc');
      } else {
        // Try to trigger account loading if not already loading
        if (!accountsState.isLoading) {
          accountsBloc.add(const AccountsEvent.fetchAccounts());
          log('TransactionsBloc: Triggered account loading');
        }
        log('TransactionsBloc: No accounts available during initialization, will require user to select an account or refresh');
      }
    } catch (e) {
      log('TransactionsBloc: Error getting account during initialization: $e');
    }
    
    return TransactionsState.initial().copyWith(accountId: accountId);
  }

  // List event handlers
  Future<void> _onTransactionsFetched(
    TransactionsFetched event,
    Emitter<TransactionsState> emit,
  ) async {
    log('TransactionsBloc: Fetching transaction history');

    // If we're already loading, don't do anything
    if (state.listStatus == TransactionsListStatus.loading) {
      log('TransactionsBloc: Already loading, ignoring fetch request');
      return;
    }

    // Set loading state for list
    emit(state.copyWith(listStatus: TransactionsListStatus.loading));

    // Check internet connection
    final hasConnectivity = await AppConnectivity.connectivity();
    log('TransactionsBloc: Internet connectivity check: $hasConnectivity');

    if (!hasConnectivity) {
      log('TransactionsBloc: No internet connection');
      emit(
        state.copyWith(
          listStatus: TransactionsListStatus.failure,
          listErrorMessage: 'No internet connection. Please check your network.',
        ),
      );
      return;
    }

    // Get active account ID
    int accountId = state.accountId;
    
    // If we don't have a valid account ID, try to get one
    if (accountId <= 0) {
      try {
        final accountsState = _accountsBloc.state;
        log('TransactionsBloc: AccountsBloc state: ${accountsState.toString()}');
        
        // Check if we have accounts available
        if (accountsState.accounts.isNotEmpty) {
          // Use the account ID from AccountsBloc
          accountId = accountsState.accounts.first.id;
          log('TransactionsBloc: Using account ID: $accountId from AccountsBloc');
        } else {
          // No accounts available
          log('TransactionsBloc: No accounts available in AccountsBloc');
          emit(
            state.copyWith(
              listStatus: TransactionsListStatus.failure,
              listErrorMessage: 'No accounts available. Please add an account or try again later.',
            ),
          );
          return;
        }
      } catch (e) {
        log('TransactionsBloc: Error getting account: $e');
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
      log('TransactionsBloc: Calling repository for account: $accountId');
      final result = await _transactionRepository.getTransactions(
        pageId: 1,
        pageSize: state.pageSize,
        accountId: accountId,
        filter: state.filter,
      );

      result.fold(
        (failure) {
          log('TransactionsBloc: Failed to fetch transactions: ${failure.toString()}');
          emit(
            state.copyWith(
              listStatus: TransactionsListStatus.failure,
              listErrorMessage: NetworkExceptions.getRawErrorMessage(failure),
            ),
          );
        },
        (paginatedTransactions) {
          log('TransactionsBloc: Successfully fetched ${paginatedTransactions.transactions.length} transactions');
          emit(
            state.copyWith(
              listStatus: TransactionsListStatus.success,
              paginatedTransactions: paginatedTransactions,
              accountId: accountId,
              currentPage: 1,
              hasReachedMax: paginatedTransactions.hasReachedMax,
              listErrorMessage: '',
            ),
          );
        },
      );
    } catch (e) {
      log('TransactionsBloc: Unexpected error: $e');
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
    log('TransactionsBloc: Refreshing transaction history');
    
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
    log('TransactionsBloc: Filtering transactions with ${event.filter}');
    
    emit(state.copyWith(
      filter: event.filter,
      listStatus: TransactionsListStatus.initial,
      paginatedTransactions: null,
      currentPage: 1,
      hasReachedMax: false,
    ));
    
    add(const TransactionsEvent.fetched());
  }

  Future<void> _onTransactionsLoadMore(
    TransactionsLoadMore event,
    Emitter<TransactionsState> emit,
  ) async {
    log('TransactionsBloc: Loading more transactions');
    
    // If we're already loading or have reached the max, don't do anything
    if (state.listStatus == TransactionsListStatus.loading || 
        state.listStatus == TransactionsListStatus.loadingMore ||
        state.hasReachedMax ||
        state.listStatus == TransactionsListStatus.initial) {
      log('TransactionsBloc: Already loading or reached max, ignoring load more request');
      return;
    }

    // Get account ID
    if (state.accountId <= 0) {
      log('TransactionsBloc: No valid account ID for loading more');
      emit(
        state.copyWith(
          listStatus: TransactionsListStatus.failure,
          listErrorMessage: 'No valid account found. Please refresh and try again.',
        ),
      );
      return;
    }
    
    final accountId = state.accountId;
    log('TransactionsBloc: Using account ID for loading more: $accountId');

    // Set loading more state
    emit(state.copyWith(
      listStatus: TransactionsListStatus.loadingMore,
    ));

    // Check internet connection
    final hasConnectivity = await AppConnectivity.connectivity();
    log('TransactionsBloc: Internet connectivity check: $hasConnectivity');

    if (!hasConnectivity) {
      log('TransactionsBloc: No internet connection');
      emit(
        state.copyWith(
          listStatus: TransactionsListStatus.success, // Revert to success state but with existing data
          listErrorMessage: 'No internet connection. Please check your network.',
        ),
      );
      return;
    }

    try {
      // Make sure we have existing transactions to append to
      final existingTransactions = state.paginatedTransactions?.transactions ?? [];
      if (existingTransactions.isEmpty) {
        log('TransactionsBloc: No existing transactions, fetching from beginning');
        add(const TransactionsEvent.fetched());
        return;
      }

      final nextPage = state.currentPage + 1;
      log('TransactionsBloc: Loading page $nextPage for account ID: $accountId');
      
      final result = await _transactionRepository.getTransactions(
        pageId: nextPage,
        pageSize: state.pageSize,
        accountId: accountId,
        filter: state.filter,
      );

      result.fold(
        (failure) {
          log('TransactionsBloc: Failed to fetch more transactions: ${failure.toString()}');
          emit(
            state.copyWith(
              listStatus: TransactionsListStatus.success, // Revert to success state but with existing data
              listErrorMessage: 'Failed to load more transactions. ${NetworkExceptions.getRawErrorMessage(failure)}',
              hasReachedMax: true, // Assume we've reached the max to prevent further attempts
            ),
          );
        },
        (newPaginatedTransactions) {
          log('TransactionsBloc: Successfully fetched ${newPaginatedTransactions.transactions.length} more transactions');
          
          final newTransactions = newPaginatedTransactions.transactions;
          
          // If we got no new transactions or fewer than requested, we've reached the end
          final hasReachedMax = newTransactions.isEmpty || newTransactions.length < state.pageSize;
          
          if (newTransactions.isEmpty) {
            log('TransactionsBloc: No more transactions available');
            emit(
              state.copyWith(
                listStatus: TransactionsListStatus.success,
                hasReachedMax: true,
                listErrorMessage: '',
              ),
            );
            return;
          }
          
          // Combine existing and new transactions
          final allTransactions = [...existingTransactions, ...newTransactions];
          
          // Create a new paginated transactions object
          final updatedPaginatedTransactions = PaginatedTransactions(
            transactions: allTransactions,
            totalCount: allTransactions.length, // This is a placeholder
            currentPage: nextPage,
            pageSize: state.pageSize,
            hasReachedMax: hasReachedMax,
          );
          
          emit(
            state.copyWith(
              listStatus: TransactionsListStatus.success,
              paginatedTransactions: updatedPaginatedTransactions,
              currentPage: nextPage,
              hasReachedMax: hasReachedMax,
              listErrorMessage: '',
            ),
          );
        },
      );
    } catch (e) {
      log('TransactionsBloc: Unexpected error loading more: $e');
      emit(
        state.copyWith(
          listStatus: TransactionsListStatus.success, // Revert to success state but with existing data
          listErrorMessage: 'An unexpected error occurred while loading more transactions.',
          hasReachedMax: true, // Assume we've reached the max to prevent further attempts
        ),
      );
    }
  }

  Future<void> _onTransactionsAccountChanged(
    TransactionsAccountChanged event,
    Emitter<TransactionsState> emit,
  ) async {
    log('TransactionsBloc: Account changed to ID: ${event.accountId}');
    
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
    log('TransactionsBloc: Fetching transaction detail for ID: ${event.transactionId}');

    // Set loading state for detail
    emit(state.copyWith(detailStatus: TransactionsDetailStatus.loading));

    // Check internet connection
    final hasConnectivity = await AppConnectivity.connectivity();
    log('TransactionsBloc: Internet connectivity check: $hasConnectivity');

    if (!hasConnectivity) {
      log('TransactionsBloc: No internet connection');
      emit(
        state.copyWith(
          detailStatus: TransactionsDetailStatus.failure,
          detailErrorMessage: 'No internet connection. Please check your network.',
        ),
      );
      return;
    }

    // Get active account ID
    int accountId = event.accountId > 0 ? event.accountId : state.accountId;
    
    // If we still don't have an account ID, try to get one from AccountsBloc
    if (accountId <= 0) {
      try {
        final accountsState = _accountsBloc.state;
        if (accountsState.accounts.isNotEmpty) {
          accountId = accountsState.accounts.first.id;
          log('TransactionsBloc: Using account ID: $accountId');
        } else {
          log('TransactionsBloc: No accounts available');
          emit(
            state.copyWith(
              detailStatus: TransactionsDetailStatus.failure,
              detailErrorMessage: 'No accounts available. Please add an account first.',
            ),
          );
          return;
        }
      } catch (e) {
        log('TransactionsBloc: Error getting account: $e');
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
      log('TransactionsBloc: Calling repository for transaction ID: ${event.transactionId}, account ID: $accountId');
      final result = await _transactionRepository.getTransactionById(
        transactionId: event.transactionId,
        accountId: accountId,
      );

      result.fold(
        (failure) {
          log('TransactionsBloc: Failed to fetch transaction detail: ${failure.toString()}');
          emit(
            state.copyWith(
              detailStatus: TransactionsDetailStatus.failure,
              detailErrorMessage: NetworkExceptions.getRawErrorMessage(failure),
            ),
          );
        },
        (transaction) {
          log('TransactionsBloc: Successfully fetched transaction detail');
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
      log('TransactionsBloc: Unexpected error: $e');
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
    log('TransactionsBloc: Setting transaction detail from cache');
    emit(
      state.copyWith(
        detailStatus: TransactionsDetailStatus.success,
        selectedTransaction: event.transaction,
        detailErrorMessage: '',
      ),
    );
  }
} 