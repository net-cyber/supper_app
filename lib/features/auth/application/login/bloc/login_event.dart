import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.freezed.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.usernameChanged(String username) = UsernameChanged;
  const factory LoginEvent.passwordChanged(String password) = PasswordChanged;
  const factory LoginEvent.toggleShowPassword() = ToggleShowPassword;
  const factory LoginEvent.loginSubmitted() = LoginSubmitted;
} 