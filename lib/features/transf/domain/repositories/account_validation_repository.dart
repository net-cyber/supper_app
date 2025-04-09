import 'package:dartz/dartz.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/account_validation.dart';

abstract class AccountValidationRepository {
  /// Validates if an account has sufficient balance for a transaction
  /// Returns the validation result on success or an error on failure
  ///
  /// [amount] - The amount to transfer
  /// [currentAccountId] - The ID of the current user's account
  Future<Either<NetworkExceptions, AccountValidation>> validateAccount(
      double amount, int currentAccountId);
}
