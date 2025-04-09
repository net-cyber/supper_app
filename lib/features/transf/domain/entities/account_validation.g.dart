// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_validation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountValidationImpl _$$AccountValidationImplFromJson(
        Map<String, dynamic> json) =>
    _$AccountValidationImpl(
      message: json['message'] as String,
      isSufficient: json['is_sufficient'] as bool,
    );

Map<String, dynamic> _$$AccountValidationImplToJson(
        _$AccountValidationImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'is_sufficient': instance.isSufficient,
    };
