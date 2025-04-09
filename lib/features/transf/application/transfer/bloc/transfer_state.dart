part of 'transfer_bloc.dart';

@freezed
class TransferState with _$TransferState {
  const factory TransferState({
    required int fromAccountId,
    required int toAccountId,
    required double amount,
    required String currency,
    required bool isTransferring,
    required bool isTransferred,
    required bool transferError,
    required String errorMessage,
    String? transferId,
    String? status,
    String? transactionRef,
    String? timestamp,
    TransferResponse? transferResponse,
  }) = _TransferState;

  factory TransferState.initial() => const TransferState(
        fromAccountId: 0,
        toAccountId: 0,
        amount: 0,
        currency: 'ETB',
        isTransferring: false,
        isTransferred: false,
        transferError: false,
        errorMessage: '',
      );
}
