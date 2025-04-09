part of 'account_validation_bloc.dart';

@freezed
class AccountValidationEvent with _$AccountValidationEvent {
  const factory AccountValidationEvent.accountDetailsChanged({
    required int accountId,
    required double amount,
  }) = AccountDetailsChanged;

  const factory AccountValidationEvent.validateAccountSubmitted() =
      ValidateAccountSubmitted;
}
