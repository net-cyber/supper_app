# Transfer Feature Domain Layer

This directory contains the domain layer for the Transfer feature of the Super App, implementing a clean domain-driven design with functional programming principles.

## Contents

- **value_objects.dart**: Contains all value objects used in the transfer feature
- **failures.dart**: Defines all possible failures that can occur in the domain
- **value_validators.dart**: Contains validation logic for value objects

## Value Objects

Value objects in this implementation follow these principles:

1. **Self-validation**: Value objects validate themselves at creation
2. **Immutability**: Value objects are immutable
3. **Type safety**: Each value object has its own type
4. **Failure handling**: Value objects use `Either<TransferFailure, T>` for error handling

### Available Value Objects

- **TransferId**: Unique identifier for transfers
- **AccountNumber**: Bank account number validation
- **PhoneNumber**: Phone number with Ethiopian format validation
- **Money**: Monetary amount with currency handling and operations
- **TransferReason**: Optional reason for transfers
- **BankCode**: Bank code normalization for codes retrieved from the backend API
- **WalletProvider**: Wallet provider normalization for providers retrieved from the backend API

## API-Sourced Value Objects

Some value objects in this system represent data that comes from the backend API rather than direct user input:

### BankCode

Bank codes are retrieved when a user selects a bank from the UI:

```dart
// When using a bank code from the backend
final bankCode = BankCode.fromApi(bankData['code']);

// Predefined banks
final gohBank = BankCode.gohBetoch();
final cbeBank = BankCode.cbe();
```

### WalletProvider

Wallet providers are selected from the UI and handled by the domain layer:

```dart
// When retrieving from the API response
final provider = WalletProvider.fromApi(apiResponse['walletProvider']);

// Using the predefined factories
final telebir = WalletProvider.telebir();
final mpesa = WalletProvider.mpesa();
```

## Basic Usage Examples

### Validation with Either

```dart
// Creating a value object
final phoneNumber = PhoneNumber('+251 912345678');

// Using Either to safely handle the result
phoneNumber.value.fold(
  (failure) => print('Invalid phone number: $failure'),
  (validNumber) => print('Valid phone number: $validNumber')
);

// Checking validity
if (phoneNumber.isValid()) {
  // Use the phone number
}

// Getting the value (safely)
final number = phoneNumber.getOrElse('');

// Getting the value (unsafe, will throw on invalid)
try {
  final number = phoneNumber.getOrCrash();
} catch (e) {
  // Handle the error
}
```

### Money Operations

```dart
// Creating money values
final amount1 = Money(amount: 100.0);
final amount2 = Money(amount: 50.0);

// Adding values
final total = amount1.add(amount2);

// Subtracting
final remaining = amount1.subtract(amount2);

// Formatted output
print(total.formatted); // '150.00 ETB'
```

## Failure Handling

This implementation uses `TransferFailure` from `failures.dart` to represent all possible errors. Each failure contains the relevant context information to help with debugging and user feedback.

Examples:
- `invalidAccountNumber`: When an account number doesn't match the expected format
- `insufficientFunds`: When trying to transfer more money than available
- `invalidPhoneNumber`: When a phone number doesn't match Ethiopian format

## Error Propagation

The value objects use the functional programming approach with `Either` to ensure that errors are explicitly handled. This prevents runtime exceptions and forces developers to properly handle failure cases.

```dart
// Example of chaining operations with error handling
final result = phoneNumber.value.flatMap((validPhone) {
  return Money.fromString(amount: amountText).value.map((validAmount) {
    return initiateTransfer(validPhone, validAmount);
  });
});
```

This approach brings type safety and explicit error handling to the transfer feature, making the code more robust and maintainable. 