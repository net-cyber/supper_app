import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/handlers/http_service.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/account_validation/account_validation.dart';

abstract class AccountValidationRemoteDataSource {
  /// Validates an account by checking if it has sufficient funds for a transaction
  /// 
  /// Parameters:
  /// - [amount]: The transaction amount to validate
  /// - [currentAccountId]: The ID of the account to validate
  /// 
  /// Returns:
  /// - A [Future] with [Either] a [NetworkExceptions] on error or an [AccountValidation] on success
  Future<Either<NetworkExceptions, AccountValidation>> validateAccount(
    double amount, 
    int currentAccountId,
  );
}

@Injectable(as: AccountValidationRemoteDataSource)
class AccountValidationRemoteDataSourceImpl implements AccountValidationRemoteDataSource {
  @override
  Future<Either<NetworkExceptions, AccountValidation>> validateAccount(
      double amount, int currentAccountId) async {
    try {
      log('Validating account - amount: $amount, accountId: $currentAccountId');
      
      final Map<String, dynamic> body = {
        'amount': amount.toInt(),
        'account_id': currentAccountId,
      };

      log('Making account validation API call with body: $body');
      
      final response = await getIt<HttpService>().client(requireAuth: true).get(
        '/accounts/validate',
        data: body,
      );

      // Log the response for debugging
      log('Account validation API response: ${response.data}');
      
      if (response.data == null) {
        log('Server returned null response for account validation');
        return Left(NetworkExceptions.defaultError('Server returned null response'));
      }

      try {
        if (response.data is Map<String, dynamic>) {
          final data = response.data as Map<String, dynamic>;
          final message = data['message'] as String? ?? 'Account validated';
          bool isSufficient = false;

          if (data.containsKey('is_sufficient')) {
            isSufficient = data['is_sufficient'] as bool;
          } else {
            isSufficient = message.toLowerCase().contains('sufficient');
          }

          final accountValidation = AccountValidation(
            message: message,
            isSufficient: isSufficient,
          );
          
          log('Account validation successful: isSufficient: ${accountValidation.isSufficient}, message: ${accountValidation.message}');
          
          return Right(accountValidation);
        } else if (response.data is String) {
          final message = response.data as String;
          final isSufficient = message.toLowerCase().contains('sufficient');

          final accountValidation = AccountValidation(
            message: message,
            isSufficient: isSufficient,
          );
          
          log('Account validation successful (string response): isSufficient: ${accountValidation.isSufficient}, message: ${accountValidation.message}');
          
          return Right(accountValidation);
        }

        // Unexpected response format
        log('Unexpected account validation response format: ${response.data.runtimeType}');
        return Left(NetworkExceptions.defaultError('Unexpected response format'));
      } catch (parseError) {
        log('Error parsing account validation response: $parseError');
        log('Response data: ${response.data}');
        
        return Left(NetworkExceptions.defaultError('Failed to parse response: $parseError'));
      }
    } on DioException catch (e) {
      log('DioException in account validation: ${e.message}');
      
      if (e.response?.statusCode == 401) {
        return Left(NetworkExceptions.unauthorisedRequest());
      } else if (e.response?.statusCode == 422) {
        final message = e.response?.data?['message'] as String? ??
            'Insufficient funds for this transaction';
        
        log('Validation failed due to insufficient funds: $message');
        return Left(NetworkExceptions.defaultError(message));
      } else if (e.response?.statusCode == 404) {
        return Left(NetworkExceptions.notFound('Account validation service not found'));
      } else if (e.response?.statusCode == 400) {
        String errorMessage = 'Invalid request format';

        if (e.response?.data != null && e.response?.data is Map) {
          final errorData = e.response?.data as Map;
          if (errorData.containsKey('message')) {
            errorMessage = errorData['message'].toString();
          } else if (errorData.containsKey('error')) {
            errorMessage = errorData['error'].toString();
          }
        }
        
        // Log the error message but use the default badRequest
        log('Bad request in account validation: $errorMessage');
        return Left(NetworkExceptions.badRequest());
      }
      
      return Left(NetworkExceptions.getDioException(e));
    } catch (e) {
      log('Unexpected error in account validation: $e');
      return Left(NetworkExceptions.unexpectedError());
    }
  }
}
