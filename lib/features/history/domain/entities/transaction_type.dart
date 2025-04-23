enum TransactionType {
  externalTransfer('external_transfer'),
  internalTransfer('internal_transfer'),
  topUp('top_up');

  final String value;
  const TransactionType(this.value);

  factory TransactionType.fromString(String value) {
    return TransactionType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => TransactionType.externalTransfer,
    );
  }
}

enum TransactionDirection {
  incoming('incoming'),
  outgoing('outgoing');

  final String value;
  const TransactionDirection(this.value);

  factory TransactionDirection.fromString(String value) {
    return TransactionDirection.values.firstWhere(
      (e) => e.value == value,
      orElse: () => TransactionDirection.outgoing,
    );
  }
}

enum TransactionStatus {
  completed('completed'),
  failed('failed'),
  pending('pending');

  final String value;
  const TransactionStatus(this.value);

  factory TransactionStatus.fromString(String value) {
    return TransactionStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => TransactionStatus.pending,
    );
  }
} 