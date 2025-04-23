import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/app_connectivity.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/accounts/domain/entities/account.dart';
import 'package:super_app/features/history/domain/entities/paginated_transactions.dart';
import 'package:super_app/features/history/domain/entities/transaction.dart';
import 'package:super_app/features/history/domain/entities/transaction_filter.dart';
import 'package:super_app/features/history/domain/repositories/transaction_repository.dart';

part 'transaction_history_event.dart';
part 'transaction_history_state.dart';
part 'transaction_history_bloc.freezed.dart';

@injectable
class TransactionHistoryBloc extends Bloc<TransactionHistoryEvent, TransactionHistoryState> {
  TransactionHistoryBloc(
    this._transactionRepository,
    this._accountsBloc,
  ) : super(TransactionHistoryState.initial()) {
    on<TransactionHistoryFetched>(_onTransactionHistoryFetched);
    on<TransactionHistoryRefreshed>(_onTransactionHistoryRefreshed);
    on<TransactionHistoryFiltered>(_onTransactionHistoryFiltered);
    on<TransactionHistoryLoadMore>(_onTransactionHistoryLoadMore);
    on<TransactionHistoryAccountChanged>(_onTransactionHistoryAccountChanged);
  }

  final TransactionRepository _transactionRepository;
  final AccountsBloc _accountsBloc;

  Future<void> _onTransactionHistoryFetched(
    TransactionHistoryFetched event,
    Emitter<TransactionHistoryState> emit,
  ) async {
    log('TransactionHistoryBloc: Fetching transaction history');

    // If we're already loading, don't do anything
    if (state.status == TransactionHistoryStatus.loading) {
      log('TransactionHistoryBloc: Already loading, ignoring fetch request');
      return;
    }

    // Set loading state
    emit(state.copyWith(status: TransactionHistoryStatus.loading));

    // Check internet connection
    final hasConnectivity = await AppConnectivity.connectivity();
    log('TransactionHistoryBloc: Internet connectivity check: $hasConnectivity');

    if (!hasConnectivity) {
      log('TransactionHistoryBloc: No internet connection');
      emit(
        state.copyWith(
          status: TransactionHistoryStatus.failure,
          errorMessage: 'No internet connection. Please check your network.',
        ),
      );
      return;
    }

    // Get active account
    int accountId = state.selectedAccountId;
    if (accountId <= 0) {
      log('TransactionHistoryBloc: No active account, getting from AccountsBloc');
      try {
        final accountsState = _accountsBloc.state;
        log('TransactionHistoryBloc: AccountsBloc state: ${accountsState.toString()}');
        log('TransactionHistoryBloc: Available accounts: ${accountsState.accounts.length}');
        
        if (accountsState.accounts.isNotEmpty) {
          accountId = accountsState.accounts.first.id;
          log('TransactionHistoryBloc: Using account ID: $accountId from AccountsBloc');
        } else {
          // Don't use a default account ID - pass 0 to indicate no account
          // The repository layer will handle this by not sending the account_id parameter
          log('TransactionHistoryBloc: No accounts available, will fetch transactions without account_id');
          accountId = 0;
        }
      } catch (e) {
        log('TransactionHistoryBloc: Error getting account: $e');
        // Don't use a default account ID - pass 0 to indicate no account
        log('TransactionHistoryBloc: Error accessing accounts, will fetch transactions without account_id');
        accountId = 0;
      }
    }

    try {
      log('TransactionHistoryBloc: Calling repository for account: $accountId');
      final result = await _transactionRepository.getTransactions(
        pageId: 1,
        pageSize: state.pageSize,
        accountId: accountId,
        filter: state.filter,
      );

      result.fold(
        (failure) {
          log('TransactionHistoryBloc: Failed to fetch transactions: ${failure.toString()}');
          emit(
            state.copyWith(
              status: TransactionHistoryStatus.failure,
              errorMessage: NetworkExceptions.getRawErrorMessage(failure),
            ),
          );
        },
        (paginatedTransactions) {
          log('TransactionHistoryBloc: Successfully fetched ${paginatedTransactions.transactions.length} transactions');
          emit(
            state.copyWith(
              status: TransactionHistoryStatus.success,
              paginatedTransactions: paginatedTransactions,
              selectedAccountId: accountId,
              currentPage: 1,
              hasReachedMax: paginatedTransactions.hasReachedMax,
              errorMessage: '',
            ),
          );
        },
      );
    } catch (e) {
      log('TransactionHistoryBloc: Unexpected error: $e');
      emit(
        state.copyWith(
          status: TransactionHistoryStatus.failure,
          errorMessage: 'An unexpected error occurred. Please try again later.',
        ),
      );
    }
  }

