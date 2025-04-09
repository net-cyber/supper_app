import 'package:dartz/dartz.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/transfer_response.dart';

/// Repository interface for transfer operations
abstract class TransferRepository {
  /// Creates a transfer from one account to another
  ///
  /// Returns a [TransferResponse] on success, or a [NetworkExceptions] on error
  /// [fromAccountId] is the account ID to transfer from
  /// [toAccountId] is the account ID to transfer to
  /// [amount] is the amount to transfer
  /// [currency] is the currency of the transfer (e.g., "ETB")
  Future<Either<NetworkExceptions, TransferResponse>> createTransfer({
    required int fromAccountId,
    required int toAccountId,
    required double amount,
    required String currency,
  });
}
