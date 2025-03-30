import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_response.freezed.dart';
part 'registration_response.g.dart';

@freezed
class RegistrationResponse with _$RegistrationResponse {
  const factory RegistrationResponse({
    required String username,
    required String full_name,
    required String international_phone_number,
    required DateTime password_changed_at,
    required DateTime created_at,
  }) = _RegistrationResponse;

  const RegistrationResponse._();

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) => _$RegistrationResponseFromJson(json);
} 
