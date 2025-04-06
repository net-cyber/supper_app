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

  // Enhanced internal accounts with more Goh Betoch accounts for testing
  final Map<String, BankAccount> _accounts = {
    // Current user's account
    '1234567890': BankAccount(
      accountNumber: AccountNumber('1234567890'),
      accountHolderName: 'Bereket Tefera',
      bankName: 'Goh Betoch Bank',
      bankCode: BankCode.gohBetoch(),
      availableBalance: Money(amount: 50000.0), // Increased balance for testing
      isInternal: true,
    ),

    // Goh Betoch internal accounts
    '0987654321': BankAccount(
      accountNumber: AccountNumber('0987654321'),
      accountHolderName: 'Abebe Kebede',
      bankName: 'Goh Betoch Bank',
      bankCode: BankCode.gohBetoch(),
      availableBalance: Money(amount: 5000.0),
      isInternal: true,
    ),
    '5678901234': BankAccount(
      accountNumber: AccountNumber('5678901234'),
      accountHolderName: 'Hiwot Girma',
      bankName: 'Goh Betoch Bank',
      bankCode: BankCode.gohBetoch(),
      availableBalance: Money(amount: 12500.0),
      isInternal: true,
    ),
    '6543210987': BankAccount(
      accountNumber: AccountNumber('6543210987'),
      accountHolderName: 'Samuel Tadesse',
      bankName: 'Goh Betoch Bank',
      bankCode: BankCode.gohBetoch(),
      availableBalance: Money(amount: 8750.0),
      isInternal: true,
    ),
    '8901234567': BankAccount(
      accountNumber: AccountNumber('8901234567'),
      accountHolderName: 'Tigist Mengistu',
      bankName: 'Goh Betoch Bank',
      bankCode: BankCode.gohBetoch(),
      availableBalance: Money(amount: 15000.0),
      isInternal: true,
    ),

    // External bank accounts (kept for reference)
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
    // Return the current user's account
    return right(_accounts['1234567890']!);
  }

  @override
  Future<Either<TransferFailure<dynamic>, BankAccount>> verifyAccountNumber(
      AccountNumber accountNumber) async {
    // Simulate server validation delay
    await Future.delayed(const Duration(milliseconds: 600));

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
    print(
        '📱 Repository: Verifying internal account: "${accountNumber.getOrElse('')}"');

    // Make sure we have a valid account number string to check
    final accountNumberStr = accountNumber.getOrElse('');
    print(
        '📱 Repository: Account number string: "$accountNumberStr" (length: ${accountNumberStr.length})');
    print(
        '📱 Repository DEBUG: Valid account number format? ${accountNumber.isValid()}');

    if (accountNumberStr.isEmpty) {
      print('📱 Repository: Empty account number received');
      return left(
          TransferFailure.invalidAccountNumber(failedValue: accountNumberStr));
    }

    // Print all available accounts for debugging
    print('📱 Repository: Available accounts:');
    _accounts.forEach((key, value) {
      print('   - $key: ${value.accountHolderName}');
    });

    try {
      // Use a very short delay for testing - just enough to see the UI update
      print('📱 Repository: Simulating brief network delay...');
      await Future.delayed(const Duration(milliseconds: 200));

      // Look up the account in our mock data
      print(
          '📱 Repository: Looking up account in mock data: "$accountNumberStr"');
      final account = _accounts[accountNumberStr];

      print(
          '📱 Repository DEBUG: Account lookup result: ${account != null ? "FOUND" : "NOT FOUND"}');

      // Validate account exists
      if (account == null) {
        print('📱 Repository: Account not found');
        return left(
            TransferFailure.accountNotFound(failedValue: accountNumberStr));
      }

      print(
          '📱 Repository DEBUG: Found account holder: ${account.accountHolderName}');
      print('📱 Repository DEBUG: Account internal? ${account.isInternal}');

      // Validate it's an internal Goh Betoch account
      if (!account.isInternal) {
        print('📱 Repository: Account is not internal');
        return left(TransferFailure.invalidAccountNumber(
            failedValue: accountNumberStr));
      }

      // Validate it's not the user's own account
      if (accountNumberStr == '1234567890') {
        print('📱 Repository: Cannot transfer to own account');
        return left(TransferFailure.invalidAccountNumber(
            failedValue: accountNumberStr));
      }

      // Success case - return the account
      print(
          '📱 Repository SUCCESS: Account validated: ${account.accountHolderName}');
      print(
          '📱 Repository DEBUG: Returning account with holder name: ${account.accountHolderName}');
      return right(account);
    } catch (e) {
      print('📱 Repository: Exception during validation: $e');
      print(
          '📱 Repository DEBUG: Error stack trace: ${e is Error ? e.stackTrace : "No stack trace"}');
      return left(const TransferFailure.unexpected());
    }
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
    // Get the current user's balance
    final userAccount = _accounts['1234567890']!;
    return right(userAccount.availableBalance);
  }

  @override
  Future<Either<TransferFailure<dynamic>, bool>> hasSufficientFunds(
      Money amount) async {
    // Get the current user's balance
    final userAccount = _accounts['1234567890']!;
    final availableBalance = userAccount.availableBalance;

    // Check if funds are sufficient
    final hasEnough = amount.getOrElse(0.0) <= availableBalance.getOrElse(0.0);

    if (!hasEnough) {
      return left(TransferFailure.insufficientFunds(
        failedValue: amount.getOrElse(0.0),
        available: availableBalance.getOrElse(0.0),
      ));
    }

    return right(hasEnough);
  }

  @override
  Future<Either<TransferFailure<dynamic>, List<BankAccount>>>
      getSavedBankAccounts() async {
    // Filter accounts to only include Goh Betoch accounts except the user's own account
    final savedAccounts = _accounts.values
        .where((account) =>
            account.isInternal &&
            account.accountNumber.getOrElse('') != '1234567890')
        .toList();

    return right(savedAccounts);
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
