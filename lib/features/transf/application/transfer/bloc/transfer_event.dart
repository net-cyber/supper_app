part of 'transfer_bloc.dart';

@freezed
class TransferEvent with _$TransferEvent {
  const factory TransferEvent.transferDetailsChanged({
    required int fromAccountId,
    required int toAccountId,
    required double amount,
    required String currency,
  }) = TransferDetailsChanged;

  const factory TransferEvent.createTransferSubmitted() =
      CreateTransferSubmitted;
}
