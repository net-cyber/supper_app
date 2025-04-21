import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/handlers/http_service.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/bank_account_validation/bank_account_validation.dart';

abstract class BankAccountValidationRemoteDataSource {
 Future<Either<NetworkExceptions, BankAccountValidation>> validateBankAccount({
    required String bankCode,
    required String accountNumber,
  });
}

@Injectable(as: BankAccountValidationRemoteDataSource)
class BankAccountValidationRemoteDataSourceImpl implements BankAccountValidationRemoteDataSource {
  @override
  Future<Either<NetworkExceptions, BankAccountValidation>> validateBankAccount({
    required String bankCode,
    required String accountNumber,
  }) async {
    try {
      log('Validating bank account - bankCode: $bankCode, accountNumber: $accountNumber');
      
      // Prepare request body
      final Map<String, dynamic> body = {
        'bank_code': bankCode,
        'account_number': accountNumber,
      };
      
      log('Making bank account validation API call with body: $body');
      
      // Make API request using requireAuth: true which will handle the token automatically
      final response = await getIt<HttpService>().client(requireAuth: true).post(
        '/bank-accounts/lookup',
        data: body,
      );
      
      // Log the response for debugging
      log('Bank account validation API response: ${response.data}');
      
      // Check if response data is null
      if (response.data == null) {
        log('Server returned null response for bank account validation');
        return Left(NetworkExceptions.defaultError('Server returned null response'));
      }
      
      try {
        // Handle response
        if (response.data is Map<String, dynamic>) {
          final responseData = response.data as Map<String, dynamic>;
          
          // Convert response to domain entity
          final bankAccountValidation = BankAccountValidation(
            bankCode: responseData['bank_code'] as String? ?? bankCode,
            accountNumber: responseData['account_number'] as String? ?? accountNumber,
            accountName: responseData['account_name'] as String? ?? 'Unknown Account',
            found: responseData['found'] as bool? ?? false,
          );
          
          log('Bank account validation successful: ${bankAccountValidation.found}, account name: ${bankAccountValidation.accountName}');
          
          return Right(bankAccountValidation);
        } else {
          // Unexpected response format
          log('Unexpected bank account validation response format: ${response.data.runtimeType}');
          return Left(NetworkExceptions.defaultError('Unexpected response format'));
        }
      } catch (parseError) {
        log('Error parsing bank account validation response: $parseError');
        log('Response data: ${response.data}');
        
        return Left(NetworkExceptions.defaultError('Failed to parse response: $parseError'));
      }
    } on DioException catch (e) {
      log('DioException in bank account validation: ${e.message}');
      
      if (e.response?.statusCode == 401) {
        return Left(NetworkExceptions.unauthorisedRequest());
      } else if (e.response?.statusCode == 404) {
        return Left(NetworkExceptions.notFound('Bank account validation service not found'));
      } else if (e.response?.statusCode == 422 || e.response?.statusCode == 400) {
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
        log('Bad request in bank account validation: $errorMessage');
        return Left(NetworkExceptions.defaultError(errorMessage));
      }
      
      return Left(NetworkExceptions.getDioException(e));
    } catch (e) {
      log('Unexpected error in bank account validation: $e');
      return Left(NetworkExceptions.unexpectedError());
    }
  }
} 