  Future<void> _onTransactionHistoryRefreshed(
    TransactionHistoryRefreshed event,
    Emitter<TransactionHistoryState> emit,
  ) async {
    log('TransactionHistoryBloc: Refreshing transaction history');
    
    emit(state.copyWith(
      status: TransactionHistoryStatus.initial,
      paginatedTransactions: null,
      currentPage: 1,
      hasReachedMax: false,
    ));
    
    add(const TransactionHistoryFetched());
  }

  Future<void> _onTransactionHistoryFiltered(
    TransactionHistoryFiltered event,
    Emitter<TransactionHistoryState> emit,
  ) async {
    log('TransactionHistoryBloc: Filtering transactions with ${event.filter}');
    
    emit(state.copyWith(
      filter: event.filter,
      status: TransactionHistoryStatus.initial,
      paginatedTransactions: null,
      currentPage: 1,
      hasReachedMax: false,
    ));
    
    add(const TransactionHistoryFetched());
  }

  Future<void> _onTransactionHistoryLoadMore(
    TransactionHistoryLoadMore event,
    Emitter<TransactionHistoryState> emit,
  ) async {
    log('TransactionHistoryBloc: Loading more transactions');
    
    // If we're already loading or have reached the max, don't do anything
    if (state.status == TransactionHistoryStatus.loading || 
        state.hasReachedMax ||
        state.status == TransactionHistoryStatus.initial) {
      log('TransactionHistoryBloc: Already loading or reached max, ignoring load more request');
      return;
    }

    // Set loading more state
    emit(state.copyWith(
      status: TransactionHistoryStatus.loadingMore,
    ));

    // Check internet connection
    final hasConnectivity = await AppConnectivity.connectivity();
    log('TransactionHistoryBloc: Internet connectivity check: $hasConnectivity');

    if (!hasConnectivity) {
      log('TransactionHistoryBloc: No internet connection');
      emit(
        state.copyWith(
          status: TransactionHistoryStatus.success, // Revert to success state but with existing data
          errorMessage: 'No internet connection. Please check your network.',
        ),
      );
      return;
    }

    try {
      final nextPage = state.currentPage + 1;
      log('TransactionHistoryBloc: Loading page $nextPage');
      
      // Get the account ID
      int accountId = state.selectedAccountId;
      log('TransactionHistoryBloc: Using accountId: $accountId for loading more');
      
      final result = await _transactionRepository.getTransactions(
        pageId: nextPage,
        pageSize: state.pageSize,
        accountId: accountId,
        filter: state.filter,
      );

      result.fold(
        (failure) {
          log('TransactionHistoryBloc: Failed to fetch more transactions: ${failure.toString()}');
          emit(
            state.copyWith(
              status: TransactionHistoryStatus.success, // Revert to success state but with existing data
              errorMessage: 'Failed to load more transactions. ${NetworkExceptions.getRawErrorMessage(failure)}',
            ),
          );
        },
        (newPaginatedTransactions) {
          log('TransactionHistoryBloc: Successfully fetched ${newPaginatedTransactions.transactions.length} more transactions');
          
          // Combine existing and new transactions
          final existingTransactions = state.paginatedTransactions?.transactions ?? [];
          final allTransactions = [...existingTransactions, ...newPaginatedTransactions.transactions];
          
          // Create a new paginated transactions object
          final updatedPaginatedTransactions = PaginatedTransactions(
            transactions: allTransactions,
            totalCount: allTransactions.length, // This is a placeholder
            currentPage: nextPage,
            pageSize: state.pageSize,
            hasReachedMax: newPaginatedTransactions.hasReachedMax,
          );
          
          emit(
            state.copyWith(
              status: TransactionHistoryStatus.success,
              paginatedTransactions: updatedPaginatedTransactions,
              currentPage: nextPage,
              hasReachedMax: newPaginatedTransactions.hasReachedMax,
              errorMessage: '',
            ),
          );
        },
      );
    } catch (e) {
      log('TransactionHistoryBloc: Unexpected error loading more: $e');
      emit(
        state.copyWith(
          status: TransactionHistoryStatus.success, // Revert to success state but with existing data
          errorMessage: 'An unexpected error occurred while loading more transactions.',
        ),
      );
    }
  }

  Future<void> _onTransactionHistoryAccountChanged(
    TransactionHistoryAccountChanged event,
    Emitter<TransactionHistoryState> emit,
  ) async {
    log('TransactionHistoryBloc: Account changed to ID: ${event.accountId}');
    
    emit(state.copyWith(
      selectedAccountId: event.accountId,
      status: TransactionHistoryStatus.initial,
      paginatedTransactions: null,
      currentPage: 1,
      hasReachedMax: false,
    ));
    
    add(const TransactionHistoryFetched());
  }
} 