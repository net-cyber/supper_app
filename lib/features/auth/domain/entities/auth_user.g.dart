// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthUserImpl _$$AuthUserImplFromJson(Map<String, dynamic> json) =>
    _$AuthUserImpl(
      username: json['username'] as String,
      full_name: json['full_name'] as String,
      international_phone_number: json['international_phone_number'] as String,
      password_changed_at:
          DateTime.parse(json['password_changed_at'] as String),
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$AuthUserImplToJson(_$AuthUserImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'full_name': instance.full_name,
      'international_phone_number': instance.international_phone_number,
      'password_changed_at': instance.password_changed_at.toIso8601String(),
      'created_at': instance.created_at.toIso8601String(),
    };
