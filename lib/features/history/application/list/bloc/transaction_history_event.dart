part of 'transaction_history_bloc.dart';

@freezed
class TransactionHistoryEvent with _$TransactionHistoryEvent {
  const factory TransactionHistoryEvent.fetched() = TransactionHistoryFetched;
  
  const factory TransactionHistoryEvent.refreshed() = TransactionHistoryRefreshed;
  
  const factory TransactionHistoryEvent.filtered({
    required TransactionFilter filter,
  }) = TransactionHistoryFiltered;
  
  const factory TransactionHistoryEvent.loadMore() = TransactionHistoryLoadMore;
  
  const factory TransactionHistoryEvent.accountChanged({
    required int accountId,
  }) = TransactionHistoryAccountChanged;
} 