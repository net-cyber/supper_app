// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginResponseImpl _$$LoginResponseImplFromJson(Map<String, dynamic> json) =>
    _$LoginResponseImpl(
      session_id: json['session_id'] as String,
      access_token: json['access_token'] as String,
      access_token_expires_at:
          DateTime.parse(json['access_token_expires_at'] as String),
      refresh_token: json['refresh_token'] as String,
      refresh_token_expires_at:
          DateTime.parse(json['refresh_token_expires_at'] as String),
      user: LoginUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LoginResponseImplToJson(_$LoginResponseImpl instance) =>
    <String, dynamic>{
      'session_id': instance.session_id,
      'access_token': instance.access_token,
      'access_token_expires_at':
          instance.access_token_expires_at.toIso8601String(),
      'refresh_token': instance.refresh_token,
      'refresh_token_expires_at':
          instance.refresh_token_expires_at.toIso8601String(),
      'user': instance.user,
    };

_$LoginUserImpl _$$LoginUserImplFromJson(Map<String, dynamic> json) =>
    _$LoginUserImpl(
      username: json['username'] as String,
      full_name: json['full_name'] as String,
      international_phone_number: json['international_phone_number'] as String,
      phone_verified: json['phone_verified'] as bool,
      password_changed_at:
          DateTime.parse(json['password_changed_at'] as String),
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$LoginUserImplToJson(_$LoginUserImpl instance) =>
    <String, dynamic>{
      'username': instance.username,
      'full_name': instance.full_name,
      'international_phone_number': instance.international_phone_number,
      'phone_verified': instance.phone_verified,
      'password_changed_at': instance.password_changed_at.toIso8601String(),
      'created_at': instance.created_at.toIso8601String(),
    };
