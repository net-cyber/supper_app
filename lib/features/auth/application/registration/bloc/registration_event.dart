import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_event.freezed.dart';

@freezed
class RegistrationEvent with _$RegistrationEvent {
  const factory RegistrationEvent.userNameChanged(String userName) = UserNameChanged;
  const factory RegistrationEvent.fullNameChanged(String fullName) = FullNameChanged;
  const factory RegistrationEvent.phoneNumberChanged(String phoneNumber) = PhoneNumberChanged;
  const factory RegistrationEvent.emailChanged(String email) = EmailChanged;
  const factory RegistrationEvent.passwordChanged(String password) = PasswordChanged;
  const factory RegistrationEvent.confirmPasswordChanged(String confirmPassword) = ConfirmPasswordChanged;
  const factory RegistrationEvent.referralCodeChanged(String referralCode) = ReferralCodeChanged;
  const factory RegistrationEvent.termsAcceptedChanged(bool accepted) = TermsAcceptedChanged;
  const factory RegistrationEvent.toggleShowPassword() = ToggleShowPassword;
  const factory RegistrationEvent.toggleShowConfirmPassword() = ToggleShowConfirmPassword;
  const factory RegistrationEvent.registrationSubmitted() = RegistrationSubmitted;
} 