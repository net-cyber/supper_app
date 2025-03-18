import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_event.freezed.dart';

@freezed
abstract class SignupEvent with _$SignupEvent {
  // We pass raw string values in events, which will be converted to value objects in the bloc
  const factory SignupEvent.emailChanged(String email) = EmailChanged;
  const factory SignupEvent.passwordChanged(String password) = PasswordChanged;
  const factory SignupEvent.confirmPasswordChanged(String confirmPassword) = ConfirmPasswordChanged;
  const factory SignupEvent.fullNameChanged(String fullName) = FullNameChanged;
  const factory SignupEvent.countryChanged(String country) = CountryChanged;
  const factory SignupEvent.toggleShowPassword() = ToggleShowPassword;
  const factory SignupEvent.toggleShowConfirmPassword() = ToggleShowConfirmPassword;
  const factory SignupEvent.termsAcceptedChanged(bool accepted) = TermsAcceptedChanged;
  const factory SignupEvent.signupSubmitted() = SignupSubmitted;
} 