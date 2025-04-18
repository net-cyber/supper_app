import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

/// Represents a bank account in the system
class BankAccount {
  final AccountNumber accountNumber;
  final String accountHolderName;
  final String bankName;
  final BankCode bankCode;
  final Money availableBalance;
  final bool isInternal;

  const BankAccount({
    required this.accountNumber,
    required this.accountHolderName,
    required this.bankName,
    required this.bankCode,
    required this.availableBalance,
    this.isInternal = false,
  });

  /// Get the account number in a masked format for display
  String get maskedAccountNumber {
    final accountString = accountNumber.getOrElse('');
    if (accountString.length <= 4) {
      return accountString;
    }
    final lastFour = accountString.substring(accountString.length - 4);
    return '******$lastFour';
  }

  /// Get the account holder's initials
  String get accountHolderInitials {
    final parts = accountHolderName.split(' ');
    if (parts.isEmpty) {
      return '';
    }
    if (parts.length == 1) {
      return parts[0].isNotEmpty ? parts[0][0].toUpperCase() : '';
    }
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }

  /// Check if the account has sufficient funds for a transfer
  bool hasSufficientFunds(Money amount) {
    return availableBalance.value.fold(
      (_) => false,
      (balance) => amount.value.fold(
        (_) => false,
        (transferAmount) => balance >= transferAmount,
      ),
    );
  }

  /// Get a formatted account summary
  String get summary => '$accountHolderName - ${maskedAccountNumber}';
}
