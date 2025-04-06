import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_confirm_response.freezed.dart';
part 'verification_confirm_response.g.dart';

@freezed
class VerificationConfirmResponse with _$VerificationConfirmResponse {
  const factory VerificationConfirmResponse({
    required bool success,
    required String message,
    required String phone_number,
    required bool phone_verified,
  }) = _VerificationConfirmResponse;

  const VerificationConfirmResponse._();

  factory VerificationConfirmResponse.fromJson(Map<String, dynamic> json) => 
      _$VerificationConfirmResponseFromJson(json);
} 