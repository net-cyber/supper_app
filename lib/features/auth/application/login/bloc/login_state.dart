import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:super_app/core/value_object/value_objects.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required Username username,
    required Password password,
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
    @Default(false) bool isLoginError,
    @Default(false) bool showErrorMessages,
    @Default(false) bool showPassword,
  }) = _LoginState;

  const LoginState._();
} 