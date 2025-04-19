import 'package:super_app/core/error/failures.dart';

/// Represents a failure that occurred during the bank account validation process
class BankAccountValidationFailure extends Failure {
  /// Create a new instance of [BankAccountValidationFailure]
  /// 
  /// Parameters:
  /// - [message]: A human-readable description of the error
  const BankAccountValidationFailure({
    required String message,
  }) : super(message: message);
  
  /// Factory method to create a failure for when an account is not found
  factory BankAccountValidationFailure.accountNotFound(String accountNumber) {
    return BankAccountValidationFailure(
      message: 'Account number $accountNumber was not found',
    );
  }
  
  /// Factory method to create a failure for when a bank is not supported
  factory BankAccountValidationFailure.unsupportedBank(String bankCode) {
    return BankAccountValidationFailure(
      message: 'Bank with code $bankCode is not supported for validation',
    );
  }
  
  /// Factory method to create a failure for when the validation service is unavailable
  factory BankAccountValidationFailure.serviceUnavailable() {
    return const BankAccountValidationFailure(
      message: 'Bank account validation service is currently unavailable',
    );
  }
} 