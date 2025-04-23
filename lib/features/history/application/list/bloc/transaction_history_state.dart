part of 'transaction_history_bloc.dart';

enum TransactionHistoryStatus {
  initial,
  loading,
  loadingMore,
  success,
  failure,
}

@freezed
class TransactionHistoryState with _$TransactionHistoryState {
  const factory TransactionHistoryState({
    @Default(TransactionHistoryStatus.initial) TransactionHistoryStatus status,
    PaginatedTransactions? paginatedTransactions,
    @Default(1) int currentPage,
    @Default(10) int pageSize,
    @Default(false) bool hasReachedMax,
    @Default('') String errorMessage,
    @Default(0) int selectedAccountId,
    TransactionFilter? filter,
  }) = _TransactionHistoryState;

  factory TransactionHistoryState.initial() => const TransactionHistoryState();
} 