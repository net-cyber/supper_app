part of 'transaction_detail_bloc.dart';

@freezed
class TransactionDetailEvent with _$TransactionDetailEvent {
  const factory TransactionDetailEvent.fetched({
    required int transactionId,
    @Default(0) int accountId,
  }) = TransactionDetailFetched;
  
  const factory TransactionDetailEvent.setFromCache({
    required Transaction transaction,
  }) = TransactionDetailSetFromCache;
} 