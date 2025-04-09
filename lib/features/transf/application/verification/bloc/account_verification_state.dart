part of 'account_verification_bloc.dart';

@freezed
class AccountVerificationState with _$AccountVerificationState {
  const factory AccountVerificationState({
    required int accountId,
    required bool isVerifying,
    required bool isVerified,
    required bool verificationError,
    required String errorMessage,
    required String fullName,
  }) = _AccountVerificationState;

  factory AccountVerificationState.initial() => const AccountVerificationState(
        accountId: 0,
        isVerifying: false,
        isVerified: false,
        verificationError: false,
        errorMessage: '',
        fullName: '',
      );
}
