import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_code_response.freezed.dart';
part 'verification_code_response.g.dart';

@freezed
class VerificationCodeResponse with _$VerificationCodeResponse {
  const factory VerificationCodeResponse({
    required bool success,
    required String message,
    required String phone_number,
    required DateTime expires_at,
  }) = _VerificationCodeResponse;

  const VerificationCodeResponse._();

  factory VerificationCodeResponse.fromJson(Map<String, dynamic> json) => 
      _$VerificationCodeResponseFromJson(json);
} 