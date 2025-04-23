import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:super_app/features/history/domain/entities/transaction_type.dart';

part 'transaction_filter.freezed.dart';
part 'transaction_filter.g.dart';

@freezed
class TransactionFilter with _$TransactionFilter {
  const factory TransactionFilter({
    TransactionType? type,
    TransactionDirection? direction,
    TransactionStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    String? counterpartyName,
    String? bankCode,
    double? minAmount,
    double? maxAmount,
  }) = _TransactionFilter;

  const TransactionFilter._();

  factory TransactionFilter.fromJson(Map<String, dynamic> json) =>
      _$TransactionFilterFromJson(json);
} 