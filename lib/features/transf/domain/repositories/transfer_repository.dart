import 'package:dartz/dartz.dart';
import 'package:super_app/features/transf/domain/entities/transaction.dart';
import 'package:super_app/features/transf/domain/entities/transfer.dart';
import 'package:super_app/features/transf/domain/entities/transfer_status.dart';
import 'package:super_app/features/transf/domain/value_objects/failures.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

/// Repository interface for transfer operations
abstract class TransferRepository {
  /// Initiate an internal bank transfer
  Future<Either<TransferFailure<dynamic>, Transaction>>
      initiateInternalTransfer({
    required AccountNumber receiverAccountNumber,
    required Money amount,
    required String senderName,
    required String receiverName,
    required String bankName,
    TransferReason? reason,
  });

  /// Initiate an external bank transfer
  Future<Either<TransferFailure<dynamic>, Transaction>>
      initiateExternalTransfer({
    required AccountNumber receiverAccountNumber,
    required BankCode bankCode,
    required Money amount,
    required Money fee,
    required String senderName,
    required String receiverName,
    required String bankName,
    TransferReason? reason,
  });

  /// Initiate a wallet transfer (load to wallet)
  Future<Either<TransferFailure<dynamic>, Transaction>> initiateWalletTransfer({
    required PhoneNumber receiverPhone,
    required WalletProvider walletProvider,
    required Money amount,
    required Money fee,
    required String senderName,
    String? receiverName,
    TransferReason? reason,
  });

  /// Calculate the fee for an external bank transfer
  Future<Either<TransferFailure<dynamic>, Money>> calculateExternalTransferFee(
    Money amount,
    BankCode bankCode,
  );

  /// Get a transaction by its ID
  Future<Either<TransferFailure<dynamic>, Transaction>> getTransactionById(
      TransferId id);

  /// Get all transactions for the current user
  Future<Either<TransferFailure<dynamic>, List<Transaction>>>
      getAllTransactions();

  /// Get recent transactions for the current user (with optional limit)
  Future<Either<TransferFailure<dynamic>, List<Transaction>>>
      getRecentTransactions({int limit = 10});

  /// Update the status of a transaction
  Future<Either<TransferFailure<dynamic>, Transaction>>
      updateTransactionStatus({
    required TransferId id,
    required TransferStatus newStatus,
    String? failureReason,
  });

  /// Cancel a pending transaction
  Future<Either<TransferFailure<dynamic>, Transaction>> cancelTransaction(
      TransferId id);
}
