// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_confirm_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VerificationConfirmResponseImpl _$$VerificationConfirmResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$VerificationConfirmResponseImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      phone_number: json['phone_number'] as String,
      phone_verified: json['phone_verified'] as bool,
    );

Map<String, dynamic> _$$VerificationConfirmResponseImplToJson(
        _$VerificationConfirmResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'phone_number': instance.phone_number,
      'phone_verified': instance.phone_verified,
    };
