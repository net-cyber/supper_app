import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/features/transf/application/wallet_transfer/wallet_transfer_event.dart';
import 'package:super_app/features/transf/application/wallet_transfer/wallet_transfer_state.dart';
import 'package:super_app/features/transf/domain/repositories/transfer_repository.dart';
import 'package:super_app/features/transf/domain/repositories/wallet_repository.dart';
import 'package:super_app/features/transf/domain/value_objects/failures.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

@injectable
class WalletTransferBloc
    extends Bloc<WalletTransferEvent, WalletTransferState> {
  final WalletRepository walletRepository;
  final TransferRepository transferRepository;

  WalletTransferBloc({
    required this.walletRepository,
    required this.transferRepository,
  }) : super(WalletTransferState.initial()) {
    on<LoadWalletProviders>(_onLoadWalletProviders);
    on<SelectWalletProvider>(_onSelectWalletProvider);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<ValidatePhoneNumber>(_onValidatePhoneNumber);
    on<AmountChanged>(_onAmountChanged);
    on<CalculateFee>(_onCalculateFee);
    on<ReasonChanged>(_onReasonChanged);
    on<SubmitTransfer>(_onSubmitTransfer);
    on<Reset>(_onReset);
  }

  Future<void> _onLoadWalletProviders(
    LoadWalletProviders event,
    Emitter<WalletTransferState> emit,
  ) async {
    emit(state.copyWith(
      status: WalletTransferStatus.loadingProviders,
      isLoading: true,
    ));

    final walletProvidersResult = await walletRepository.getWalletProviders();

    await walletProvidersResult.fold(
      (failure) async {
        emit(state.copyWith(
          status: WalletTransferStatus.failure,
          errorMessage: _mapFailureToMessage(failure),
          isLoading: false,
        ));
      },
      (providers) async {
        // Convert domain wallet providers to UI model
        final providerMaps = providers
            .map((provider) => {
                  'name': provider.getOrElse(''),
                  'code': provider.getOrElse(''),
                })
            .toList();

        emit(state.copyWith(
          status: WalletTransferStatus.providersLoaded,
          providers: providerMaps,
          isLoading: false,
        ));
      },
    );
  }

  void _onSelectWalletProvider(
    SelectWalletProvider event,
    Emitter<WalletTransferState> emit,
  ) {
    emit(state.copyWith(
      status: WalletTransferStatus.providerSelected,
      selectedProvider: event.provider,
    ));
  }

  void _onPhoneNumberChanged(
    PhoneNumberChanged event,
    Emitter<WalletTransferState> emit,
  ) {
    emit(state.copyWith(
      phoneNumberInput: event.phoneNumber,
    ));
  }

  Future<void> _onValidatePhoneNumber(
    ValidatePhoneNumber event,
    Emitter<WalletTransferState> emit,
  ) async {
    if (state.selectedProvider == null) {
      emit(state.copyWith(
        errorMessage: 'Please select a wallet provider first',
      ));
      return;
    }

    final phoneNumber = state.phoneNumber;
    if (phoneNumber == null) {
      emit(state.copyWith(
        errorMessage: 'Please enter a valid phone number',
      ));
      return;
    }

    emit(state.copyWith(
      status: WalletTransferStatus.validatingPhone,
      isLoading: true,
      errorMessage: null,
    ));

    final walletProvider =
        WalletProvider(state.selectedProvider!['name'] as String);
    final result = await walletRepository.verifyWalletAccount(
      phoneNumber: phoneNumber,
      provider: walletProvider,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: WalletTransferStatus.phoneValidationFailed,
          errorMessage: _mapFailureToMessage(failure),
          isLoading: false,
        ));
      },
      (walletAccount) {
        emit(state.copyWith(
          status: WalletTransferStatus.phoneValidated,
          validatedWallet: walletAccount,
          isLoading: false,
        ));
      },
    );
  }

  void _onAmountChanged(
    AmountChanged event,
    Emitter<WalletTransferState> emit,
  ) {
    emit(state.copyWith(
      amountInput: event.amount,
    ));
  }

  Future<void> _onCalculateFee(
    CalculateFee event,
    Emitter<WalletTransferState> emit,
  ) async {
    if (state.selectedProvider == null) {
      emit(state.copyWith(
        errorMessage: 'Please select a wallet provider first',
      ));
      return;
    }

    final amount = state.amount;
    if (amount == null) {
      emit(state.copyWith(
        errorMessage: 'Please enter a valid amount',
      ));
      return;
    }

    emit(state.copyWith(
      status: WalletTransferStatus.calculatingFee,
      isLoading: true,
      errorMessage: null,
    ));

    final walletProvider =
        WalletProvider(state.selectedProvider!['name'] as String);
    final result = await walletRepository.calculateWalletTransferFee(
      amount: amount,
      provider: walletProvider,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          errorMessage: _mapFailureToMessage(failure),
          isLoading: false,
        ));
      },
      (fee) {
        emit(state.copyWith(
          status: WalletTransferStatus.feeCalculated,
          calculatedFee: fee.value.fold(
            (_) => 0.0,
            (value) => value,
          ),
          isLoading: false,
        ));
      },
    );
  }

  void _onReasonChanged(
    ReasonChanged event,
    Emitter<WalletTransferState> emit,
  ) {
    emit(state.copyWith(
      reasonInput: event.reason,
    ));
  }

  Future<void> _onSubmitTransfer(
    SubmitTransfer event,
    Emitter<WalletTransferState> emit,
  ) async {
    // Validate required fields
    if (state.selectedProvider == null ||
        state.phoneNumber == null ||
        state.amount == null ||
        state.fee == null) {
      emit(state.copyWith(
        errorMessage: 'Please fill in all required fields',
      ));
      return;
    }

    emit(state.copyWith(
      status: WalletTransferStatus.submitting,
      isLoading: true,
      errorMessage: null,
    ));

    final result = await transferRepository.initiateWalletTransfer(
      receiverPhone: state.phoneNumber!,
      walletProvider: state.walletProvider!,
      amount: state.amount!,
      fee: state.fee!,
      senderName:
          'Current User', // This would come from a user repository in a real app
      receiverName: state.validatedWallet?.accountHolderName,
      reason: state.reason,
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: WalletTransferStatus.failure,
          errorMessage: _mapFailureToMessage(failure),
          isLoading: false,
        ));
      },
      (transaction) {
        emit(state.copyWith(
          status: WalletTransferStatus.success,
          isSuccess: true,
          transactionId: transaction.transfer.id.getOrElse(''),
          isLoading: false,
        ));
      },
    );
  }

  void _onReset(
    Reset event,
    Emitter<WalletTransferState> emit,
  ) {
    emit(WalletTransferState.initial());
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
