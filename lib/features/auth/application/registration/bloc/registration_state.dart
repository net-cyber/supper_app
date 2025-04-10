import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:super_app/core/value_object/value_objects.dart';

part 'registration_state.freezed.dart';

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
    required UserName userName,
    required FullName fullName,
    required PhoneNumber phoneNumber,
    required EmailAddress emailAddress,
    required Password password,
    required ConfirmPassword confirmPassword,
    required ReferralCode referralCode,
    required TermsAcceptance termsAcceptance,
    @Default(false) bool isLoading,
    @Default(false) bool isRegistrationError,
    @Default(false) bool showErrorMessages,
    @Default(false) bool showPassword,
    @Default(false) bool showConfirmPassword,
    @Default('') String errorMessage,
    @Default(0.0) double passwordStrength,
  }) = _RegistrationState;

  const RegistrationState._();

  bool get isPasswordValid => password.isValid();
  bool get isFormValid => 
    userName.isValid() &&
    fullName.isValid() &&
    phoneNumber.isValid() &&
    emailAddress.isValid() &&
    password.isValid() &&
    confirmPassword.isValid() &&
    termsAcceptance.isValid();
} 