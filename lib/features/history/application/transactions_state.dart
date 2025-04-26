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

/// Enum to identify the type of filter label
enum FilterLabelType {
  type,
  direction,
  status,
  dates,
  counterparty,
  amounts,
}

/// Class to represent a filter label with its type for UI display
class FilterLabel {
  final String label;
  final FilterLabelType type;
  
  FilterLabel({
    required this.label,
    required this.type,
  });
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
    
    // Filter related data
    @Default(false) bool isFilterActive,
    @Default([]) List<FilterLabel> activeFilterLabels,
    
    // UI state flags
    @Default(false) bool shouldOpenAccountSelector,
    
    // Detail data
    Transaction? selectedTransaction,
  }) = _TransactionsState;

  factory TransactionsState.initial() => const TransactionsState();
} 