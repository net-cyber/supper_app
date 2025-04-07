import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/features/transf/domain/entities/bank_account.dart';
import 'package:super_app/features/transf/domain/entities/transaction.dart';
import 'package:super_app/features/transf/domain/entities/transaction_request.dart';
import 'package:super_app/features/transf/domain/entities/transaction_response.dart';
import 'package:super_app/features/transf/domain/entities/transfer.dart';
import 'package:super_app/features/transf/domain/entities/transfer_status.dart';
import 'package:super_app/features/transf/domain/repositories/transfer_repository.dart';
import 'package:super_app/features/transf/domain/value_objects/failures.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';
import 'package:super_app/features/transf/infrastructure/datasources/transfer_remote_data_source.dart';

@Injectable(as: TransferRepository)
@prod // This will only be used in production mode, not in development/testing
class RealTransferRepository implements TransferRepository {
  final TransferRemoteDataSource _remoteDataSource;

  RealTransferRepository(this._remoteDataSource);

  @override
  Future<Either<TransferFailure<dynamic>, Transaction>>
      initiateInternalTransfer({
    required AccountNumber receiverAccountNumber,
    required Money amount,
    required String senderName,
    required String receiverName,
    required String bankName,
    TransferReason? reason,
  }) async {
    try {
      // Convert domain entities to API request
      final request = TransactionRequest(
        from_account_id: 1, // Assuming the sender's account ID is 1
        to_account_id: int.tryParse(receiverAccountNumber.getOrElse('0')) ?? 0,
        amount: amount.getOrElse(0.0),
        currency: 'USD', // Using USD as default currency
      );

      // Call the API
      final response = await _remoteDataSource.initiateTransfer(request);

      // Create a transfer entity with the response data
      final transfer = InternalBankTransfer(
        id: TransferId.fromString("TX-API-${response.transfer.id}"),
        receiverAccountNumber: receiverAccountNumber,
        amount: Money(amount: response.transfer.amount),
        timestamp: response.transfer.created_at,
        reason: reason,
        senderName: senderName,
        receiverName: receiverName,
        bankName: bankName,
      );

      // Create a successful transaction
      final transaction = Transaction(
        transfer: transfer,
        status: TransferStatus.completed,
        createdAt: response.transfer.created_at,
        completedAt: response.transfer.created_at,
      );

      return right(transaction);
    } on DioException catch (e) {
      // Map Dio errors to domain failures
      if (e.response?.statusCode == 400) {
        return left(TransferFailure.invalidInput(
          failedValue: 'API request',
          message: e.response?.data?['error']?.toString() ?? 'Invalid request',
        ));
      } else if (e.response?.statusCode == 401) {
        return left(const TransferFailure.unauthenticated());
      } else if (e.response?.statusCode == 403) {
        return left(const TransferFailure.unauthorized());
      } else if (e.response?.statusCode == 404) {
        return left(TransferFailure.accountNotFound(
          failedValue: receiverAccountNumber.getOrElse(''),
        ));
      } else if (e.response?.statusCode == 409) {
        return left(TransferFailure.insufficientFunds(
          failedValue: amount.getOrElse(0.0),
          available: 0.0, // Ideally, get this from the response
        ));
      } else {
        return left(TransferFailure.serverError(
          message: e.response?.data?['error']?.toString() ?? 'Server error',
        ));
      }
    } catch (e) {
      return left(const TransferFailure.unexpected());
    }
  }

  @override
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
  }) async {
    // External transfers would be implemented similarly but with additional routing information
    // For now, we'll use the same internal transfer method
    return initiateInternalTransfer(
      receiverAccountNumber: receiverAccountNumber,
      amount: amount,
      senderName: senderName,
      receiverName: receiverName,
      bankName: bankName,
      reason: reason,
    );
  }

  // Implement other methods from the TransferRepository interface
  // with stubs or delegating to the mock repository for now

  @override
  Future<Either<TransferFailure<dynamic>, Money>> calculateExternalTransferFee(
    Money amount,
    BankCode bankCode,
  ) async {
    // For now, return a fixed fee
    return right(Money(amount: 5.0));
  }

  @override
  Future<Either<TransferFailure<dynamic>, Transaction>> cancelTransaction(
    TransferId id,
  ) async {
    // Not implemented in the current API
    return left(const TransferFailure.unexpected());
  }

  @override
  Future<Either<TransferFailure<dynamic>, List<Transaction>>>
      getAllTransactions() async {
    // Get transaction history would be implemented with a GET request to /transfers
    return right([]);
  }

  @override
  Future<Either<TransferFailure<dynamic>, List<Transaction>>>
      getRecentTransactions({int limit = 10}) async {
    // Would fetch the most recent transactions from the API
    return right([]);
  }

  @override
  Future<Either<TransferFailure<dynamic>, Transaction>> getTransactionById(
    TransferId id,
  ) async {
    // Would fetch a specific transaction by ID
    return left(const TransferFailure.unexpected());
  }

  @override
  Future<Either<TransferFailure<dynamic>, List<Transaction>>>
      getTransactionHistory() async {
    // Transaction history would be fetched from the API
    return right([]);
  }

  @override
  Future<Either<TransferFailure<dynamic>, List<Transaction>>>
      getPendingTransactions() async {
    // Pending transactions would be fetched from the API
    return right([]);
  }

  @override
  Future<Either<TransferFailure<dynamic>, Transaction>>
      updateTransactionStatus({
    required TransferId id,
    required TransferStatus newStatus,
    String? failureReason,
  }) async {
    // Would update transaction status via API
    return left(const TransferFailure.unexpected());
  }

  @override
  Future<Either<TransferFailure<dynamic>, Transaction>> initiateWalletTransfer({
    required PhoneNumber receiverPhone,
    required WalletProvider walletProvider,
    required Money amount,
    required Money fee,
    required String senderName,
    String? receiverName,
    TransferReason? reason,
  }) async {
    // Wallet transfers would be implemented with a different API endpoint
    return left(const TransferFailure.unexpected());
  }

  @override
  Future<Either<TransferFailure<dynamic>, Transaction>>
      transferToInternalAccount({
    required BankAccount fromAccount,
    required BankAccount toAccount,
    required Money amount,
    required String reason,
  }) async {
    return initiateInternalTransfer(
      receiverAccountNumber: toAccount.accountNumber,
      amount: amount,
      senderName: fromAccount.accountHolderName,
      receiverName: toAccount.accountHolderName,
      bankName: toAccount.bankName,
      reason: TransferReason(reason),
    );
  }

  @override
  Future<Either<TransferFailure<dynamic>, Transaction>>
      transferToExternalAccount({
    required BankAccount fromAccount,
    required BankAccount toAccount,
    required Money amount,
    required String reason,
  }) async {
    final fee = await calculateExternalTransferFee(amount, toAccount.bankCode);

    return fee.fold(
      (failure) => left(failure),
      (calculatedFee) => initiateExternalTransfer(
        receiverAccountNumber: toAccount.accountNumber,
        bankCode: toAccount.bankCode,
        amount: amount,
        fee: calculatedFee,
        senderName: fromAccount.accountHolderName,
        receiverName: toAccount.accountHolderName,
        bankName: toAccount.bankName,
        reason: TransferReason(reason),
      ),
    );
  }
}
