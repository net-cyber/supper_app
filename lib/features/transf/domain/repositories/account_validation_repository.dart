import 'package:dartz/dartz.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/account_validation.dart';

abstract class AccountValidationRepository {
  /// Validates if an account has sufficient balance for a transaction
  /// Returns the validation result on success or an error on failure
  Future<Either<NetworkExceptions, AccountValidation>> validateAccount(
      double amount, int currentAccountId);
}
