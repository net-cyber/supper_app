# External Transfer BLoC with Dependency Injection

This document explains how to use the External Transfer BLoC with the dependency injection (DI) setup in the Super App.

## Dependency Setup

The application uses GetIt for dependency injection, which is configured in `lib/core/di/dependancy_manager.dart`. The dependencies are set up as follows:

1. **Repository Dependencies**:
   - `BankAccountRepository` - For bank account operations and verification
   - `TransferRepository` - For transfer operations and fee calculation
   - `WalletRepository` - For wallet operations

2. **BLoC Dependencies**:
   - `ExternalTransferBloc` - Requires `BankAccountRepository` and `TransferRepository`
   - `InternalTransferBloc` - Requires `BankAccountRepository` and `TransferRepository`
   - `WalletTransferBloc` - Requires `WalletRepository` and `TransferRepository`

## Using External Transfer BLoC in UI

### Option 1: Use BlocProvider with GetIt

```dart
@override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (context) => getIt<ExternalTransferBloc>()
      ..add(const ExternalTransferEvent.loadBanks()),
    child: const ExternalBankTransferScreen(),
  );
}
```

### Option 2: Use the inject helper function

```dart
@override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (context) => inject<ExternalTransferBloc>()
      ..add(const ExternalTransferEvent.loadBanks()),
    child: const ExternalBankTransferScreen(),
  );
}
```

## Implementing UI with BLoC

Your UI can interact with the BLoC as follows:

```dart
class ExternalBankTransferScreen extends StatelessWidget {
  const ExternalBankTransferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transfer to External Bank')),
      body: BlocConsumer<ExternalTransferBloc, ExternalTransferState>(
        listener: (context, state) {
          // Handle state changes that require UI feedback
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
          
          if (state.status == ExternalTransferStatus.success) {
            // Navigate to success screen
            context.pushNamed(RouteName.transactionDetail, extra: {
              'transactionId': state.transactionId,
              'type': 'External Bank Transfer',
              'amount': state.amount!.formatted,
              'status': 'Completed',
              'recipient': state.validatedAccount!.accountHolderName,
              'date': DateTime.now(),
            });
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          // Build UI based on current state
          switch (state.status) {
            case ExternalTransferStatus.initial:
            case ExternalTransferStatus.loadingBanks:
              return const Center(child: CircularProgressIndicator());
              
            case ExternalTransferStatus.banksLoaded:
              return _buildBankSelectionView(context, state);
              
            case ExternalTransferStatus.bankSelected:
              return _buildAccountEntryView(context, state);
              
            case ExternalTransferStatus.accountValidated:
              return _buildAmountEntryView(context, state);
              
            case ExternalTransferStatus.feeCalculated:
              return _buildConfirmationView(context, state);
              
            default:
              return _buildCurrentStateView(context, state);
          }
        },
      ),
    );
  }
  
  // UI builder methods would go here...
  
  void _dispatchBankSelected(BuildContext context, Map<String, dynamic> bank) {
    context.read<ExternalTransferBloc>().add(
      ExternalTransferEvent.bankSelected(bank),
    );
  }
  
  void _dispatchValidateAccount(BuildContext context) {
    context.read<ExternalTransferBloc>().add(
      const ExternalTransferEvent.validateAccount(),
    );
  }
  
  // Other dispatch methods...
}
```

## Key Benefits of This Approach

1. **Separation of Concerns**: The BLoC handles business logic, the UI responds to state changes.
2. **Testability**: All components (repositories, BLoCs) can be tested independently.
3. **Reusability**: Dependencies are centrally managed and can be reused across the application.
4. **Maintainability**: Easy to add or modify features without affecting other parts of the application.

## Error Handling

The BLoC includes comprehensive error handling that maps domain-specific failures to user-friendly messages. These errors are accessible through the `errorMessage` property of the state.

## State Transitions

The `ExternalTransferStatus` enum provides a clear way to track the current stage of the transfer process:

1. Initial state → Load banks → Select bank → Enter account number → Validate account → Enter amount → Calculate fee → Confirm transfer → Submit

Each state transition corresponds to a specific user action and BLoC event. 