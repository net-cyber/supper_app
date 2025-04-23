import 'package:dartz/dartz.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/history/domain/entities/paginated_transactions.dart';
import 'package:super_app/features/history/domain/entities/transaction.dart';
import 'package:super_app/features/history/domain/entities/transaction_filter.dart';
import 'package:super_app/features/history/domain/entities/transaction_summary.dart';

abstract class TransactionRepository {
  /// Fetches a paginated list of transactions for a specific account
  Future<Either<NetworkExceptions, PaginatedTransactions>> getTransactions({
    required int pageId,
    required int pageSize,
    required int accountId,
    TransactionFilter? filter,
  });

  /// Fetches a specific transaction by ID
  Future<Either<NetworkExceptions, Transaction>> getTransactionById({
    required int transactionId,
    required int accountId,
  });

  /// Gets a summary of transactions for a specific account
  Future<Either<NetworkExceptions, TransactionSummary>> getTransactionSummary({
    required int accountId,
    DateTime? startDate,
    DateTime? endDate,
  });
} 
