import 'package:super_app/features/auth/application/registration/bloc/registration_state.dart';

class RegistrationFormValidator {
  static String? validateUserName(RegistrationState state) {
    if (state.showErrorMessages && !state.userName.isValid()) {
      return state.userName.value.fold(
        (failure) => failure.failedValue,
        (_) => null,
      );
    }
    return null;
  }
  
  static String? validateFullName(RegistrationState state) {
    if (state.showErrorMessages && !state.fullName.isValid()) {
      return state.fullName.value.fold(
        (failure) => failure.failedValue,
        (_) => null,
      );
    }
    return null;
  }
  
  static String? validatePhoneNumber(RegistrationState state) {
    if (state.showErrorMessages && !state.phoneNumber.isValid()) {
      return state.phoneNumber.value.fold(
        (failure) => failure.failedValue,
        (_) => null,
      );
    }
    return null;
  }
  
  
  static String? validatePassword(RegistrationState state) {
    if (state.showErrorMessages && !state.password.isValid()) {
      return state.password.value.fold(
        (failure) => failure.failedValue,
        (_) => null,
      );
    }
    return null;
  }
  
  static String? validateConfirmPassword(RegistrationState state) {
    if (state.showErrorMessages && !state.confirmPassword.isValid()) {
      return state.confirmPassword.value.fold(
        (failure) => failure.failedValue,
        (_) => null,
      );
    }
    return null;
  }
  
  
  static String? validateTermsAcceptance(RegistrationState state) {
    if (state.showErrorMessages && !state.termsAcceptance.isValid()) {
      return state.termsAcceptance.value.fold(
        (failure) => failure.failedValue.toString(),
        (_) => null,
      );
    }
    return null;
  }
} 