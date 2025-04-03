import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:super_app/features/transf/domain/entities/bank_account.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

part 'internal_transfer_state.freezed.dart';

@freezed
class InternalTransferState with _$InternalTransferState {
  // Add this private constructor for custom getters to work
  const InternalTransferState._();

  const factory InternalTransferState({
    // Basic state info
    required InternalTransferStatus status,

    // Form inputs
    @Default('') String accountNumberInput,
    @Default('') String amountInput,
    @Default('') String reasonInput,

    // Validated data
    BankAccount? validatedAccount,

    // Response data
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    String? transactionId,

    // Error handling
    String? errorMessage,
  }) = _InternalTransferState;

  factory InternalTransferState.initial() => const InternalTransferState(
        status: InternalTransferStatus.initial,
      );

  /// Helper methods to convert UI inputs to domain objects
  AccountNumber? get accountNumber =>
      accountNumberInput.isEmpty ? null : AccountNumber(accountNumberInput);

  Money? get amount =>
      amountInput.isEmpty ? null : Money.fromString(amount: amountInput);

  TransferReason? get reason =>
      reasonInput.isEmpty ? null : TransferReason(reasonInput);

  /// Check if account has been validated
  bool get isAccountValidated =>
      status == InternalTransferStatus.accountValidated &&
      validatedAccount != null;

  /// Check if all required fields are filled for submission
  bool get canSubmit =>
      isAccountValidated && amount != null && amount!.isValid();
}

/// Status of the internal bank transfer flow
enum InternalTransferStatus {
  initial,
  validatingAccount,
  accountValidated,
  accountValidationFailed,
  submitting,
  success,
  failure
}
