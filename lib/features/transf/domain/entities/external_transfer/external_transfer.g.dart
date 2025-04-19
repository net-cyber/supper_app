// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'external_transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExternalTransferImpl _$$ExternalTransferImplFromJson(
        Map<String, dynamic> json) =>
    _$ExternalTransferImpl(
      id: (json['id'] as num).toInt(),
      fromAccountId: (json['from_account_id'] as num).toInt(),
      toBankCode: json['to_bank_code'] as String,
      toAccountNumber: json['to_account_number'] as String,
      recipientName: json['recipient_name'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: json['status'] as String,
      reference: json['reference'] as String,
      description: json['description'] as String,
      transactionId: json['transaction_id'] as String,
      transactionFees: (json['transaction_fees'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ExternalTransferImplToJson(
        _$ExternalTransferImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from_account_id': instance.fromAccountId,
      'to_bank_code': instance.toBankCode,
      'to_account_number': instance.toAccountNumber,
      'recipient_name': instance.recipientName,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': instance.status,
      'reference': instance.reference,
      'description': instance.description,
      'transaction_id': instance.transactionId,
      'transaction_fees': instance.transactionFees,
      'created_at': instance.createdAt.toIso8601String(),
    };
