import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/features/transf/domain/entities/bank_account.dart';
import 'package:super_app/features/transf/domain/repositories/bank_account_repository.dart';
import 'package:super_app/features/transf/domain/value_objects/failures.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

@Injectable(as: BankAccountRepository)
class MockBankAccountRepository implements BankAccountRepository {
  // Mock data
  final List<Map<String, dynamic>> _supportedBanks = [
    {
      'name': 'Commercial Bank of Ethiopia',
      'code': 'CBE',
      'imagePath': 'placeholder', // Placeholder instead of actual image path
    },
    {
      'name': 'Dashen Bank',
      'code': 'DASHEN',
      'imagePath': 'placeholder',
    },
    {
      'name': 'Abyssinia Bank',
      'code': 'ABYSSINIA',
      'imagePath': 'placeholder',
    },
    {
      'name': 'Awash Bank',
      'code': 'AWASH',
      'imagePath': 'placeholder',
    },
    {
      'name': 'Zemen Bank',
      'code': 'ZEMEN',
      'imagePath': 'placeholder',
    },
    {
      'name': 'Wegagen Bank',
      'code': 'WEGAGEN',
      'imagePath': 'placeholder',
    },
  ];

  final Map<String, BankAccount> _accounts = {
    '1234567890': BankAccount(
      accountNumber: AccountNumber('1234567890'),
      accountHolderName: 'Bereket Tefera',
      bankName: 'Goh Betoch Bank',
      bankCode: BankCode.gohBetoch(),
      availableBalance: Money(amount: 10000.0),
      isInternal: true,
    ),
    '0987654321': BankAccount(
      accountNumber: AccountNumber('0987654321'),
      accountHolderName: 'Abebe Kebede',
      bankName: 'Goh Betoch Bank',
      bankCode: BankCode.gohBetoch(),
      availableBalance: Money(amount: 5000.0),
      isInternal: true,
    ),
    '2345678901': BankAccount(
      accountNumber: AccountNumber('2345678901'),
      accountHolderName: 'Chaltu Tadesse',
      bankName: 'Commercial Bank of Ethiopia',
      bankCode: BankCode.cbe(),
      availableBalance: Money(amount: 7500.0),
      isInternal: false,
    ),
  };

  @override
  Future<Either<TransferFailure<dynamic>, BankAccount>>
      getUserBankAccount() async {
    return right(_accounts['1234567890']!);
  }

  @override
  Future<Either<TransferFailure<dynamic>, BankAccount>> verifyAccountNumber(
      AccountNumber accountNumber) async {
    final account = _accounts[accountNumber.getOrElse('')];
    if (account == null) {
      return left(TransferFailure.accountNotFound(
          failedValue: accountNumber.getOrElse('')));
    }
    return right(account);
  }

  @override
  Future<Either<TransferFailure<dynamic>, BankAccount>>
      verifyInternalAccountNumber(AccountNumber accountNumber) async {
    final account = _accounts[accountNumber.getOrElse('')];
    if (account == null) {
      return left(TransferFailure.accountNotFound(
          failedValue: accountNumber.getOrElse('')));
    }
    if (!account.isInternal) {
      return left(TransferFailure.invalidAccountNumber(
          failedValue: accountNumber.getOrElse('')));
    }
    return right(account);
  }

  @override
  Future<Either<TransferFailure<dynamic>, BankAccount>>
      verifyExternalAccountNumber(
          AccountNumber accountNumber, BankCode bankCode) async {
    final account = _accounts[accountNumber.getOrElse('')];
    if (account == null) {
      return left(TransferFailure.accountNotFound(
          failedValue: accountNumber.getOrElse('')));
    }
    if (account.isInternal ||
        account.bankCode.getOrElse('') != bankCode.getOrElse('')) {
      return left(TransferFailure.invalidAccountNumber(
          failedValue: accountNumber.getOrElse('')));
    }
    return right(account);
  }

  @override
  Future<Either<TransferFailure<dynamic>, Money>> getAccountBalance() async {
    return right(Money(amount: 10000.0));
  }

  @override
  Future<Either<TransferFailure<dynamic>, bool>> hasSufficientFunds(
      Money amount) async {
    final availableBalance = Money(amount: 10000.0);
    return right(amount.getOrElse(0.0) <= availableBalance.getOrElse(0.0));
  }

  @override
  Future<Either<TransferFailure<dynamic>, List<BankAccount>>>
      getSavedBankAccounts() async {
    return right(_accounts.values.toList());
  }

  @override
  Future<Either<TransferFailure<dynamic>, BankAccount>> saveBankAccount(
      BankAccount account) async {
    return right(account);
  }

  @override
  Future<Either<TransferFailure<dynamic>, Unit>> removeSavedBankAccount(
      AccountNumber accountNumber) async {
    return right(unit);
  }

  @override
  Future<Either<TransferFailure<dynamic>, List<Map<String, dynamic>>>>
      getSupportedBanks() async {
    return right(_supportedBanks);
  }

  @override
  Future<Either<TransferFailure<dynamic>, List<Map<String, dynamic>>>>
      getSupportedExternalBanks() async {
    return right(_supportedBanks);
  }
}
