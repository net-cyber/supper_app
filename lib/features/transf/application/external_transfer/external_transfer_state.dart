import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:super_app/features/transf/domain/entities/bank_account.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

part 'external_transfer_state.freezed.dart';

@freezed
class ExternalTransferState with _$ExternalTransferState {
  // Add this private constructor for custom getters to work
  const ExternalTransferState._();

  const factory ExternalTransferState({
    // Basic state info
    required ExternalTransferStatus status,

    // Bank selection data
    @Default([]) List<Map<String, dynamic>> banks,
    Map<String, dynamic>? selectedBank,

    // Form inputs
    @Default('') String accountNumberInput,
    @Default('') String amountInput,
    @Default('') String reasonInput,

    // Validated data
    BankAccount? validatedAccount,
    double? calculatedFee,

    // Response data
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    String? transactionId,

    // Error handling
    String? errorMessage,
  }) = _ExternalTransferState;

  factory ExternalTransferState.initial() => const ExternalTransferState(
        status: ExternalTransferStatus.initial,
      );

  /// Helper methods to convert UI inputs to domain objects
  AccountNumber? get accountNumber =>
      accountNumberInput.isEmpty ? null : AccountNumber(accountNumberInput);

  BankCode? get bankCode =>
      selectedBank == null ? null : BankCode(selectedBank!['code'] as String);

  Money? get amount =>
      amountInput.isEmpty ? null : Money.fromString(amount: amountInput);

  Money? get fee =>
      calculatedFee == null ? null : Money(amount: calculatedFee!);

  TransferReason? get reason =>
      reasonInput.isEmpty ? null : TransferReason(reasonInput);

  /// Check if a bank has been selected
  bool get isBankSelected =>
      status == ExternalTransferStatus.bankSelected && selectedBank != null;

  /// Check if account has been validated
  bool get isAccountValidated =>
      status == ExternalTransferStatus.accountValidated &&
      validatedAccount != null;

  /// Check if all required fields are filled for submission
  bool get canSubmit =>
      isAccountValidated && amount != null && amount!.isValid() && fee != null;
}

/// Status of the external bank transfer flow
enum ExternalTransferStatus {
  initial,
  loadingBanks,
  banksLoaded,
  bankSelected,
  validatingAccount,
  accountValidated,
  accountValidationFailed,
  calculatingFee,
  feeCalculated,
  submitting,
  success,
  failure
}
