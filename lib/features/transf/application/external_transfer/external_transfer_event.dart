import 'package:freezed_annotation/freezed_annotation.dart';

part 'external_transfer_event.freezed.dart';

@freezed
class ExternalTransferEvent with _$ExternalTransferEvent {
  // Add private constructor for Freezed
  const ExternalTransferEvent._();

  // Bank selection events
  const factory ExternalTransferEvent.loadBanks() = LoadBanks;
  const factory ExternalTransferEvent.bankSelected(Map<String, dynamic> bank) =
      BankSelected;

  // User input events
  const factory ExternalTransferEvent.accountNumberChanged(
      String accountNumber) = AccountNumberChanged;
  const factory ExternalTransferEvent.validateAccount() = ValidateAccount;
  const factory ExternalTransferEvent.amountChanged(String amount) =
      AmountChanged;
  const factory ExternalTransferEvent.calculateFee() = CalculateFee;
  const factory ExternalTransferEvent.reasonChanged(String reason) =
      ReasonChanged;

  // Action events
  const factory ExternalTransferEvent.submitTransfer() = SubmitTransfer;

  // Reset and navigation events
  const factory ExternalTransferEvent.reset() = Reset;
}
