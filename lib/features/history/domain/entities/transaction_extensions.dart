import 'package:super_app/features/history/domain/entities/transaction/transaction.dart';
import 'package:super_app/features/history/domain/entities/transaction_type.dart';

extension TransactionExtension on Transaction {
  bool get isIncoming => direction == TransactionDirection.incoming.value;
  bool get isOutgoing => direction == TransactionDirection.outgoing.value;
  
  bool get isCompleted => status == TransactionStatus.completed.value;
  bool get isFailed => status == TransactionStatus.failed.value;
  bool get isPending => status == TransactionStatus.pending.value;
  
  bool get isExternalTransfer => type == TransactionType.externalTransfer.value;
  bool get isInternalTransfer => type == TransactionType.internalTransfer.value;
  bool get isTopUp => type == TransactionType.topUp.value;
  
  String get formattedAmount {
    final prefix = isOutgoing ? '- ' : '+ ';
    return '$prefix$currency $amount';
  }
  
  bool get hasFees => transaction_fees != null && transaction_fees! > 0;
  
  double get totalAmount {
    if (isOutgoing && hasFees) {
      return amount + (transaction_fees ?? 0);
    }
    return amount;
  }
  
  String get transactionTypeDisplay {
    if (isExternalTransfer) return 'External Transfer';
    if (isInternalTransfer) return 'Internal Transfer';
    if (isTopUp) return 'Top-up';
    return 'Transaction';
  }
} 