import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_transfer_event.freezed.dart';

@freezed
class WalletTransferEvent with _$WalletTransferEvent {
  // Add private constructor for Freezed
  const WalletTransferEvent._();

  // Initial loading events
  const factory WalletTransferEvent.loadWalletProviders() = LoadWalletProviders;

  // User input events
  const factory WalletTransferEvent.selectWalletProvider(
      Map<String, dynamic> provider) = SelectWalletProvider;
  const factory WalletTransferEvent.phoneNumberChanged(String phoneNumber) =
      PhoneNumberChanged;
  const factory WalletTransferEvent.validatePhoneNumber() = ValidatePhoneNumber;
  const factory WalletTransferEvent.amountChanged(String amount) =
      AmountChanged;
  const factory WalletTransferEvent.calculateFee() = CalculateFee;
  const factory WalletTransferEvent.reasonChanged(String reason) =
      ReasonChanged;

  // Action events
  const factory WalletTransferEvent.submitTransfer() = SubmitTransfer;

  // Reset and navigation events
  const factory WalletTransferEvent.reset() = Reset;
}
