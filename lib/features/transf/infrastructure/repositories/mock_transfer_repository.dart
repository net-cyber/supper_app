import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/features/transf/domain/entities/bank_account.dart';
import 'package:super_app/features/transf/domain/entities/transaction.dart';
import 'package:super_app/features/transf/domain/entities/transfer.dart';
import 'package:super_app/features/transf/domain/entities/transfer_status.dart';
import 'package:super_app/features/transf/domain/repositories/transfer_repository.dart';
import 'package:super_app/features/transf/domain/value_objects/failures.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

@Injectable(as: TransferRepository)
class MockTransferRepository implements TransferRepository {
  // Track internal transaction IDs to simulate persistence
  final List<String> _transactionIds = [];

  // Counter for generating unique transaction IDs
  int _transactionCounter = 100;

  @override
  Future<Either<TransferFailure<dynamic>, Transaction>>
      initiateInternalTransfer({
    required AccountNumber receiverAccountNumber,
    required Money amount,
    required String senderName,
    required String receiverName,
    required String bankName,
    TransferReason? reason,
  }) async {
    // Basic validation for amount
    if (amount.getOrElse(0.0) <= 0) {
      return left(TransferFailure.invalidAmount(
        failedValue: amount.getOrElse(0.0),
      ));
    }

    // Simulate network delay for processing
    await Future.delayed(const Duration(seconds: 1));

    // Generate a unique transaction ID for internal transfer
    final transactionId = "GB-I-${_transactionCounter++}";
    _transactionIds.add(transactionId);

    // Create a transfer with the transaction ID
    final transfer = InternalBankTransfer(
      id: TransferId.fromString(transactionId),
      receiverAccountNumber: receiverAccountNumber,
      amount: amount,
      timestamp: DateTime.now(),
      reason: reason,
      senderName: senderName,
      receiverName: receiverName,
      bankName:
          'Goh Betoch Bank', // Always use Goh Betoch for internal transfers
    );

    // Create a successful transaction
    final transaction = Transaction(
      transfer: transfer,
      status: TransferStatus.completed,
      createdAt: DateTime.now(),
      completedAt: DateTime.now(),
    );

    return right(transaction);
  }

