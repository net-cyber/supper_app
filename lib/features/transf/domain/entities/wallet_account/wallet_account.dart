import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

/// Represents a mobile wallet account in the system
class WalletAccount {
  final PhoneNumber phoneNumber;
  final WalletProvider provider;
  final String? accountHolderName;
  final Money availableBalance;

  const WalletAccount({
    required this.phoneNumber,
    required this.provider,
    this.accountHolderName,
    required this.availableBalance,
  });

  /// Get the phone number in a masked format for display
  String get maskedPhoneNumber {
    final phoneString = phoneNumber.getOrElse('');
    if (phoneString.length <= 4) {
      return phoneString;
    }
    final lastFour = phoneString.substring(phoneString.length - 4);
    return '******$lastFour';
  }

  /// Get the account holder's initials
  String get accountHolderInitials {
    if (accountHolderName == null || accountHolderName!.isEmpty) {
      return '';
    }

    final parts = accountHolderName!.split(' ');
    if (parts.isEmpty) {
      return '';
    }
    if (parts.length == 1) {
      return parts[0].isNotEmpty ? parts[0][0].toUpperCase() : '';
    }
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }

  /// Check if the wallet has sufficient funds for a transfer
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
  String get summary {
    final name = accountHolderName ?? 'Unknown User';
    final providerName = provider.getOrElse('');
    return '$name - $providerName (${maskedPhoneNumber})';
  }
}
