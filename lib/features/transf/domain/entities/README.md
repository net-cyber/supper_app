# Transfer Feature Entities

This directory contains the domain entities for the Transfer feature of the Super App. These classes represent the core business objects in the domain model.

## Entity Model

The transfer feature uses the following entities:

### 1. Transfer

`Transfer` is the base entity that represents money movement from one account to another. It has three concrete implementations:

- **InternalBankTransfer**: Transfers between accounts within the same bank (Goh Betoch Bank)
- **ExternalBankTransfer**: Transfers to accounts at other banks
- **WalletTransfer**: Loading money to mobile wallets (telebir, M-PESA)

Each transfer type contains specific details about the transfer, such as:
- Who sent and received the money
- How much was transferred
- When the transfer occurred
- What bank or wallet provider was used

### 2. TransferStatus

`TransferStatus` is an enum representing the various states a transfer can be in:

- **pending**: The transfer is being processed
- **completed**: The transfer was successfully completed
- **failed**: The transfer failed due to an error
- **rejected**: The transfer was rejected by the recipient or bank
- **awaitingApproval**: The transfer is waiting for approval
- **canceled**: The transfer was canceled by the sender

The enum includes utility methods like `displayName` for UI display and `isFinal` to check if the status can change.

### 3. Transaction

`Transaction` combines a `Transfer` with its current `TransferStatus` to provide a complete picture of a money movement. It includes:

- The transfer details
- The current status
- The creation and completion timestamps
- Any failure reason if applicable

It provides useful methods for checking transaction state and generating user-friendly summaries.

### 4. BankAccount

`BankAccount` represents a user's bank account in the system, containing:

- Account number
- Account holder name
- Bank name and code
- Available balance
- Whether it's an internal account (within Goh Betoch Bank)

It includes utility methods like `maskedAccountNumber` for secure display and `hasSufficientFunds` for balance checking.

### 5. WalletAccount

`WalletAccount` represents a user's mobile wallet, containing:

- Phone number associated with the wallet
- Wallet provider (telebir, M-PESA)
- Account holder name (if available)
- Available balance

It includes utility methods like `maskedPhoneNumber` for secure display, `accountHolderInitials` for UI display, and `hasSufficientFunds` for balance checking.

## Usage Examples

### Bank Transfer Example

```dart
// Create a bank account entity
final senderAccount = BankAccount(
  accountNumber: AccountNumber('1234567890'),
  accountHolderName: 'Bereket Tefera',
  bankName: 'Goh Betoch Bank',
  bankCode: BankCode.gohBetoch(),
  availableBalance: Money(amount: 10000.0),
  isInternal: true,
);

// Create a transfer to another internal account
final transfer = InternalBankTransfer(
  id: TransferId(),
  receiverAccountNumber: AccountNumber('0987654321'),
  amount: Money(amount: 500.0),
  timestamp: DateTime.now(),
  reason: TransferReason('School fees'),
  senderName: senderAccount.accountHolderName,
  receiverName: 'Abebe Kebede',
  bankName: 'Goh Betoch Bank',
);

// Create a transaction with the transfer
final transaction = Transaction(
  transfer: transfer,
  status: TransferStatus.pending,
  createdAt: DateTime.now(),
);

// Later, update the transaction status
final completedTransaction = transaction.copyWithStatus(
  TransferStatus.completed,
);

// Display transaction summary
print(completedTransaction.summary);
// Output: Sent 500.00 ETB to Abebe Kebede (Goh Betoch Bank) - Completed
```

### Wallet Transfer Example

```dart
// Create a wallet account entity
final walletAccount = WalletAccount(
  phoneNumber: PhoneNumber('+251 912345678'),
  provider: WalletProvider.telebir(),
  accountHolderName: 'Abebe Kebede',
  availableBalance: Money(amount: 2000.0),
);

// Create a wallet transfer
final transfer = WalletTransfer(
  id: TransferId(),
  receiverPhone: PhoneNumber('+251 987654321'),
  walletProvider: WalletProvider.telebir(),
  amount: Money(amount: 200.0),
  fee: Money(amount: 5.0),
  timestamp: DateTime.now(),
  reason: TransferReason('Mobile credit'),
  senderName: 'Bereket Tefera',
  receiverName: 'Chaltu Tadesse',
);

// Create a transaction with the transfer
final transaction = Transaction(
  transfer: transfer,
  status: TransferStatus.pending,
  createdAt: DateTime.now(),
);

// Display transaction summary
print(transaction.summary);
// Output: Sent 200.00 ETB to Chaltu Tadesse (telebir) - Pending
```

## Entity Relationships

- A `Transfer` is part of a `Transaction`
- A `Transaction` has one `TransferStatus`
- A `BankAccount` can be the source or destination of an `InternalBankTransfer` or `ExternalBankTransfer`
- A `WalletAccount` can be the destination of a `WalletTransfer`

This entity model provides a rich domain representation for the transfer feature, ensuring type safety and domain integrity while exposing useful business methods. 