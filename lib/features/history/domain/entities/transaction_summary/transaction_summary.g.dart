// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionSummaryImpl _$$TransactionSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionSummaryImpl(
      totalIncoming: (json['totalIncoming'] as num).toDouble(),
      totalOutgoing: (json['totalOutgoing'] as num).toDouble(),
      totalTransactions: (json['totalTransactions'] as num).toInt(),
      successfulTransactions: (json['successfulTransactions'] as num).toInt(),
      failedTransactions: (json['failedTransactions'] as num).toInt(),
      averageTransactionAmount:
          (json['averageTransactionAmount'] as num).toDouble(),
      transactionsByType:
          (json['transactionsByType'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$$TransactionSummaryImplToJson(
        _$TransactionSummaryImpl instance) =>
    <String, dynamic>{
      'totalIncoming': instance.totalIncoming,
      'totalOutgoing': instance.totalOutgoing,
      'totalTransactions': instance.totalTransactions,
      'successfulTransactions': instance.successfulTransactions,
      'failedTransactions': instance.failedTransactions,
      'averageTransactionAmount': instance.averageTransactionAmount,
      'transactionsByType': instance.transactionsByType,
    };
