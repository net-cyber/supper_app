import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/features/transf/application/external_transfer/external_transfer_event.dart';
import 'package:super_app/features/transf/application/external_transfer/external_transfer_state.dart';
import 'package:super_app/features/transf/domain/repositories/bank_account_repository.dart';
import 'package:super_app/features/transf/domain/repositories/transfer_repository.dart';
import 'package:super_app/features/transf/domain/value_objects/failures.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

@injectable
class ExternalTransferBloc
    extends Bloc<ExternalTransferEvent, ExternalTransferState> {
  final BankAccountRepository bankAccountRepository;
  final TransferRepository transferRepository;

  ExternalTransferBloc({
    required this.bankAccountRepository,
    required this.transferRepository,
  }) : super(ExternalTransferState.initial()) {
    on<ExternalTransferEvent>((event, emit) {
      event.map(
        loadBanks: (e) => _onLoadBanks(e, emit),
        bankSelected: (e) => _onBankSelected(e, emit),
        accountNumberChanged: (e) => _onAccountNumberChanged(e, emit),
        validateAccount: (e) => _onValidateAccount(e, emit),
        amountChanged: (e) => _onAmountChanged(e, emit),
        calculateFee: (e) => _onCalculateFee(e, emit),
        reasonChanged: (e) => _onReasonChanged(e, emit),
        submitTransfer: (e) => _onSubmitTransfer(e, emit),
        reset: (e) => _onReset(e, emit),
      );
    });
  }

  Future<void> _onLoadBanks(
    LoadBanks event,
    Emitter<ExternalTransferState> emit,
  ) async {
    emit(state.copyWith(
      status: ExternalTransferStatus.loadingBanks,
      isLoading: true,
      errorMessage: null,
    ));

    final result = await bankAccountRepository.getSupportedExternalBanks();

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: ExternalTransferStatus.failure,
          errorMessage: _mapFailureToMessage(failure),
          isLoading: false,
        ));
      },
      (banks) {
        emit(state.copyWith(
          status: ExternalTransferStatus.banksLoaded,
          banks: banks,
          isLoading: false,
        ));
      },
    );
  }

  void _onBankSelected(
    BankSelected event,
    Emitter<ExternalTransferState> emit,
  ) {
    emit(state.copyWith(
      status: ExternalTransferStatus.bankSelected,
      selectedBank: event.bank,
      // Clear validated account when bank changes
      validatedAccount: null,
    ));
  }

  void _onAccountNumberChanged(
    AccountNumberChanged event,
    Emitter<ExternalTransferState> emit,
  ) {
    emit(state.copyWith(
      accountNumberInput: event.accountNumber,
      // Clear validated account if account number changes
      validatedAccount: event.accountNumber == state.accountNumberInput
          ? state.validatedAccount
          : null,
      status: event.accountNumber == state.accountNumberInput
          ? state.status
          : ExternalTransferStatus
              .bankSelected, // Go back to bank selected state
    ));
  }

  Future<void> _onValidateAccount(
    ValidateAccount event,
    Emitter<ExternalTransferState> emit,
  ) async {
    final accountNumber = state.accountNumber;
    final bankCode = state.bankCode;

    if (accountNumber == null || !accountNumber.isValid()) {
      emit(state.copyWith(
        errorMessage: 'Please enter a valid account number',
      ));
      return;
    }

    if (bankCode == null || !bankCode.isValid()) {
      emit(state.copyWith(
        errorMessage: 'Please select a bank',
      ));
      return;
    }

    emit(state.copyWith(
      status: ExternalTransferStatus.validatingAccount,
      isLoading: true,
      errorMessage: null,
    ));

    final result = await bankAccountRepository.verifyExternalAccountNumber(
      accountNumber,
      bankCode,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: ExternalTransferStatus.accountValidationFailed,
          errorMessage: _mapFailureToMessage(failure),
          isLoading: false,
        ));
      },
      (account) {
        emit(state.copyWith(
          status: ExternalTransferStatus.accountValidated,
          validatedAccount: account,
          isLoading: false,
        ));
      },
    );
  }

  void _onAmountChanged(
    AmountChanged event,
    Emitter<ExternalTransferState> emit,
  ) {
    emit(state.copyWith(
      amountInput: event.amount,
      // Clear calculated fee if amount changes
      calculatedFee: null,
    ));
  }

  Future<void> _onCalculateFee(
    CalculateFee event,
    Emitter<ExternalTransferState> emit,
  ) async {
    final amount = state.amount;
    final bankCode = state.bankCode;

    if (amount == null || !amount.isValid()) {
      emit(state.copyWith(
        errorMessage: 'Please enter a valid amount',
      ));
      return;
    }

    if (bankCode == null || !bankCode.isValid()) {
      emit(state.copyWith(
        errorMessage: 'Please select a bank',
      ));
      return;
    }

    emit(state.copyWith(
      status: ExternalTransferStatus.calculatingFee,
      isLoading: true,
      errorMessage: null,
    ));

    final result = await transferRepository.calculateExternalTransferFee(
      amount,
      bankCode,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: ExternalTransferStatus.failure,
          errorMessage: _mapFailureToMessage(failure),
          isLoading: false,
        ));
      },
      (fee) {
        emit(state.copyWith(
          status: ExternalTransferStatus.feeCalculated,
          calculatedFee: fee.getOrElse(0),
          isLoading: false,
        ));
      },
    );
  }

  void _onReasonChanged(
    ReasonChanged event,
    Emitter<ExternalTransferState> emit,
  ) {
    emit(state.copyWith(
      reasonInput: event.reason,
    ));
  }

  Future<void> _onSubmitTransfer(
    SubmitTransfer event,
    Emitter<ExternalTransferState> emit,
  ) async {
    if (!state.canSubmit) {
      emit(state.copyWith(
        errorMessage: 'Please complete all required fields',
      ));
      return;
    }

    // Check if there are sufficient funds for the transfer
    final amountValue = state.amount!.value.fold(
      (_) => 0.0,
      (value) => value,
    );

    final feeValue = state.fee!.value.fold(
      (_) => 0.0,
      (value) => value,
    );

    final totalAmount = amountValue + feeValue;
    final totalMoney = Money(amount: totalAmount);

    final hasSufficientFunds =
        await bankAccountRepository.hasSufficientFunds(totalMoney);
    final hasFundsResult = await hasSufficientFunds.fold(
      (failure) => false,
      (hasEnough) => hasEnough,
    );

    if (!hasFundsResult) {
      emit(state.copyWith(
        errorMessage: 'Insufficient funds for this transfer including fees',
      ));
      return;
    }

    emit(state.copyWith(
      status: ExternalTransferStatus.submitting,
      isLoading: true,
      errorMessage: null,
    ));

    final result = await transferRepository.initiateExternalTransfer(
      receiverAccountNumber: state.accountNumber!,
      amount: state.amount!,
      fee: state.fee!,
      senderName:
          'Current User', // This would typically come from a user repository
      receiverName: state.validatedAccount!.accountHolderName,
      bankCode: state.bankCode!,
      bankName: state.selectedBank!['name'] as String,
      reason: state.reason,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: ExternalTransferStatus.failure,
          errorMessage: _mapFailureToMessage(failure),
          isLoading: false,
        ));
      },
      (transaction) {
        emit(state.copyWith(
          status: ExternalTransferStatus.success,
          isSuccess: true,
          transactionId: transaction.transfer.id.getOrElse(''),
          isLoading: false,
        ));
      },
    );
  }

  void _onReset(
    Reset event,
    Emitter<ExternalTransferState> emit,
  ) {
    emit(ExternalTransferState.initial());
  }

  String _mapFailureToMessage(TransferFailure<dynamic> failure) {
    return failure.map(
      invalidAccountNumber: (_) => 'Invalid account number',
      accountNotFound: (_) => 'Account not found',
      invalidPhoneNumber: (_) => 'Invalid phone number',
      phoneNumberNotFound: (_) => 'Phone number not found',
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
      unauthenticated: (_) => 'Please log in to continue',
      unauthorized: (_) => 'You are not authorized for this action',
      invalidInput: (failure) => failure.message,
    );
  }
}
