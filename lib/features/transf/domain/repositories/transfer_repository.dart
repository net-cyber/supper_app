import 'package:dartz/dartz.dart';
import 'package:super_app/features/transf/domain/entities/transfer_result.dart';
import 'package:super_app/features/transf/domain/failures/failure.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

abstract class TransferRepository {
  Future<Either<Failure, TransferResult>> transfer({
    required AccountNumber fromAccountNumber,
    required AccountNumber toAccountNumber,
    required Amount amount,
    String? reference,
    String? description,
  });

  Future<Either<Failure, String>> verifyAccount(AccountNumber accountNumber);

  /// Checks if the account has sufficient funds for a transfer
  ///
  /// Returns:
  /// - Right(true) if the account has enough funds
  /// - Right(false) if the account doesn't have enough funds
  /// - Left(Failure) if there was an error checking the balance
  Future<Either<Failure, bool>> hasSufficientFunds({
    required AccountNumber accountNumber,
    required Amount amount,
  });

  /// Gets the current balance of an account
  ///
  /// Returns:
  /// - Right(double) with the current balance
  /// - Left(Failure) if there was an error retrieving the balance
  Future<Either<Failure, double>> getAccountBalance(
      AccountNumber accountNumber);
}
