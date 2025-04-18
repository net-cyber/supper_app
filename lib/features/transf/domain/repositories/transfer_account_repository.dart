import 'package:dartz/dartz.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/account_verification/account_verification.dart';

abstract class TransferAccountRepository {
  /// Verifies an account by account ID
  /// Returns the account holder's full name on success or an error on failure
  Future<Either<NetworkExceptions, AccountVerification>> verifyAccount(
      int accountId);
}
