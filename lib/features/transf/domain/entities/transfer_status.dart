/// Represents the status of a transfer
enum TransferStatus {
  /// Transfer is being processed by the system
  pending,

  /// Transfer was completed successfully
  completed,

  /// Transfer failed due to some error
  failed,

  /// Transfer was rejected by the receiver or the banking system
  rejected,

  /// Transfer is awaiting approval from the sender or receiver
  awaitingApproval,

  /// Transfer is canceled by the sender
  canceled;

  /// Get a human-readable string representation of the status
  String get displayName {
    switch (this) {
      case TransferStatus.pending:
        return 'Pending';
      case TransferStatus.completed:
        return 'Completed';
      case TransferStatus.failed:
        return 'Failed';
      case TransferStatus.rejected:
        return 'Rejected';
      case TransferStatus.awaitingApproval:
        return 'Awaiting Approval';
      case TransferStatus.canceled:
        return 'Canceled';
    }
  }

  /// Get a color code for UI display based on status
  String get colorCode {
    switch (this) {
      case TransferStatus.pending:
        return '#FFA500'; // Orange
      case TransferStatus.completed:
        return '#008000'; // Green
      case TransferStatus.failed:
        return '#FF0000'; // Red
      case TransferStatus.rejected:
        return '#FF0000'; // Red
      case TransferStatus.awaitingApproval:
        return '#0000FF'; // Blue
      case TransferStatus.canceled:
        return '#808080'; // Gray
    }
  }

  /// Check if the transfer is in a final state (no more status changes expected)
  bool get isFinal =>
      this == TransferStatus.completed ||
      this == TransferStatus.failed ||
      this == TransferStatus.rejected ||
      this == TransferStatus.canceled;
}
