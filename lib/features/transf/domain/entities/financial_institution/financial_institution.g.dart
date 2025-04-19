// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_institution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FinancialInstitutionImpl _$$FinancialInstitutionImplFromJson(
        Map<String, dynamic> json) =>
    _$FinancialInstitutionImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      type: json['type'] as String,
      logoUrl: json['logoUrl'] as String?,
      description: json['description'] as String?,
      active: json['active'] as bool? ?? true,
    );

Map<String, dynamic> _$$FinancialInstitutionImplToJson(
        _$FinancialInstitutionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'type': instance.type,
      'logoUrl': instance.logoUrl,
      'description': instance.description,
      'active': instance.active,
    };
