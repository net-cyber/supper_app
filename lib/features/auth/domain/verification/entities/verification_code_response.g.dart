// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_code_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VerificationCodeResponseImpl _$$VerificationCodeResponseImplFromJson(
        Map<String, dynamic> json,) =>
    _$VerificationCodeResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      phone_number: json['phone_number'] as String,
      expires_at: DateTime.parse(json['expires_at'] as String),
    );

Map<String, dynamic> _$$VerificationCodeResponseImplToJson(
        _$VerificationCodeResponseImpl instance,) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'phone_number': instance.phone_number,
      'expires_at': instance.expires_at.toIso8601String(),
    };
