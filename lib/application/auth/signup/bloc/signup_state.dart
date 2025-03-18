import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:super_app/domain/auth/value_objects.dart';

part 'signup_state.freezed.dart';

@freezed
class SignupState with _$SignupState {
  const factory SignupState({
    required EmailAddress email, required Password password, required ConfirmPassword confirmPassword, required FullName fullName, @Default(false) bool isLoading,
    @Default(false) bool isSignupError,
    @Default(false) bool showErrorMessages,
    @Default('') String country,
    @Default(false) bool showPassword,
    @Default(false) bool showConfirmPassword,
    @Default(false) bool termsAccepted,
  }) = _SignupState;

  const SignupState._();
} 