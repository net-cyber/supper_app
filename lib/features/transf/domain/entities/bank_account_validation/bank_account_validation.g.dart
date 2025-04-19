// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account_validation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BankAccountValidationImpl _$$BankAccountValidationImplFromJson(
        Map<String, dynamic> json) =>
    _$BankAccountValidationImpl(
      bankCode: json['bankCode'] as String,
      accountNumber: json['accountNumber'] as String,
      accountName: json['accountName'] as String,
      found: json['found'] as bool,
      accountType: json['accountType'] as String? ?? '',
      branchName: json['branchName'] as String? ?? '',
    );

Map<String, dynamic> _$$BankAccountValidationImplToJson(
        _$BankAccountValidationImpl instance) =>
    <String, dynamic>{
      'bankCode': instance.bankCode,
      'accountNumber': instance.accountNumber,
      'accountName': instance.accountName,
      'found': instance.found,
      'accountType': instance.accountType,
      'branchName': instance.branchName,
    };
