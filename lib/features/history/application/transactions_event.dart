part of 'transactions_bloc.dart';

@freezed
class TransactionsEvent with _$TransactionsEvent {
  // List events
  const factory TransactionsEvent.fetched() = TransactionsFetched;
  
  const factory TransactionsEvent.refreshed() = TransactionsRefreshed;
  
  const factory TransactionsEvent.filtered({
    required TransactionFilter filter,
  }) = TransactionsFiltered;
  
  const factory TransactionsEvent.loadMore() = TransactionsLoadMore;
  
  const factory TransactionsEvent.accountChanged({
    required int accountId,
  }) = TransactionsAccountChanged;

  // Filter-related events
  const factory TransactionsEvent.removeFilterType() = TransactionsRemoveFilterType;
  const factory TransactionsEvent.removeFilterDirection() = TransactionsRemoveFilterDirection;
  const factory TransactionsEvent.removeFilterStatus() = TransactionsRemoveFilterStatus;
  const factory TransactionsEvent.removeFilterDates() = TransactionsRemoveFilterDates;
  const factory TransactionsEvent.removeFilterCounterparty() = TransactionsRemoveFilterCounterparty;
  const factory TransactionsEvent.removeFilterAmounts() = TransactionsRemoveFilterAmounts;
  const factory TransactionsEvent.clearAllFilters() = TransactionsClearAllFilters;
  const factory TransactionsEvent.scrolledToBottom() = TransactionsScrolledToBottom;
  const factory TransactionsEvent.openAccountSelection() = TransactionsOpenAccountSelection;

  // Detail events
  const factory TransactionsEvent.detailFetched({
    required int transactionId,
    @Default(0) int accountId,
  }) = TransactionDetailFetched;
  
  const factory TransactionsEvent.detailSetFromCache({
    required Transaction transaction,
  }) = TransactionDetailSetFromCache;
  
  // New UI-specific events to move logic from UI to bloc
  const factory TransactionsEvent.saveFilterPreservation({
    required bool preserveFilters,
  }) = TransactionsSaveFilterPreservation;
  
  const factory TransactionsEvent.saveLastAppliedFilter({
    required TransactionFilter filter,
  }) = TransactionsSaveLastAppliedFilter;
  
  const factory TransactionsEvent.loadLastAppliedFilter() = TransactionsLoadLastAppliedFilter;
  
  const factory TransactionsEvent.loadFilterPreservationSetting() = TransactionsLoadFilterPreservationSetting;
  
  const factory TransactionsEvent.shareReceipt({
    required Transaction transaction,
  }) = TransactionsShareReceipt;
  
  const factory TransactionsEvent.accountSelectorClosed() = TransactionsAccountSelectorClosed;
  
  const factory TransactionsEvent.showFilterDialog() = TransactionsShowFilterDialog;
  
  // Scroll-related event
  const factory TransactionsEvent.scrollPositionChanged({
    required double scrollOffset,
    required double maxScrollExtent,
  }) = TransactionsScrollPositionChanged;
} 