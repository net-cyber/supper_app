// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransferResultImpl _$$TransferResultImplFromJson(Map<String, dynamic> json) =>
    _$TransferResultImpl(
      transactionId: json['transactionId'] as String,
      fromAccountNumber: const AccountNumberConverter()
          .fromJson(json['fromAccountNumber'] as String),
      toAccountNumber: const AccountNumberConverter()
          .fromJson(json['toAccountNumber'] as String),
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: json['status'] as String,
      reference: json['reference'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$TransferResultImplToJson(
        _$TransferResultImpl instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'fromAccountNumber':
          const AccountNumberConverter().toJson(instance.fromAccountNumber),
      'toAccountNumber':
          const AccountNumberConverter().toJson(instance.toAccountNumber),
      'amount': instance.amount,
      'currency': instance.currency,
      'timestamp': instance.timestamp.toIso8601String(),
      'status': instance.status,
      'reference': instance.reference,
      'description': instance.description,
    };
