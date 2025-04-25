import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/history/domain/entities/paginated_transactions/paginated_transactions.dart';
import 'package:super_app/features/history/domain/entities/transaction/transaction.dart';
import 'package:super_app/features/history/domain/entities/transaction_filter/transaction_filter.dart';
import 'package:super_app/features/history/domain/entities/transaction_summary/transaction_summary.dart';
import 'package:super_app/features/history/domain/repositories/transaction_repository.dart';
import 'package:super_app/features/history/infrastructure/datasources/transactions_remote_data_source.dart';

@Injectable(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl(this._remoteDataSource);

  final TransactionsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<NetworkExceptions, PaginatedTransactions>> getTransactions({
    required int pageId,
    required int pageSize,
    required int accountId,
    TransactionFilter? filter,
  }) async {
    try {
      final transactions = await _remoteDataSource.getTransactions(
        pageId: pageId,
        pageSize: pageSize,
        accountId: accountId,
        filter: filter,
      );
      return right(transactions);
    } on DioException catch (e) {
      return left(NetworkExceptions.getDioException(e));
    } catch (e) {
      return left(NetworkExceptions.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkExceptions, Transaction>> getTransactionById({
    required int transactionId,
    required int accountId,
  }) async {
    try {
      final transaction = await _remoteDataSource.getTransactionById(
        transactionId: transactionId,
        accountId: accountId,
      );
      return right(transaction);
    } on DioException catch (e) {
      return left(NetworkExceptions.getDioException(e));
    } catch (e) {
      return left(NetworkExceptions.unexpectedError());
    }
  }

  @override
  Future<Either<NetworkExceptions, TransactionSummary>> getTransactionSummary({
    required int accountId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final summary = await _remoteDataSource.getTransactionSummary(
        accountId: accountId,
        startDate: startDate,
        endDate: endDate,
      );
      return right(summary);
    } on DioException catch (e) {
      return left(NetworkExceptions.getDioException(e));
    } catch (e) {
      return left(NetworkExceptions.unexpectedError());
    }
  }
} 