import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/app_connectivity.dart';
import 'package:super_app/features/transf/application/internal_transfer/bloc/internal_transfer_event.dart';
import 'package:super_app/features/transf/application/internal_transfer/bloc/internal_transfer_state.dart';
import 'package:super_app/features/transf/domain/failures/failure.dart';
import 'package:super_app/features/transf/domain/repositories/transfer_repository.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

@injectable
class InternalTransferBloc
    extends Bloc<InternalTransferEvent, InternalTransferState> {
  final TransferRepository _transferRepository;

  // Hard-coded sender account for demonstration
  // In a real app, this would come from a user account repository
  final AccountNumber _senderAccount = AccountNumber('1234567890');

  InternalTransferBloc(this._transferRepository)
      : super(InternalTransferState.initial()) {
    on<AccountNumberChanged>(_onAccountNumberChanged);
    on<VerifyAccount>(_onVerifyAccount);
    on<AmountChanged>(_onAmountChanged);
    on<ReasonChanged>(_onReasonChanged);
    on<SubmitTransfer>(_onSubmitTransfer);
    on<ResetState>(_onResetState);

    // Fetch account balance when the bloc is initialized
    _fetchAccountBalance();
  }

  /// Fetch the account balance from the repository
  Future<void> _fetchAccountBalance() async {
    final result = await _transferRepository.getAccountBalance(_senderAccount);
    result.fold(
      (failure) => null, // Handle error silently
      (balance) {
        if (!isClosed) {
          emit(state.copyWith(accountBalance: balance));
        }
      },
    );
  }

  void _onAccountNumberChanged(
    AccountNumberChanged event,
    Emitter<InternalTransferState> emit,
  ) {
    final accountNumber = AccountNumber(event.accountNumber);
    emit(state.copyWith(
      accountNumber: accountNumber,
      // Reset verification status when account number changes
      verificationStatus: VerificationStatus.initial,
      accountHolderName: '',
      showErrorMessages: false,
    ));
  }

  Future<void> _onVerifyAccount(
    VerifyAccount event,
    Emitter<InternalTransferState> emit,
  ) async {
    final accountNumber = AccountNumber(event.accountNumber);

    // Don't verify if account number is invalid
    if (!accountNumber.isValid()) {
      emit(state.copyWith(
        showErrorMessages: true,
        verificationStatus: VerificationStatus.failure,
      ));
      return;
    }

    // Check internet connectivity
    final connected = await AppConnectivity.connectivity();
    if (!connected) {
      emit(state.copyWith(
        verificationStatus: VerificationStatus.failure,
        failure: const Failure.networkError(
            'No internet connection. Please check your network.'),
      ));
      return;
    }

    // Start verification
    emit(state.copyWith(
      verificationStatus: VerificationStatus.loading,
      accountNumber: accountNumber,
    ));

    // Call repository to verify account
    final result = await _transferRepository.verifyAccount(accountNumber);

    // Handle result
    result.fold(
      (failure) => emit(state.copyWith(
        verificationStatus: VerificationStatus.failure,
        failure: failure,
      )),
      (accountHolderName) => emit(state.copyWith(
        verificationStatus: VerificationStatus.success,
        accountHolderName: accountHolderName,
        accountNumber: accountNumber,
      )),
    );
  }

  Future<void> _onAmountChanged(
    AmountChanged event,
    Emitter<InternalTransferState> emit,
  ) async {
    // Try to parse amount string to double
    try {
      final parsedAmount = double.parse(event.amount);
      final amount = Amount(parsedAmount);

      // If we don't have the balance yet, fetch it
      if (state.accountBalance == null) {
        await _fetchAccountBalance();
      }

      // Quick check against local balance for immediate feedback
      // This improves UX by not waiting for network calls
      if (state.accountBalance != null &&
          parsedAmount > state.accountBalance!) {
        emit(state.copyWith(
          amount: amount,
          showErrorMessages: true,
          hasSufficientFunds: false,
          failure: Failure.insufficientFunds(
            'Insufficient funds. Available balance: ${state.accountBalance!.toStringAsFixed(2)} ETB',
          ),
        ));
        return;
      }

      // Now call backend to verify sufficient funds (the authoritative check)
      final hasSufficientFundsResult =
          await _transferRepository.hasSufficientFunds(
        accountNumber: _senderAccount,
        amount: amount,
      );

      // Handle the result from backend
      hasSufficientFundsResult.fold(
        (failure) {
          // If there's an error checking funds, assume not sufficient for safety
          emit(state.copyWith(
            amount: amount,
            showErrorMessages: true,
            hasSufficientFunds: false,
            failure: failure,
          ));
        },
        (hasFunds) {
          // If backend says insufficient funds, also refresh the balance
          if (!hasFunds) {
            _fetchAccountBalance(); // Update balance in background
          }

          emit(state.copyWith(
            amount: amount,
            showErrorMessages: !hasFunds,
            hasSufficientFunds: hasFunds,
            failure: hasFunds
                ? null
                : Failure.insufficientFunds(
                    'Insufficient funds. Available balance: ${state.accountBalance != null ? state.accountBalance!.toStringAsFixed(2) : "Unknown"} ETB',
                  ),
          ));
        },
      );
    } catch (e) {
      // If parsing fails, set an invalid amount
      emit(state.copyWith(
        amount: Amount(0),
        showErrorMessages: true,
      ));
    }
  }

  void _onReasonChanged(
    ReasonChanged event,
    Emitter<InternalTransferState> emit,
  ) {
    emit(state.copyWith(reason: event.reason));
  }

  Future<void> _onSubmitTransfer(
    SubmitTransfer event,
    Emitter<InternalTransferState> emit,
  ) async {
    // Check internet connectivity
    final connected = await AppConnectivity.connectivity();
    if (!connected) {
      emit(state.copyWith(
        transferStatus: TransferStatus.failure,
        failure: const Failure.networkError(
            'No internet connection. Please check your network.'),
      ));
      return;
    }

    // Always fetch the latest balance before submitting the transfer
    await _fetchAccountBalance();

    // Check again if there are sufficient funds with fresh data from backend
    final hasSufficientFundsResult =
        await _transferRepository.hasSufficientFunds(
      accountNumber: _senderAccount,
      amount: event.amount,
    );

    // If insufficient funds, emit failure
    final hasSufficientFunds = hasSufficientFundsResult.fold(
      (failure) {
        emit(state.copyWith(
          transferStatus: TransferStatus.failure,
          failure: failure,
        ));
        return false;
      },
      (hasFunds) => hasFunds,
    );

    // Don't proceed if no funds
    if (!hasSufficientFunds) {
      emit(state.copyWith(
        transferStatus: TransferStatus.failure,
        hasSufficientFunds: false,
        failure: Failure.insufficientFunds(
          'Insufficient funds. Available balance: ${state.accountBalance?.toStringAsFixed(2) ?? "Unknown"} ETB',
        ),
      ));
      return;
    }

    // Start transfer process
    emit(state.copyWith(transferStatus: TransferStatus.loading));

    // Execute transfer
    final result = await _transferRepository.transfer(
      fromAccountNumber: _senderAccount,
      toAccountNumber: event.toAccountNumber,
      amount: event.amount,
      reference: event.reason,
      description: event.reason,
    );

    // Handle result
    result.fold(
      (failure) => emit(state.copyWith(
        transferStatus: TransferStatus.failure,
        failure: failure,
      )),
      (transferResult) async {
        // Get updated balance after successful transfer
        final updatedBalanceResult =
            await _transferRepository.getAccountBalance(_senderAccount);
        double? newBalance;
        updatedBalanceResult.fold(
          (failure) => null,
          (balance) => newBalance = balance,
        );

        emit(state.copyWith(
          transferStatus: TransferStatus.success,
          transferResult: transferResult,
          accountBalance: newBalance,
        ));
      },
    );
  }

  void _onResetState(
    ResetState event,
    Emitter<InternalTransferState> emit,
  ) {
    emit(InternalTransferState.initial());
  }
}
