import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:super_app/features/transf/domain/entities/wallet_account.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

part 'wallet_transfer_state.freezed.dart';

@freezed
class WalletTransferState with _$WalletTransferState {
  // Add this private constructor for custom getters to work
  const WalletTransferState._();

  const factory WalletTransferState({
    // Basic state info
    required WalletTransferStatus status,

    // Form inputs
    @Default('') String phoneNumberInput,
    @Default('') String amountInput,
    @Default('') String reasonInput,

    // Wallet and provider data
    @Default([]) List<Map<String, dynamic>> providers,
    Map<String, dynamic>? selectedProvider,

    // Validated data
    WalletAccount? validatedWallet,
    double? calculatedFee,

    // Response data
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    String? transactionId,

    // Error handling
    String? errorMessage,
  }) = _WalletTransferState;

  factory WalletTransferState.initial() => const WalletTransferState(
        status: WalletTransferStatus.initial,
      );

  /// Helper methods to convert UI inputs to domain objects
  PhoneNumber? get phoneNumber =>
      phoneNumberInput.isEmpty ? null : PhoneNumber(phoneNumberInput);

  WalletProvider? get walletProvider => selectedProvider == null
      ? null
      : WalletProvider(selectedProvider!['name'] as String);

  Money? get amount =>
      amountInput.isEmpty ? null : Money.fromString(amount: amountInput);

  Money? get fee =>
      calculatedFee == null ? null : Money(amount: calculatedFee!);

  TransferReason? get reason =>
      reasonInput.isEmpty ? null : TransferReason(reasonInput);
}

/// Status of the wallet transfer flow
enum WalletTransferStatus {
  initial,
  loadingProviders,
  providersLoaded,
  providerSelected,
  validatingPhone,
  phoneValidated,
  phoneValidationFailed,
  calculatingFee,
  feeCalculated,
  submitting,
  success,
  failure
}
