import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/features/transf/domain/entities/transaction.dart';
import 'package:super_app/features/transf/domain/entities/wallet_account.dart';
import 'package:super_app/features/transf/domain/repositories/wallet_repository.dart';
import 'package:super_app/features/transf/domain/value_objects/failures.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

@Injectable(as: WalletRepository)
class MockWalletRepository implements WalletRepository {
  // Mock data for wallet providers
  final List<WalletProvider> _walletProviders = [
    WalletProvider('CBE Birr'),
    WalletProvider('Telebirr'),
    WalletProvider('Amole'),
    WalletProvider('HelloCash'),
  ];

  // Mock data for wallets
  final Map<String, WalletAccount> _wallets = {
    '0911234567': WalletAccount(
      phoneNumber: PhoneNumber('0911234567'),
      provider: WalletProvider('Telebirr'),
      accountHolderName: 'Bereket Tefera',
      availableBalance: Money(amount: 5000.0),
    ),
    '0922345678': WalletAccount(
      phoneNumber: PhoneNumber('0922345678'),
      provider: WalletProvider('CBE Birr'),
      accountHolderName: 'Abebe Kebede',
      availableBalance: Money(amount: 7500.0),
    ),
    '0933456789': WalletAccount(
      phoneNumber: PhoneNumber('0933456789'),
      provider: WalletProvider('Amole'),
      accountHolderName: 'Chaltu Tadesse',
      availableBalance: Money(amount: 3000.0),
    ),
  };

  @override
  Future<Either<TransferFailure<dynamic>, List<WalletProvider>>>
      getWalletProviders() async {
    return right(_walletProviders);
  }

  @override
  Future<Either<TransferFailure<dynamic>, WalletAccount>> verifyWalletAccount({
    required PhoneNumber phoneNumber,
    required WalletProvider provider,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    final wallet = _wallets[phoneNumber.getOrElse('')];
    if (wallet == null) {
      return left(TransferFailure.phoneNumberNotFound(
          failedValue: phoneNumber.getOrElse('')));
    }

    if (wallet.provider.getOrElse('') != provider.getOrElse('')) {
      return left(TransferFailure.invalidInput(
          failedValue: phoneNumber.getOrElse(''),
          message:
              'Phone number is not associated with the selected provider'));
    }

    return right(wallet);
  }

  @override
  Future<Either<TransferFailure<dynamic>, Money>> calculateWalletTransferFee({
    required Money amount,
    required WalletProvider provider,
  }) async {
    // Mock fee calculation - 1% of the amount or minimum 5 ETB
    final amountValue = amount.getOrElse(0.0);
    final calculatedFee = amountValue * 0.01;
    final fee = calculatedFee < 5.0 ? 5.0 : calculatedFee;

    return right(Money(amount: fee));
  }

  @override
  Future<Either<TransferFailure<dynamic>, bool>> walletAccountExists({
    required PhoneNumber phoneNumber,
    required WalletProvider provider,
  }) async {
    final wallet = _wallets[phoneNumber.getOrElse('')];
    if (wallet == null) {
      return right(false);
    }

    if (wallet.provider.getOrElse('') != provider.getOrElse('')) {
      return right(false);
    }

    return right(true);
  }

  @override
  Future<Either<TransferFailure<dynamic>, WalletAccount>> getWalletAccount({
    required PhoneNumber phoneNumber,
    required WalletProvider provider,
  }) async {
    return verifyWalletAccount(phoneNumber: phoneNumber, provider: provider);
  }

  @override
  Future<Either<TransferFailure<dynamic>, List<WalletAccount>>>
      getFrequentWalletAccounts() async {
    return right(_wallets.values.toList());
  }

  @override
  Future<Either<TransferFailure<dynamic>, WalletAccount>> saveWalletAccount(
      WalletAccount account) async {
    _wallets[account.phoneNumber.getOrElse('')] = account;
    return right(account);
  }

  @override
  Future<Either<TransferFailure<dynamic>, Unit>> removeWalletAccount({
    required PhoneNumber phoneNumber,
    required WalletProvider provider,
  }) async {
    _wallets.remove(phoneNumber.getOrElse(''));
    return right(unit);
  }
}
