part of 'external_transfer_bloc.dart';

@freezed
class ExternalTransferState with _$ExternalTransferState {
  const factory ExternalTransferState({
    @Default(0) int fromAccountId,
    @Default('') String toBankCode,
    @Default('') String toAccountNumber,
    @Default(0.0) double amount,
    @Default('ETB') String currency,
    String? description,
    @Default(false) bool isTransferring,
    @Default(false) bool transferError,
    @Default('') String errorMessage,
    @Default(false) bool isTransferred,
    ExternalTransfer? transferResponse,
  }) = _ExternalTransferState;

  factory ExternalTransferState.initial() => const ExternalTransferState();
} 