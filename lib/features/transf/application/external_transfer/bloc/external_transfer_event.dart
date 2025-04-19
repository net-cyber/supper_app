part of 'external_transfer_bloc.dart';

@freezed
class ExternalTransferEvent with _$ExternalTransferEvent {
  const factory ExternalTransferEvent.transferDetailsChanged({
    required int fromAccountId,
    required String toBankCode,
    required String toAccountNumber,
    required double amount,
    required String currency,
    String? description,
  }) = TransferDetailsChanged;

  const factory ExternalTransferEvent.createTransferSubmitted() = CreateTransferSubmitted;
} 