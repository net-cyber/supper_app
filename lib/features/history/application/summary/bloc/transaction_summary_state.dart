part of 'transaction_summary_bloc.dart';

enum TransactionSummaryStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class TransactionSummaryState with _$TransactionSummaryState {
  const factory TransactionSummaryState({
    @Default(TransactionSummaryStatus.initial) TransactionSummaryStatus status,
    TransactionSummary? summary,
    @Default(0) int accountId,
    DateTime? startDate,
    DateTime? endDate,
    @Default('') String errorMessage,
  }) = _TransactionSummaryState;

  factory TransactionSummaryState.initial() => const TransactionSummaryState();
} 