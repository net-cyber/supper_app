part of 'transaction_detail_bloc.dart';

enum TransactionDetailStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class TransactionDetailState with _$TransactionDetailState {
  const factory TransactionDetailState({
    @Default(TransactionDetailStatus.initial) TransactionDetailStatus status,
    Transaction? transaction,
    @Default('') String errorMessage,
  }) = _TransactionDetailState;

  factory TransactionDetailState.initial() => const TransactionDetailState();
} 