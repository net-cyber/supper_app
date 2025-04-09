part of 'account_verification_bloc.dart';

@freezed
class AccountVerificationEvent with _$AccountVerificationEvent {
  const factory AccountVerificationEvent.accountIdChanged(int accountId) =
      AccountIdChanged;
  const factory AccountVerificationEvent.verifyAccountSubmitted() =
      VerifyAccountSubmitted;
}
