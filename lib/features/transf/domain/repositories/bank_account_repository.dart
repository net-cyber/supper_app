import 'package:dartz/dartz.dart';
import 'package:super_app/features/transf/domain/entities/bank_account.dart';
import 'package:super_app/features/transf/domain/value_objects/failures.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

/// Repository interface for bank account operations
abstract class BankAccountRepository {
  /// Get the current user's bank account
  Future<Either<TransferFailure<dynamic>, BankAccount>> getUserBankAccount();

  /// Verify if an account number exists and get the account holder details
  Future<Either<TransferFailure<dynamic>, BankAccount>> verifyAccountNumber(
      AccountNumber accountNumber);

  /// Verify if an internal (Goh Betoch Bank) account number exists
  Future<Either<TransferFailure<dynamic>, BankAccount>>
      verifyInternalAccountNumber(AccountNumber accountNumber);

  /// Verify if an external account number exists at the specified bank
  Future<Either<TransferFailure<dynamic>, BankAccount>>
      verifyExternalAccountNumber(
          AccountNumber accountNumber, BankCode bankCode);

  /// Get account balance for the current user
  Future<Either<TransferFailure<dynamic>, Money>> getAccountBalance();

  /// Check if the user has sufficient funds for a transfer
  Future<Either<TransferFailure<dynamic>, bool>> hasSufficientFunds(
      Money amount);

  /// Get list of favorite/saved bank accounts
  Future<Either<TransferFailure<dynamic>, List<BankAccount>>>
      getSavedBankAccounts();

  /// Save a bank account to favorites
  Future<Either<TransferFailure<dynamic>, BankAccount>> saveBankAccount(
      BankAccount account);

  /// Remove a bank account from favorites
  Future<Either<TransferFailure<dynamic>, Unit>> removeSavedBankAccount(
      AccountNumber accountNumber);

  /// Get list of supported banks for external transfers
  Future<Either<TransferFailure<dynamic>, List<Map<String, dynamic>>>>
      getSupportedBanks();

  /// Get list of supported banks for external transfers with detailed information
  Future<Either<TransferFailure<dynamic>, List<Map<String, dynamic>>>>
      getSupportedExternalBanks();
}
