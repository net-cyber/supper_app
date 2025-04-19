import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required String session_id,
    required String access_token,
    required DateTime access_token_expires_at,
    required String refresh_token,
    required DateTime refresh_token_expires_at,
    required LoginUser user,
  }) = _LoginResponse;

  const LoginResponse._();

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@freezed
class LoginUser with _$LoginUser {
  const factory LoginUser({
    required String username,
    required String full_name,
    required String avatar,
    required String token,
    required String international_phone_number,
    required bool phone_verified,
    required DateTime password_changed_at,
    required DateTime created_at,
  }) = _LoginUser;

  const LoginUser._();

  factory LoginUser.fromJson(Map<String, dynamic> json) =>
      _$LoginUserFromJson(json);
}
