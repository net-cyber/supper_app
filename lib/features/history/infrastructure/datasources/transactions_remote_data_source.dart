import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/handlers/http_service.dart';
import 'package:super_app/features/history/domain/entities/paginated_transactions.dart';
import 'package:super_app/features/history/domain/entities/transaction.dart';
import 'package:super_app/features/history/domain/entities/transaction_filter.dart';
import 'package:super_app/features/history/domain/entities/transaction_summary.dart';

abstract class TransactionsRemoteDataSource {
  Future<PaginatedTransactions> getTransactions({
    required int pageId,
    required int pageSize,
    required int accountId,
    TransactionFilter? filter,
  });

  Future<Transaction> getTransactionById({
    required int transactionId,
    required int accountId,
  });

  Future<TransactionSummary> getTransactionSummary({
    required int accountId,
    DateTime? startDate,
    DateTime? endDate,
  });
}

@Injectable(as: TransactionsRemoteDataSource)
class TransactionsRemoteDataSourceImpl implements TransactionsRemoteDataSource {
  @override
  Future<PaginatedTransactions> getTransactions({
    required int pageId,
    required int pageSize,
    required int accountId,
    TransactionFilter? filter,
  }) async {
    try {
      // Build query parameters
      final Map<String, dynamic> queryParams = {
        'page_id': pageId,
        'page_size': pageSize,
      };
      
      // Only include account_id if it's greater than 0
      if (accountId > 0) {
        queryParams['account_id'] = accountId;
      }

      // Add filter parameters if provided
      if (filter != null) {
        if (filter.type != null) {
          queryParams['type'] = filter.type!.value;
        }
        if (filter.direction != null) {
          queryParams['direction'] = filter.direction!.value;
        }
        if (filter.status != null) {
          queryParams['status'] = filter.status!.value;
        }
        if (filter.startDate != null) {
          queryParams['start_date'] = filter.startDate!.toIso8601String();
        }
        if (filter.endDate != null) {
          queryParams['end_date'] = filter.endDate!.toIso8601String();
        }
        if (filter.counterpartyName != null) {
          queryParams['counterparty_name'] = filter.counterpartyName;
        }
        if (filter.bankCode != null) {
          queryParams['bank_code'] = filter.bankCode;
        }
        if (filter.minAmount != null) {
          queryParams['min_amount'] = filter.minAmount;
        }
        if (filter.maxAmount != null) {
          queryParams['max_amount'] = filter.maxAmount;
        }
      }

      // Make the API request
      final response = await getIt<HttpService>().client(requireAuth: true).get(
        '/transactions',
        queryParameters: queryParams,
      );

      // Convert the response data to a list of transactions
      final List<dynamic> transactionsData = response.data as List<dynamic>;
      final transactions = transactionsData
          .map((transactionData) =>
              Transaction.fromJson(transactionData as Map<String, dynamic>))
          .toList();

      // Create and return paginated transactions
      // Note: The response doesn't have pagination metadata, so we'll infer it
      return PaginatedTransactions(
        transactions: transactions,
        totalCount: transactions.length, // This is a placeholder as the API doesn't return a total count
        currentPage: pageId,
        pageSize: pageSize,
        hasReachedMax: transactions.length < pageSize, // If we get fewer items than requested, we've reached the end
      );
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<Transaction> getTransactionById({
    required int transactionId,
    required int accountId,
  }) async {
    try {
      // Build query parameters
      final Map<String, dynamic> queryParams = {};
      
      // Only include account_id if it's greater than 0
      if (accountId > 0) {
        queryParams['account_id'] = accountId;
      }
      
      // Since the API doesn't provide a dedicated endpoint for fetching a single transaction,
      // we'll fetch all transactions and find the one with the matching ID
      final response = await getIt<HttpService>().client(requireAuth: true).get(
        '/transactions',
        queryParameters: queryParams,
      );

      // Convert the response data to a list of transactions
      final List<dynamic> transactionsData = response.data as List<dynamic>;
      final transactions = transactionsData
          .map((transactionData) =>
              Transaction.fromJson(transactionData as Map<String, dynamic>))
          .toList();

      // Find the transaction with the matching ID
      final transaction = transactions.firstWhere(
        (transaction) => transaction.id == transactionId,
        orElse: () => throw Exception('Transaction not found'),
      );

      return transaction;
    } on DioException {
      rethrow;
    }
  }

  @override
  Future<TransactionSummary> getTransactionSummary({
    required int accountId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      // Build query parameters
      final Map<String, dynamic> queryParams = {};
      
      // Only include account_id if it's greater than 0
      if (accountId > 0) {
        queryParams['account_id'] = accountId;
      }

      if (startDate != null) {
        queryParams['start_date'] = startDate.toIso8601String();
      }
      if (endDate != null) {
        queryParams['end_date'] = endDate.toIso8601String();
      }

      // Make the API request to get all transactions for the account
      final response = await getIt<HttpService>().client(requireAuth: true).get(
        '/transactions',
        queryParameters: queryParams,
      );

      // Convert the response data to a list of transactions
      final List<dynamic> transactionsData = response.data as List<dynamic>;
      final transactions = transactionsData
          .map((transactionData) =>
              Transaction.fromJson(transactionData as Map<String, dynamic>))
          .toList();

      // Calculate summary information
      double totalIncoming = 0;
      double totalOutgoing = 0;
      int successfulTransactions = 0;
      int failedTransactions = 0;
      Map<String, double> transactionsByType = {};

      for (final transaction in transactions) {
        // Calculate totals by direction
        if (transaction.direction == 'incoming') {
          totalIncoming += transaction.amount;
        } else {
          totalOutgoing += transaction.amount;
        }

        // Count by status
        if (transaction.status == 'completed') {
          successfulTransactions++;
        } else if (transaction.status == 'failed') {
          failedTransactions++;
        }

        // Summarize by type
        final type = transaction.type;
        if (transactionsByType.containsKey(type)) {
          transactionsByType[type] = (transactionsByType[type] ?? 0) + transaction.amount;
        } else {
          transactionsByType[type] = transaction.amount;
        }
      }

      // Calculate average transaction amount
      final double averageTransactionAmount = transactions.isNotEmpty
          ? transactions.map((t) => t.amount).reduce((a, b) => a + b) / transactions.length
          : 0;

      // Create and return the transaction summary
      return TransactionSummary(
        totalIncoming: totalIncoming,
        totalOutgoing: totalOutgoing,
        totalTransactions: transactions.length,
        successfulTransactions: successfulTransactions,
        failedTransactions: failedTransactions,
        averageTransactionAmount: averageTransactionAmount,
        transactionsByType: transactionsByType,
      );
    } on DioException {
      rethrow;
    }
  }
} 