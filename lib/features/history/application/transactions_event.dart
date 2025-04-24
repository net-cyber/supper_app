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

  // Detail events
  const factory TransactionsEvent.detailFetched({
    required int transactionId,
    @Default(0) int accountId,
  }) = TransactionDetailFetched;
  
  const factory TransactionsEvent.detailSetFromCache({
    required Transaction transaction,
  }) = TransactionDetailSetFromCache;
} 