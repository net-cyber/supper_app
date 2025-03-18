// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BankModelImpl _$$BankModelImplFromJson(Map<String, dynamic> json) =>
    _$BankModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      logoPath: json['logoPath'] as String,
      exchangeRate: (json['exchangeRate'] as num).toDouble(),
      giftPercentage: (json['giftPercentage'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$BankModelImplToJson(_$BankModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logoPath': instance.logoPath,
      'exchangeRate': instance.exchangeRate,
      'giftPercentage': instance.giftPercentage,
    };
