import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_summary.freezed.dart';
part 'transaction_summary.g.dart';

@freezed
class TransactionSummary with _$TransactionSummary {
  const factory TransactionSummary({
    required double totalIncoming,
    required double totalOutgoing,
    required int totalTransactions,
    required int successfulTransactions,
    required int failedTransactions,
    required double averageTransactionAmount,
    required Map<String, double> transactionsByType,
  }) = _TransactionSummary;

  const TransactionSummary._();

  factory TransactionSummary.fromJson(Map<String, dynamic> json) =>
      _$TransactionSummaryFromJson(json);
      
  double get netBalance => totalIncoming - totalOutgoing;
  
  double get successRate => 
      totalTransactions > 0 ? successfulTransactions / totalTransactions : 0;
} 