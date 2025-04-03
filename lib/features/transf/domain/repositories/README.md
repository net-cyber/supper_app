# Transfer Feature Repositories

This directory contains the repository interfaces for the Transfer feature of the Super App. These interfaces define the contract between the domain layer and the data layer, following the Repository pattern.

## Repository Pattern

The Repository pattern is used to abstract the data sources from the rest of the application. It provides a clean API to access and manipulate data, hiding the details of data retrieval and persistence.

## Available Repositories

### 1. TransferRepository

`TransferRepository` handles the core transfer operations:

- **Initiating transfers**: Create internal bank transfers, external bank transfers, and wallet transfers
- **Retrieving transactions**: Get transactions by ID, get all transactions, or recent transactions
- **Managing transaction status**: Update status, cancel transactions

```dart
// Example of initiating an internal transfer
final result = await transferRepository.initiateInternalTransfer(
  receiverAccountNumber: AccountNumber('0987654321'),
  amount: Money(amount: 500.0),
  senderName: 'Bereket Tefera',
  receiverName: 'Abebe Kebede',
  bankName: 'Goh Betoch Bank',
  reason: TransferReason('School fees'),
);

result.fold(
  (failure) => print('Transfer failed: $failure'),
  (transaction) => print('Transfer initiated: ${transaction.summary}'),
);
```

### 2. BankAccountRepository

`BankAccountRepository` manages bank account-related operations:

- **Account verification**: Verify existence of bank accounts
- **Balance operations**: Get balances, check for sufficient funds
- **Saved accounts**: Manage favorite/saved bank accounts
- **Bank information**: Get list of supported banks

```dart
// Example of verifying an account number
final result = await bankAccountRepository.verifyAccountNumber(
  AccountNumber('1234567890'),
);

result.fold(
  (failure) => print('Verification failed: $failure'),
  (account) => print('Account verified: ${account.accountHolderName}'),
);
```

### 3. WalletRepository

`WalletRepository` handles mobile wallet operations:

- **Wallet providers**: Get available wallet providers
- **Wallet verification**: Verify if a phone number is associated with a wallet
- **Fee calculation**: Calculate transfer fees for wallet transfers
- **Frequent wallets**: Manage frequently used wallet accounts

```dart
// Example of verifying a wallet account
final result = await walletRepository.verifyWalletAccount(
  phoneNumber: PhoneNumber('+251 912345678'),
  provider: WalletProvider.telebir(),
);

result.fold(
  (failure) => print('Verification failed: $failure'),
  (wallet) => print('Wallet verified: ${wallet.summary}'),
);
```

## Error Handling

All repositories use `Either<TransferFailure<dynamic>, T>` for error handling, allowing for explicit error cases:

```dart
final result = await bankAccountRepository.hasSufficientFunds(
  Money(amount: 1000.0),
);

result.fold(
  (failure) => {
    if (failure is InsufficientFunds) {
      print('Insufficient funds, available: ${failure.available}')
    } else {
      print('Error: $failure')
    }
  },
  (hasFunds) => print('Has sufficient funds: $hasFunds'),
);
```

## Implementation Notes

When implementing these repositories:

1. **Data Sources**: Each repository might use multiple data sources (API, local database, etc.)
2. **Mapping**: Map between domain entities and data models
3. **Error Handling**: Convert data-layer exceptions to domain-specific failures
4. **Caching**: Consider implementing caching strategies for frequently accessed data 