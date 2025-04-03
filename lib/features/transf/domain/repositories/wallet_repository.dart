import 'package:dartz/dartz.dart';
import 'package:super_app/features/transf/domain/entities/wallet_account.dart';
import 'package:super_app/features/transf/domain/value_objects/failures.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

/// Repository interface for wallet operations
abstract class WalletRepository {
  /// Get available wallet providers
  Future<Either<TransferFailure<dynamic>, List<WalletProvider>>>
      getWalletProviders();

  /// Verify if a phone number is associated with a wallet
  Future<Either<TransferFailure<dynamic>, WalletAccount>> verifyWalletAccount({
    required PhoneNumber phoneNumber,
    required WalletProvider provider,
  });

  /// Calculate transfer fee for wallet transfers
  Future<Either<TransferFailure<dynamic>, Money>> calculateWalletTransferFee({
    required Money amount,
    required WalletProvider provider,
  });

  /// Check if a wallet account exists
  Future<Either<TransferFailure<dynamic>, bool>> walletAccountExists({
    required PhoneNumber phoneNumber,
    required WalletProvider provider,
  });

  /// Get wallet account details by phone number and provider
  Future<Either<TransferFailure<dynamic>, WalletAccount>> getWalletAccount({
    required PhoneNumber phoneNumber,
    required WalletProvider provider,
  });

  /// Get list of frequently used wallet accounts
  Future<Either<TransferFailure<dynamic>, List<WalletAccount>>>
      getFrequentWalletAccounts();

  /// Save a wallet account to frequently used
  Future<Either<TransferFailure<dynamic>, WalletAccount>> saveWalletAccount(
      WalletAccount account);

  /// Remove a wallet account from frequently used
  Future<Either<TransferFailure<dynamic>, Unit>> removeWalletAccount({
    required PhoneNumber phoneNumber,
    required WalletProvider provider,
  });
}
