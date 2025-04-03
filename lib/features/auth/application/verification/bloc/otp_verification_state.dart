part of 'otp_verification_bloc.dart';

@freezed
class OtpVerificationState with _$OtpVerificationState {
  const factory OtpVerificationState({
    required String otpCode,
    required String phoneNumber,
    required bool isVerifying,
    required bool isResending,
    required bool isVerified,
    required bool verificationError,
    required bool resendError,
    required bool resendSuccess,
    required String errorMessage,
    DateTime? expiresAt,
  }) = _OtpVerificationState;

  factory OtpVerificationState.initial() => const OtpVerificationState(
    otpCode: '',
    phoneNumber: '',
    isVerifying: false,
    isResending: false,
    isVerified: false,
    verificationError: false,
    resendError: false,
    resendSuccess: false,
    errorMessage: '',
  );
} 