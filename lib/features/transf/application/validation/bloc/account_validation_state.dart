part of 'account_validation_bloc.dart';

@freezed
class AccountValidationState with _$AccountValidationState {
  const factory AccountValidationState({
    required int accountId,
    required double amount,
    required bool isValidating,
    required bool isValidated,
    required bool isSufficient,
    required bool validationError,
    required String errorMessage,
    required String message,
  }) = _AccountValidationState;

  factory AccountValidationState.initial() => const AccountValidationState(
        accountId: 0,
        amount: 0,
        isValidating: false,
        isValidated: false,
        isSufficient: false,
        validationError: false,
        errorMessage: '',
        message: '',
      );
}
