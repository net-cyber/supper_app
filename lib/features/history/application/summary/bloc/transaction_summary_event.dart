part of 'transaction_summary_bloc.dart';

@freezed
class TransactionSummaryEvent with _$TransactionSummaryEvent {
  const factory TransactionSummaryEvent.fetched() = TransactionSummaryFetched;
  
  const factory TransactionSummaryEvent.dateRangeChanged({
    DateTime? startDate,
    DateTime? endDate,
  }) = TransactionSummaryDateRangeChanged;
  
  const factory TransactionSummaryEvent.accountChanged({
    required int accountId,
  }) = TransactionSummaryAccountChanged;
} 