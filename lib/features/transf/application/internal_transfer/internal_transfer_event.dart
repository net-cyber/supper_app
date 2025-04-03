import 'package:freezed_annotation/freezed_annotation.dart';

part 'internal_transfer_event.freezed.dart';

@freezed
class InternalTransferEvent with _$InternalTransferEvent {
  // Add private constructor for Freezed
  const InternalTransferEvent._();

  // User input events
  const factory InternalTransferEvent.accountNumberChanged(
      String accountNumber) = AccountNumberChanged;
  const factory InternalTransferEvent.validateAccount() = ValidateAccount;
  const factory InternalTransferEvent.amountChanged(String amount) =
      AmountChanged;
  const factory InternalTransferEvent.reasonChanged(String reason) =
      ReasonChanged;

  // Action events
  const factory InternalTransferEvent.submitTransfer() = SubmitTransfer;

  // Reset and navigation events
  const factory InternalTransferEvent.reset() = Reset;
}
