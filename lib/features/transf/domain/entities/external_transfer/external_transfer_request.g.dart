// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'external_transfer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExternalTransferRequestImpl _$$ExternalTransferRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ExternalTransferRequestImpl(
      fromAccountId: (json['from_account_id'] as num).toInt(),
      toBankCode: json['to_bank_code'] as String,
      toAccountNumber: json['to_account_number'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$ExternalTransferRequestImplToJson(
        _$ExternalTransferRequestImpl instance) =>
    <String, dynamic>{
      'from_account_id': instance.fromAccountId,
      'to_bank_code': instance.toBankCode,
      'to_account_number': instance.toAccountNumber,
      'amount': instance.amount,
      'currency': instance.currency,
      'description': instance.description,
    };
