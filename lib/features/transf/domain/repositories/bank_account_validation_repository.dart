import 'package:dartz/dartz.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/bank_account_validation/bank_account_validation.dart';

abstract class BankAccountValidationRepository {
  /// Validates a bank account by checking if it exists and retrieving the account holder name
  /// 
  /// Parameters:
  /// - [bankCode]: The code of the bank (e.g., "CBE" for Commercial Bank of Ethiopia)
  /// - [accountNumber]: The account number to validate
  /// 
  /// Returns:
  /// - A [Future] with [Either] a [NetworkExceptions] on error or a [BankAccountValidation] on success
  Future<Either<NetworkExceptions, BankAccountValidation>> validateBankAccount({
    required String bankCode,
    required String accountNumber,
  });
} 