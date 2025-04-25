// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionFilterImpl _$$TransactionFilterImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionFilterImpl(
      type: $enumDecodeNullable(_$TransactionTypeEnumMap, json['type']),
      direction:
          $enumDecodeNullable(_$TransactionDirectionEnumMap, json['direction']),
      status: $enumDecodeNullable(_$TransactionStatusEnumMap, json['status']),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      counterpartyName: json['counterpartyName'] as String?,
      bankCode: json['bankCode'] as String?,
      minAmount: (json['minAmount'] as num?)?.toDouble(),
      maxAmount: (json['maxAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$TransactionFilterImplToJson(
        _$TransactionFilterImpl instance) =>
    <String, dynamic>{
      'type': _$TransactionTypeEnumMap[instance.type],
      'direction': _$TransactionDirectionEnumMap[instance.direction],
      'status': _$TransactionStatusEnumMap[instance.status],
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'counterpartyName': instance.counterpartyName,
      'bankCode': instance.bankCode,
      'minAmount': instance.minAmount,
      'maxAmount': instance.maxAmount,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.externalTransfer: 'externalTransfer',
  TransactionType.internalTransfer: 'internalTransfer',
  TransactionType.topUp: 'topUp',
};

const _$TransactionDirectionEnumMap = {
  TransactionDirection.incoming: 'incoming',
  TransactionDirection.outgoing: 'outgoing',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.completed: 'completed',
  TransactionStatus.failed: 'failed',
  TransactionStatus.pending: 'pending',
};
