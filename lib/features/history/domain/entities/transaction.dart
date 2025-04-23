import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required int id,
    required String type,
    required String direction,
    required double amount,
    required String currency,
    required String status,
    String? reference,
    String? counterparty_name,
    String? bank_code,
    String? account_number,
    double? transaction_fees,
    int? counterparty_id,
    String? description,
    required DateTime created_at,
  }) = _Transaction;

  const Transaction._();

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
} 