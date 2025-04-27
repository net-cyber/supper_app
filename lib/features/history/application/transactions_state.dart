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
  
  const FilterLabel({
    required this.label,
    required this.type,
  });
}

@freezed
class TransactionsState with _$TransactionsState {
  const factory TransactionsState({
    // List status
    required TransactionsListStatus listStatus,
    required PaginatedTransactions? paginatedTransactions,
    required int currentPage,
    required int pageSize,
    required bool hasReachedMax,
    required String listErrorMessage,
    required int accountId,
    
    // Filter-related state
    required TransactionFilter? filter,
    required List<FilterLabel> activeFilterLabels,
    required bool isFilterActive,
    required bool shouldOpenAccountSelector,
    
    // Detail status
    required TransactionsDetailStatus detailStatus,
    required Transaction? selectedTransaction,
    required String detailErrorMessage,
    
    // New UI-related state properties
    required bool shouldPreserveFilters,
    required bool shouldShowFilterDialog,
    required bool isShareInProgress,
  }) = _TransactionsState;

  factory TransactionsState.initial() => const TransactionsState(
        listStatus: TransactionsListStatus.initial,
        paginatedTransactions: null,
        currentPage: 1,
        pageSize: 20,
        hasReachedMax: false,
        listErrorMessage: '',
        accountId: 0,
        
        filter: null,
        activeFilterLabels: [],
        isFilterActive: false,
        shouldOpenAccountSelector: false,
        
        detailStatus: TransactionsDetailStatus.initial,
        selectedTransaction: null,
        detailErrorMessage: '',
        
        // Initialize new UI-related state properties
        shouldPreserveFilters: false,
        shouldShowFilterDialog: false,
        isShareInProgress: false,
      );
} 