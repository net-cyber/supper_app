part of 'otp_verification_bloc.dart';

@freezed
class OtpVerificationEvent with _$OtpVerificationEvent {
  const factory OtpVerificationEvent.otpCodeChanged(String otpCode) = OtpCodeChanged;
  const factory OtpVerificationEvent.verifyOtpSubmitted() = VerifyOtpSubmitted;
  const factory OtpVerificationEvent.resendOtpRequested() = ResendOtpRequested;
  const factory OtpVerificationEvent.phoneNumberSet(String phoneNumber) = PhoneNumberSet;
} 