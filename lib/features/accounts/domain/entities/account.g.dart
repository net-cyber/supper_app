// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountImpl _$$AccountImplFromJson(Map<String, dynamic> json) =>
    _$AccountImpl(
      id: (json['id'] as num).toInt(),
      owner: json['owner'] as String,
      balance: (json['balance'] as num).toDouble(),
      currency: json['currency'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$AccountImplToJson(_$AccountImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner': instance.owner,
      'balance': instance.balance,
      'currency': instance.currency,
      'created_at': instance.created_at.toIso8601String(),
    };
