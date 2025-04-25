// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_transactions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginatedTransactionsImpl _$$PaginatedTransactionsImplFromJson(
        Map<String, dynamic> json) =>
    _$PaginatedTransactionsImpl(
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num).toInt(),
      currentPage: (json['currentPage'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      hasReachedMax: json['hasReachedMax'] as bool? ?? false,
    );

Map<String, dynamic> _$$PaginatedTransactionsImplToJson(
        _$PaginatedTransactionsImpl instance) =>
    <String, dynamic>{
      'transactions': instance.transactions,
      'totalCount': instance.totalCount,
      'currentPage': instance.currentPage,
      'pageSize': instance.pageSize,
      'hasReachedMax': instance.hasReachedMax,
    };
