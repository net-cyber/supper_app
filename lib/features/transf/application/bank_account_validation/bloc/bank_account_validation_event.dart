part of 'bank_account_validation_bloc.dart';

@freezed
class BankAccountValidationEvent with _$BankAccountValidationEvent {
  // Event to validate a bank account
  const factory BankAccountValidationEvent.validateBankAccount({
    required String bankCode,
    required String accountNumber,
  }) = ValidateBankAccount;

  // Event to reset the validation state
  const factory BankAccountValidationEvent.resetBankAccountValidation() = ResetBankAccountValidation;

  // Event to manually set an error
  const factory BankAccountValidationEvent.setBankAccountValidationError({
    required String message,
  }) = SetBankAccountValidationError;
} 