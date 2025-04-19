import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

/// Base class for all transfers in the system
abstract class Transfer {
  final TransferId id;
  final Money amount;
  final DateTime timestamp;
  final TransferReason? reason;
  final String senderName;

  const Transfer({
    required this.id,
    required this.amount,
    required this.timestamp,
    this.reason,
    required this.senderName,
  });

  /// Get the total cost of the transfer (amount + fee)
  Money get totalCost;

  /// Get a formatted description of the transfer
  String get description;

  /// Check if the transfer is to the same bank
  bool get isInternal;

  /// Get the formatted date for display
  String get formattedDate {
    final day = timestamp.day.toString().padLeft(2, '0');
    final month = timestamp.month.toString().padLeft(2, '0');
    final year = timestamp.year;
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');

    return '$day/$month/$year $hour:$minute';
  }
}

/// Represents an internal bank transfer
class InternalBankTransfer extends Transfer {
  final AccountNumber receiverAccountNumber;
  final String receiverName;
  final String bankName;

  const InternalBankTransfer({
    required TransferId id,
    required this.receiverAccountNumber,
    required Money amount,
    required DateTime timestamp,
    TransferReason? reason,
    required String senderName,
    required this.receiverName,
    required this.bankName,
  }) : super(
          id: id,
          amount: amount,
          timestamp: timestamp,
          reason: reason,
          senderName: senderName,
        );

  @override
  Money get totalCost => amount; // No fee for internal transfers

  @override
  String get description => 'Transfer to $receiverName ($bankName)';

  @override
  bool get isInternal => true;
}

/// Represents an external bank transfer
class ExternalBankTransfer extends Transfer {
  final AccountNumber receiverAccountNumber;
  final BankCode bankCode;
  final Money fee;
  final String receiverName;
  final String bankName;

  const ExternalBankTransfer({
    required TransferId id,
    required this.receiverAccountNumber,
    required this.bankCode,
    required Money amount,
    required this.fee,
    required DateTime timestamp,
    TransferReason? reason,
    required String senderName,
    required this.receiverName,
    required this.bankName,
  }) : super(
          id: id,
          amount: amount,
          timestamp: timestamp,
          reason: reason,
          senderName: senderName,
        );

  @override
  Money get totalCost => amount.add(fee);

  @override
  String get description => 'Transfer to $receiverName ($bankName)';

  @override
  bool get isInternal => false;
}

/// Represents a wallet transfer (load to wallet)
class WalletTransfer extends Transfer {
  final PhoneNumber receiverPhone;
  final WalletProvider walletProvider;
  final Money fee;
  final String? receiverName;

  const WalletTransfer({
    required TransferId id,
    required this.receiverPhone,
    required this.walletProvider,
    required Money amount,
    required this.fee,
    required DateTime timestamp,
    TransferReason? reason,
    required String senderName,
    this.receiverName,
  }) : super(
          id: id,
          amount: amount,
          timestamp: timestamp,
          reason: reason,
          senderName: senderName,
        );

  @override
  Money get totalCost => amount.add(fee);

  @override
  String get description =>
      'Load to ${receiverName ?? receiverPhone.getOrElse('')} (${walletProvider.getOrElse('')})';

  @override
  bool get isInternal => false;
}