  @override
  Future<Either<TransferFailure<dynamic>, Transaction>>
      initiateExternalTransfer({
    required AccountNumber receiverAccountNumber,
    required BankCode bankCode,
    required Money amount,
    required Money fee,
    required String senderName,
    required String receiverName,
    required String bankName,
    TransferReason? reason,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Generate a unique transaction ID for external transfer
    final transactionId = "GB-E-${_transactionCounter++}";
    _transactionIds.add(transactionId);

    // Create a transfer
    final transfer = ExternalBankTransfer(
      id: TransferId.fromString(transactionId),
      receiverAccountNumber: receiverAccountNumber,
      bankCode: bankCode,
      amount: amount,
      fee: fee,
      timestamp: DateTime.now(),
      reason: reason,
      senderName: senderName,
      receiverName: receiverName,
      bankName: bankName,
    );

    // Create a successful transaction
    final transaction = Transaction(
      transfer: transfer,
      status: TransferStatus.completed,
      createdAt: DateTime.now(),
      completedAt: DateTime.now(),
    );

    return right(transaction);
  }

  @override
  Future<Either<TransferFailure<dynamic>, Transaction>> initiateWalletTransfer({
    required PhoneNumber receiverPhone,
    required WalletProvider walletProvider,
    required Money amount,
    required Money fee,
    required String senderName,
    String? receiverName,
    TransferReason? reason,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Generate a unique transaction ID for wallet transfer
    final transactionId = "GB-W-${_transactionCounter++}";
    _transactionIds.add(transactionId);

    // Create a transfer
    final transfer = WalletTransfer(
      id: TransferId.fromString(transactionId),
      receiverPhone: receiverPhone,
      walletProvider: walletProvider,
      amount: amount,
      fee: fee,
      timestamp: DateTime.now(),
      reason: reason,
      senderName: senderName,
      receiverName: receiverName,
    );

    // Create a successful transaction
    final transaction = Transaction(
      transfer: transfer,
      status: TransferStatus.completed,
      createdAt: DateTime.now(),
      completedAt: DateTime.now(),
    );

    return right(transaction);
  }

  @override
  Future<Either<TransferFailure<dynamic>, Transaction>>
      transferToInternalAccount({
    required BankAccount fromAccount,
    required BankAccount toAccount,
    required Money amount,
    required String reason,
  }) async {
    // Validate accounts are from Goh Betoch Bank
    if (!toAccount.isInternal) {
      return left(const TransferFailure.invalidInput(
        failedValue: 'Bank account',
        message: 'Account is not a Goh Betoch Bank account',
      ));
    }

    return initiateInternalTransfer(
      receiverAccountNumber: toAccount.accountNumber,
      amount: amount,
      senderName: fromAccount.accountHolderName,
      receiverName: toAccount.accountHolderName,
      bankName: toAccount.bankName,
      reason: TransferReason(reason),
    );
  }

  @override
  Future<Either<TransferFailure<dynamic>, Transaction>>
      transferToExternalAccount({
    required BankAccount fromAccount,
    required BankAccount toAccount,
    required Money amount,
    required String reason,
  }) async {
    final fee = await calculateExternalTransferFee(amount, toAccount.bankCode);

    return fee.fold(
      (failure) => left(failure),
      (calculatedFee) => initiateExternalTransfer(
        receiverAccountNumber: toAccount.accountNumber,
        bankCode: toAccount.bankCode,
        amount: amount,
        fee: calculatedFee,
        senderName: fromAccount.accountHolderName,
        receiverName: toAccount.accountHolderName,
        bankName: toAccount.bankName,
        reason: TransferReason(reason),
      ),
    );
  }

  @override
  Future<Either<TransferFailure<dynamic>, Money>> calculateExternalTransferFee(
    Money amount,
    BankCode bankCode,
  ) async {
    // Mock fixed fee for external transfers
    return right(Money(amount: 25.0));
  }

  @override
  Future<Either<TransferFailure<dynamic>, Transaction>> cancelTransaction(
    TransferId id,
  ) async {
    final transactionOrFailure = await getTransactionById(id);
    return transactionOrFailure.fold(
      (l) => left(l),
      (r) => right(r.copyWithStatus(TransferStatus.canceled)),
    );
  }

  @override
  Future<Either<TransferFailure<dynamic>, List<Transaction>>>
      getAllTransactions() async {
    return getTransactionHistory();
  }

  @override
  Future<Either<TransferFailure<dynamic>, List<Transaction>>>
      getRecentTransactions({int limit = 10}) async {
    final transactions = await getTransactionHistory();
    return transactions.fold(
      (l) => left(l),
      (r) => right(r.take(limit).toList()),
    );
  }

  @override
  Future<Either<TransferFailure<dynamic>, Transaction>> getTransactionById(
    TransferId id,
  ) async {
    final transactions = await getTransactionHistory();
    return transactions.fold(
      (l) => left(l),
      (r) {
        try {
          final transaction = r.firstWhere(
            (t) => t.transfer.id.getOrElse('') == id.getOrElse(''),
            orElse: () => throw Exception('Transaction not found'),
          );
          return right(transaction);
        } catch (e) {
          return left(TransferFailure.invalidInput(
            failedValue: id.getOrElse('') as dynamic,
            message: 'Transaction not found',
          ));
        }
      },
    );
  }

  @override
  Future<Either<TransferFailure<dynamic>, List<Transaction>>>
      getTransactionHistory() async {
    // Mock internal transaction history data
    final transactions = [
      // Internal transfer with Goh Betoch Bank
      Transaction(
        transfer: InternalBankTransfer(
          id: TransferId.fromString('GB-I-001'),
          receiverAccountNumber: AccountNumber('0987654321'),
          amount: Money(amount: 1000.0),
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
          reason: TransferReason('Rent payment'),
          senderName: 'Bereket Tefera',
          receiverName: 'Abebe Kebede',
          bankName: 'Goh Betoch Bank',
        ),
        status: TransferStatus.completed,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        completedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      // Another internal transfer
      Transaction(
        transfer: InternalBankTransfer(
          id: TransferId.fromString('GB-I-002'),
          receiverAccountNumber: AccountNumber('5678901234'),
          amount: Money(amount: 500.0),
          timestamp: DateTime.now().subtract(const Duration(days: 4)),
          reason: TransferReason('Loan repayment'),
          senderName: 'Bereket Tefera',
          receiverName: 'Hiwot Girma',
          bankName: 'Goh Betoch Bank',
        ),
        status: TransferStatus.completed,
        createdAt: DateTime.now().subtract(const Duration(days: 4)),
        completedAt: DateTime.now().subtract(const Duration(days: 4)),
      ),
      // Another internal transfer
      Transaction(
        transfer: InternalBankTransfer(
          id: TransferId.fromString('GB-I-003'),
          receiverAccountNumber: AccountNumber('6543210987'),
          amount: Money(amount: 2500.0),
          timestamp: DateTime.now().subtract(const Duration(days: 7)),
          reason: TransferReason('Furniture payment'),
          senderName: 'Bereket Tefera',
          receiverName: 'Samuel Tadesse',
          bankName: 'Goh Betoch Bank',
        ),
        status: TransferStatus.completed,
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        completedAt: DateTime.now().subtract(const Duration(days: 7)),
      ),
      // External transfer from previous code for reference
      Transaction(
        transfer: ExternalBankTransfer(
          id: TransferId.fromString('GB-E-001'),
          receiverAccountNumber: AccountNumber('2345678901'),
          bankCode: BankCode.cbe(),
          amount: Money(amount: 2000.0),
          fee: Money(amount: 25.0),
          timestamp: DateTime.now().subtract(const Duration(days: 12)),
          reason: TransferReason('Monthly rent'),
          senderName: 'Bereket Tefera',
          receiverName: 'Chaltu Tadesse',
          bankName: 'Commercial Bank of Ethiopia',
        ),
        status: TransferStatus.completed,
        createdAt: DateTime.now().subtract(const Duration(days: 12)),
        completedAt: DateTime.now().subtract(const Duration(days: 12)),
      ),
    ];

    // Add any dynamic transactions created during this session
    for (final transactionId in _transactionIds) {
      if (!transactions
          .any((t) => t.transfer.id.getOrElse('') == transactionId)) {
        // Only add if it doesn't exist yet
        transactions.add(
          Transaction(
            transfer: InternalBankTransfer(
              id: TransferId.fromString(transactionId),
              receiverAccountNumber:
                  AccountNumber('0987654321'), // Default receiver
              amount: Money(amount: 1200.0), // Default amount
              timestamp: DateTime.now().subtract(const Duration(hours: 1)),
              reason: TransferReason('Recent transfer'),
              senderName: 'Bereket Tefera',
              receiverName: 'Abebe Kebede',
              bankName: 'Goh Betoch Bank',
            ),
            status: TransferStatus.completed,
            createdAt: DateTime.now().subtract(const Duration(hours: 1)),
            completedAt: DateTime.now().subtract(const Duration(minutes: 59)),
          ),
        );
      }
    }

    return right(transactions);
  }

  @override
  Future<Either<TransferFailure<dynamic>, List<Transaction>>>
      getPendingTransactions() async {
    // No pending transactions in this mock
    return right([]);
  }

  @override
  Future<Either<TransferFailure<dynamic>, Transaction>>
      updateTransactionStatus({
    required TransferId id,
    required TransferStatus newStatus,
    String? failureReason,
  }) async {
    final transactionOrFailure = await getTransactionById(id);
    return transactionOrFailure.fold(
      (l) => left(l),
      (r) => right(r.copyWithStatus(
        newStatus,
        newFailureReason: failureReason,
      )),
    );
  }
}
