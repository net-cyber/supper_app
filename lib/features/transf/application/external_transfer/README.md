# External Transfer BLoC Implementation

This directory contains the BLoC (Business Logic Component) implementation for the external bank transfer feature. The external transfer feature allows users to transfer money from their account to accounts at other banks.

## Files in this Directory

- `external_transfer_state.dart`: Defines the state class and status enum for the external transfer flow.
- `external_transfer_event.dart`: Defines all events that can occur during the external transfer flow.
- `external_transfer_bloc.dart`: Contains the core business logic for handling events and updating state.

## Architecture Overview

This implementation follows the BLoC pattern for state management and uses the Freezed package to reduce boilerplate code.

### State Management

The external transfer flow is managed using a state machine approach with clearly defined states represented by the `ExternalTransferStatus` enum. The state transitions are as follows:

1. `initial` → `loadingBanks`: When the user enters the external transfer screen
2. `loadingBanks` → `banksLoaded`: When the list of supported banks is loaded
3. `banksLoaded` → `bankSelected`: When the user selects a bank
4. `bankSelected` → `validatingAccount`: When the user inputs an account number and initiates validation
5. `validatingAccount` → `accountValidated` or `accountValidationFailed`: Depending on validation result
6. `accountValidated` → `calculatingFee`: When the user enters an amount and initiates fee calculation
7. `calculatingFee` → `feeCalculated`: When the fee is successfully calculated
8. `feeCalculated` → `submitting`: When the user submits the transfer
9. `submitting` → `success` or `failure`: Depending on the transfer result

### Features Implemented

- Loading and selecting external banks
- Account number validation against the selected bank
- Dynamic fee calculation based on transfer amount and bank
- Transfer submission and confirmation
- Comprehensive error handling
- Form validation
- User-friendly error messages

## How to Use

To use this BLoC in your UI, follow these steps:

1. Create a BLoC provider:
```dart
BlocProvider(
  create: (context) => ExternalTransferBloc(
    bankAccountRepository: getIt<BankAccountRepository>(),
    transferRepository: getIt<TransferRepository>(),
  )..add(const ExternalTransferEvent.loadBanks()),
  child: const ExternalTransferScreen(),
),
```

2. Listen to state changes and dispatch events from the UI:
```dart
BlocListener<ExternalTransferBloc, ExternalTransferState>(
  listener: (context, state) {
    // Handle state changes
  },
  child: BlocBuilder<ExternalTransferBloc, ExternalTransferState>(
    builder: (context, state) {
      // Build UI based on state
    },
  ),
)
```

## Integration Notes

For repository implementers, ensure the following methods are implemented:
- `BankAccountRepository.getSupportedExternalBanks()`: Should return a list of available external banks.
- `BankAccountRepository.verifyExternalAccountNumber()`: Should validate an account number with the specified bank.
- `TransferRepository.calculateExternalTransferFee()`: Should calculate the fee for an external transfer.
- `TransferRepository.initiateExternalTransfer()`: Should process the external transfer and return a transaction.

## Error Handling

The BLoC includes comprehensive error handling that maps domain-specific `TransferFailure` objects to user-friendly messages. Each error case (e.g., insufficient funds, network issues, server problems) is handled appropriately with specific error messages. 