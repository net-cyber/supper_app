// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransferResponseImpl _$$TransferResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$TransferResponseImpl(
      transferId: json['transfer_id'] as String,
      status: json['status'] as String,
      transactionRef: json['transaction_ref'] as String,
      timestamp: json['timestamp'] as String,
      amount: (json['amount'] as num).toDouble(),
      fromAccountId: json['from_account_id'] as String,
      toAccountId: json['to_account_id'] as String,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$TransferResponseImplToJson(
        _$TransferResponseImpl instance) =>
    <String, dynamic>{
      'transfer_id': instance.transferId,
      'status': instance.status,
      'transaction_ref': instance.transactionRef,
      'timestamp': instance.timestamp,
      'amount': instance.amount,
      'from_account_id': instance.fromAccountId,
      'to_account_id': instance.toAccountId,
      'message': instance.message,
    };

_$TransferImpl _$$TransferImplFromJson(Map<String, dynamic> json) =>
    _$TransferImpl(
      id: (json['id'] as num).toInt(),
      fromAccountId: (json['from_account_id'] as num).toInt(),
      toAccountId: (json['to_account_id'] as num).toInt(),
      amount: (json['amount'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$TransferImplToJson(_$TransferImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from_account_id': instance.fromAccountId,
      'to_account_id': instance.toAccountId,
      'amount': instance.amount,
      'created_at': instance.createdAt.toIso8601String(),
    };

_$AccountImpl _$$AccountImplFromJson(Map<String, dynamic> json) =>
    _$AccountImpl(
      id: (json['id'] as num).toInt(),
      owner: json['owner'] as String,
      balance: (json['balance'] as num).toDouble(),
      currency: json['currency'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$AccountImplToJson(_$AccountImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner': instance.owner,
      'balance': instance.balance,
      'currency': instance.currency,
      'created_at': instance.createdAt.toIso8601String(),
    };

_$EntryImpl _$$EntryImplFromJson(Map<String, dynamic> json) => _$EntryImpl(
      id: (json['id'] as num).toInt(),
      accountId: (json['account_id'] as num).toInt(),
      amount: (json['amount'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$EntryImplToJson(_$EntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_id': instance.accountId,
      'amount': instance.amount,
      'created_at': instance.createdAt.toIso8601String(),
    };
