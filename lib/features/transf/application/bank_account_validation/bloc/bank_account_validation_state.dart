part of 'bank_account_validation_bloc.dart';

@freezed
class BankAccountValidationState with _$BankAccountValidationState {
  const factory BankAccountValidationState({
    required bool isLoading,
    required bool isValid,
    BankAccountValidation? validationResult,
    required bool hasError,
    required String errorMessage,
  }) = _BankAccountValidationState;

  factory BankAccountValidationState.initial() => const BankAccountValidationState(
        isLoading: false,
        isValid: false,
        validationResult: null,
        hasError: false,
        errorMessage: '',
      );
} 