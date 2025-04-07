import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/features/transf/application/internal_transfer/internal_transfer_event.dart';
import 'package:super_app/features/transf/application/internal_transfer/internal_transfer_state.dart';
import 'package:super_app/features/transf/domain/entities/bank_account.dart';
import 'package:super_app/features/transf/domain/repositories/bank_account_repository.dart';
import 'package:super_app/features/transf/domain/repositories/transfer_repository.dart';
import 'package:super_app/features/transf/domain/value_objects/failures.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

@injectable
class InternalTransferBloc
    extends Bloc<InternalTransferEvent, InternalTransferState> {
  final BankAccountRepository bankAccountRepository;
  final TransferRepository transferRepository;

  InternalTransferBloc({
    required this.bankAccountRepository,
    required this.transferRepository,
  }) : super(InternalTransferState.initial()) {
    on<InternalTransferEvent>((event, emit) {
      event.map(
        accountNumberChanged: (e) => _onAccountNumberChanged(e, emit),
        validateAccount: (e) => _onValidateAccount(e, emit),
        amountChanged: (e) => _onAmountChanged(e, emit),
        reasonChanged: (e) => _onReasonChanged(e, emit),
        submitTransfer: (e) => _onSubmitTransfer(e, emit),
        reset: (e) => _onReset(e, emit),
      );
    });
  }

  void _onAccountNumberChanged(
    AccountNumberChanged event,
    Emitter<InternalTransferState> emit,
  ) {
    print('📱 BLoC: Account number changed to: ${event.accountNumber}');
    emit(state.copyWith(
      accountNumberInput: event.accountNumber,
      // Clear validated account if account number changes
      validatedAccount: event.accountNumber == state.accountNumberInput
          ? state.validatedAccount
          : null,
      status: event.accountNumber == state.accountNumberInput
          ? state.status
          : InternalTransferStatus.initial,
    ));
  }

  Future<void> _onValidateAccount(
    ValidateAccount event,
    Emitter<InternalTransferState> emit,
  ) async {
    print('🔍 Starting account validation');
    final accountNumber = state.accountNumber;
    print(
        '🔍 DEBUG: Current account number in state: ${accountNumber?.getOrElse('NULL')}');

    if (accountNumber == null || !accountNumber.isValid()) {
      print('❌ Invalid account number format');
      emit(state.copyWith(
        status: InternalTransferStatus.accountValidationFailed,
        errorMessage: 'Please enter a valid account number',
        isLoading: false,
      ));
      return;
    }

    // Get the account number as a string for debugging and validation
    final accountNumberStr = accountNumber.getOrElse('');
    print('⏳ Setting loading state, account number: "$accountNumberStr"');

    // Make sure we reset any previous validation state
    emit(state.copyWith(
      status: InternalTransferStatus.validatingAccount,
      isLoading: true,
      errorMessage: null,
      validatedAccount: null, // Reset any previous account data
    ));

    try {
      // Debug logging for mock accounts
      print('🔍 Available mock accounts: ${_listAvailableMockAccounts()}');
      print('🔄 Calling repository to verify account: "$accountNumberStr"');

      final result = await bankAccountRepository
          .verifyInternalAccountNumber(accountNumber);

      print('🔄 DEBUG: Repository returned. Processing result...');

      // Handle the result immediately after receiving it
      result.fold(
        (failure) {
          print(
              '❌ Account validation failed: ${_mapFailureToMessage(failure)}');
          emit(state.copyWith(
            status: InternalTransferStatus.accountValidationFailed,
            errorMessage: _mapFailureToMessage(failure),
            isLoading: false,
          ));
        },
        (account) {
          print(
              '✅ Account validated successfully: ${account.accountHolderName}');
          print(
              '✅ DEBUG: Account number: ${account.accountNumber.getOrElse('')}');
          print('✅ DEBUG: Account bank: ${account.bankName}');

          // Explicitly check the account is non-null
          if (account != null) {
            print('✅ DEBUG: About to update state with validated account');
            emit(state.copyWith(
              status: InternalTransferStatus.accountValidated,
              validatedAccount: account,
              isLoading: false,
            ));
            print(
                '✅ DEBUG: State updated with account holder: ${state.validatedAccount?.accountHolderName}');
          } else {
            print('⚠️ Account object is null despite successful validation');
            emit(state.copyWith(
              status: InternalTransferStatus.accountValidationFailed,
              errorMessage: 'Error retrieving account details',
              isLoading: false,
            ));
          }
        },
      );
    } catch (e) {
      print('⚠️ Exception during account validation: $e');
      emit(state.copyWith(
        status: InternalTransferStatus.accountValidationFailed,
        errorMessage: 'An unexpected error occurred: $e',
        isLoading: false,
      ));
    }
  }

  // Helper method to list mock accounts for debugging
  String _listAvailableMockAccounts() {
    try {
      // Attempt to get available accounts for debugging
      final accountsFuture = bankAccountRepository.getSavedBankAccounts();
      return "Mock account retrieval initiated";
    } catch (e) {
      return "Error retrieving mock accounts: $e";
    }
  }

  void _onAmountChanged(
    AmountChanged event,
    Emitter<InternalTransferState> emit,
  ) {
    emit(state.copyWith(
      amountInput: event.amount,
    ));
  }

  void _onReasonChanged(
    ReasonChanged event,
    Emitter<InternalTransferState> emit,
  ) {
    emit(state.copyWith(
      reasonInput: event.reason,
    ));
  }

  Future<void> _onSubmitTransfer(
    SubmitTransfer event,
    Emitter<InternalTransferState> emit,
  ) async {
    if (!state.canSubmit) {
      emit(state.copyWith(
        errorMessage: 'Please complete all required fields',
      ));
      return;
    }

    // Check if there are sufficient funds for the transfer
    final hasSufficientFunds =
        await bankAccountRepository.hasSufficientFunds(state.amount!);
    final hasFundsResult = await hasSufficientFunds.fold(
      (failure) => false,
      (hasEnough) => hasEnough,
    );

    if (!hasFundsResult) {
      emit(state.copyWith(
        errorMessage: 'Insufficient funds for this transfer',
      ));
      return;
    }

    emit(state.copyWith(
      status: InternalTransferStatus.submitting,
      isLoading: true,
      errorMessage: null,
    ));

    // Add debug statements to track the process
    print(
        '💸 Starting transfer submission: ${state.accountNumber?.getOrElse('')} - ${state.amount?.getOrElse(0)}');

    final result = await transferRepository.initiateInternalTransfer(
      receiverAccountNumber: state.accountNumber!,
      amount: state.amount!,
      senderName:
          'Current User', // This would typically come from a user repository
      receiverName: state.validatedAccount!.accountHolderName,
      bankName: 'Goh Betoch Bank', // Hardcoded for internal transfers
      reason: state.reason,
    );

    print('💸 Transfer result received from API');

    result.fold(
      (failure) {
        print('❌ Transfer failed: ${_mapFailureToMessage(failure)}');
        emit(state.copyWith(
          status: InternalTransferStatus.failure,
          errorMessage: _mapFailureToMessage(failure),
          isLoading: false,
        ));
      },
      (transaction) {
        print(
            '✅ Transfer succeeded! Transaction ID: ${transaction.transfer.id.getOrElse('')}');
        emit(state.copyWith(
          status: InternalTransferStatus.success,
          isSuccess: true,
          transactionId: transaction.transfer.id.getOrElse(''),
          isLoading: false,
        ));
      },
    );
  }

  void _onReset(
    Reset event,
    Emitter<InternalTransferState> emit,
  ) {
    emit(InternalTransferState.initial());
  }

  String _mapFailureToMessage(TransferFailure<dynamic> failure) {
    return failure.map(
      invalidAccountNumber: (_) => 'Invalid account number',
      accountNotFound: (_) => 'Account not found',
      invalidPhoneNumber: (_) => 'Invalid phone number',
      phoneNumberNotFound: (_) => 'Phone number not found',
      walletAccountNotFound: (_) => 'Wallet account not found',
      invalidWalletAccount: (_) => 'Invalid wallet account',
      invalidAmount: (_) => 'Invalid amount',
      insufficientFunds: (failure) =>
          'Insufficient funds. Available: ${failure.available} ETB',
      exceedsTransferLimit: (failure) =>
          'Amount exceeds transfer limit of ${failure.limit} ETB',
      belowMinimumAmount: (failure) =>
          'Amount below minimum of ${failure.minimum} ETB',
      serverError: (failure) => 'Server error: ${failure.message}',
      networkError: (_) => 'Network error, please check your connection',
      unexpected: (_) => 'An unexpected error occurred',
      transactionNotFound: (_) => 'Transaction not found',
      unauthenticated: (_) => 'Please log in to continue',
      unauthorized: (_) => 'You are not authorized for this action',
      invalidInput: (failure) => failure.message,
    );
  }
}
