part of 'transactions_bloc.dart';

enum TransactionsListStatus {
  initial,
  loading,
  loadingMore,
  success,
  failure,
}

enum TransactionsDetailStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class TransactionsState with _$TransactionsState {
  const factory TransactionsState({
    // List status
    @Default(TransactionsListStatus.initial) TransactionsListStatus listStatus,
    @Default('') String listErrorMessage,
    
    // Detail status
    @Default(TransactionsDetailStatus.initial) TransactionsDetailStatus detailStatus,
    @Default('') String detailErrorMessage,
    
    // Common data
    @Default(0) int accountId,
    
    // List data
    PaginatedTransactions? paginatedTransactions,
    @Default(1) int currentPage,
    @Default(5) int pageSize,
    @Default(false) bool hasReachedMax,
    TransactionFilter? filter,
    
    // Detail data
    Transaction? selectedTransaction,
  }) = _TransactionsState;

  factory TransactionsState.initial() => const TransactionsState();
} 