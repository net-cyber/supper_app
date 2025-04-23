// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionImpl _$$TransactionImplFromJson(Map<String, dynamic> json) =>
    _$TransactionImpl(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      direction: json['direction'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: json['status'] as String,
      reference: json['reference'] as String?,
      counterparty_name: json['counterparty_name'] as String?,
      bank_code: json['bank_code'] as String?,
      account_number: json['account_number'] as String?,
      transaction_fees: (json['transaction_fees'] as num?)?.toDouble(),
      counterparty_id: (json['counterparty_id'] as num?)?.toInt(),
      description: json['description'] as String?,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$TransactionImplToJson(_$TransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'direction': instance.direction,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': instance.status,
      'reference': instance.reference,
      'counterparty_name': instance.counterparty_name,
      'bank_code': instance.bank_code,
      'account_number': instance.account_number,
      'transaction_fees': instance.transaction_fees,
      'counterparty_id': instance.counterparty_id,
      'description': instance.description,
      'created_at': instance.created_at.toIso8601String(),
    };
