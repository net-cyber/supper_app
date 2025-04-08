import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/handlers/http_service.dart';
import 'package:super_app/features/transf/domain/entities/transfer_result.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

abstract class TransferRemoteDataSource {
  /// Verifies an account by ID
  /// Corresponds to: GET /accounts/verification/:id
  Future<Map<String, dynamic>> verifyAccount(String accountNumber);

  /// Validates if an account has sufficient funds for a transfer
  /// Corresponds to: GET /accounts/validate
  Future<Map<String, dynamic>> validateFunds({
    required String accountId,
    required double amount,
  });

  /// Executes a transfer between accounts
  /// Corresponds to: POST /transfers (actual endpoint may vary)
  Future<Map<String, dynamic>> executeTransfer({
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    String? reference,
    String? description,
  });

  /// Retrieves account balance
  /// Endpoint is inferred based on provided APIs
  Future<Map<String, dynamic>> getAccountBalance(String accountId);
}

@Injectable(as: TransferRemoteDataSource)
class TransferRemoteDataSourceImpl implements TransferRemoteDataSource {
  @override
  Future<Map<String, dynamic>> verifyAccount(String accountNumber) async {
    try {
      final response = await getIt<HttpService>().client().get(
            '/accounts/verification/$accountNumber',
          );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Authentication required. Please log in.');
      }
      rethrow;
    } catch (e) {
      if (e.toString().contains('Authentication token not available')) {
        throw Exception('Authentication required. Please log in.');
      }
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> validateFunds({
    required String accountId,
    required double amount,
  }) async {
    try {
      final data = <String, dynamic>{
        'account_id': accountId,
        'amount': amount,
      };

      final response = await getIt<HttpService>().client().get(
            '/accounts/validate',
            data: data,
          );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Authentication required. Please log in.');
      }
      rethrow;
    } catch (e) {
      if (e.toString().contains('Authentication token not available')) {
        throw Exception('Authentication required. Please log in.');
      }
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> executeTransfer({
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    String? reference,
    String? description,
  }) async {
    try {
      final data = <String, dynamic>{
        'from_account_id': fromAccountId,
        'to_account_id': toAccountId,
        'amount': amount,
      };

      // Add optional fields if provided
      if (reference != null) {
        data['reference'] = reference;
      }

      if (description != null) {
        data['description'] = description;
      }

      final response = await getIt<HttpService>().client().post(
            '/transfers', // Assuming this is the endpoint based on response format
            data: data,
          );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Authentication required. Please log in.');
      }
      rethrow;
    } catch (e) {
      if (e.toString().contains('Authentication token not available')) {
        throw Exception('Authentication required. Please log in.');
      }
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getAccountBalance(String accountId) async {
    try {
      // Assuming the endpoint is something like /accounts/:id
      // This wasn't explicitly in the cURL examples but would be needed
      final response = await getIt<HttpService>().client().get(
            '/accounts/$accountId',
          );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Authentication required. Please log in.');
      }
      rethrow;
    } catch (e) {
      if (e.toString().contains('Authentication token not available')) {
        throw Exception('Authentication required. Please log in.');
      }
      rethrow;
    }
  }
}
