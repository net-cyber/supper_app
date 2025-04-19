import 'package:super_app/features/transf/domain/entities/transfer.dart';
import 'package:super_app/features/transf/domain/entities/transfer_status.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

/// Represents a transaction in the system, composed of a transfer and its status
class Transaction {
  final Transfer transfer;
  final TransferStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? failureReason;

  const Transaction({
    required this.transfer,
    required this.status,
    required this.createdAt,
    this.completedAt,
    this.failureReason,
  });

  /// Check if the transaction is completed
  bool get isCompleted => status == TransferStatus.completed;

  /// Check if the transaction failed
  bool get isFailed =>
      status == TransferStatus.failed || status == TransferStatus.rejected;

  /// Check if the transaction is still in progress
  bool get isInProgress =>
      status == TransferStatus.pending ||
      status == TransferStatus.awaitingApproval;

  /// Get transaction type based on transfer type
  String get type {
    if (transfer is InternalBankTransfer) {
      return 'Internal Bank Transfer';
    } else if (transfer is ExternalBankTransfer) {
      return 'External Bank Transfer';
    } else if (transfer is WalletTransfer) {
      return 'Wallet Load';
    } else {
      return 'Unknown Transfer';
    }
  }

  /// Create a new transaction with an updated status
  Transaction copyWithStatus(
    TransferStatus newStatus, {
    DateTime? newCompletedAt,
    String? newFailureReason,
  }) {
    return Transaction(
      transfer: transfer,
      status: newStatus,
      createdAt: createdAt,
      completedAt: newCompletedAt ??
          (newStatus == TransferStatus.completed
              ? DateTime.now()
              : completedAt),
      failureReason: newFailureReason ?? failureReason,
    );
  }

  /// Get a summary of the transaction for display
  String get summary {
    final amount = transfer.amount.formatted;
    String recipient;

    if (transfer is InternalBankTransfer) {
      final internalTransfer = transfer as InternalBankTransfer;
      recipient =
          '${internalTransfer.receiverName} (${internalTransfer.bankName})';
    } else if (transfer is ExternalBankTransfer) {
      final externalTransfer = transfer as ExternalBankTransfer;
      recipient =
          '${externalTransfer.receiverName} (${externalTransfer.bankName})';
    } else if (transfer is WalletTransfer) {
      final walletTransfer = transfer as WalletTransfer;
      recipient =
          '${walletTransfer.receiverName ?? walletTransfer.receiverPhone.getOrElse('')} (${walletTransfer.walletProvider.getOrElse('')})';
    } else {
      recipient = 'Unknown recipient';
    }

    return 'Sent $amount to $recipient - ${status.displayName}';
  }
}
