import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/app_connectivity.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/transf/domain/entities/external_transfer/external_transfer.dart';
import 'package:super_app/features/transf/domain/entities/external_transfer/external_transfer_request.dart';
import 'package:super_app/features/transf/domain/repositories/external_transfer_repository.dart';

part 'external_transfer_event.dart';
part 'external_transfer_state.dart';
part 'external_transfer_bloc.freezed.dart';

@injectable
class ExternalTransferBloc extends Bloc<ExternalTransferEvent, ExternalTransferState> {
  ExternalTransferBloc(
    this._externalTransferRepository,
    this._accountsBloc,
  ) : super(ExternalTransferState.initial()) {
    on<TransferDetailsChanged>(_onTransferDetailsChanged);
    on<CreateTransferSubmitted>(_onCreateTransferSubmitted);
  }

  final ExternalTransferRepository _externalTransferRepository;
  final AccountsBloc _accountsBloc;

  void _onTransferDetailsChanged(
      TransferDetailsChanged event, Emitter<ExternalTransferState> emit) {
    emit(
      state.copyWith(
        fromAccountId: event.fromAccountId,
        toBankCode: event.toBankCode,
        toAccountNumber: event.toAccountNumber,
        amount: event.amount,
        currency: event.currency,
        description: event.description,
        transferError: false,
        errorMessage: '',
        isTransferred: false,
        transferResponse: null,
      ),
    );
  }

  Future<void> _onCreateTransferSubmitted(
      CreateTransferSubmitted event, Emitter<ExternalTransferState> emit) async {
    log('ExternalTransferBloc: Starting create transfer submission');

    // Validate input
    if (state.fromAccountId <= 0) {
      log('ExternalTransferBloc: Invalid source account ID: ${state.fromAccountId}');
      emit(
        state.copyWith(
          transferError: true,
          errorMessage: 'Invalid source account',
        ),
      );
      return;
    }

    if (state.toBankCode.isEmpty) {
      log('ExternalTransferBloc: Invalid bank code');
      emit(
        state.copyWith(
          transferError: true,
          errorMessage: 'Bank code is required',
        ),
      );
      return;
    }

    if (state.toAccountNumber.isEmpty) {
      log('ExternalTransferBloc: Invalid account number');
      emit(
        state.copyWith(
          transferError: true,
          errorMessage: 'Account number is required',
        ),
      );
      return;
    }

    if (state.amount <= 0) {
      log('ExternalTransferBloc: Invalid amount: ${state.amount}');
      emit(
        state.copyWith(
          transferError: true,
          errorMessage: 'Amount must be greater than zero',
        ),
      );
      return;
    }

    if (state.currency.isEmpty) {
      log('ExternalTransferBloc: Empty currency, defaulting to ETB');
      emit(
        state.copyWith(
          transferError: true,
          errorMessage: 'Currency is required',
          currency: 'ETB', // Default to ETB
        ),
      );
      return;
    }

    // Set transferring state
    log('ExternalTransferBloc: Setting transferring state to true');
    emit(state.copyWith(isTransferring: true));

    // Check internet connection
    final hasConnectivity = await AppConnectivity.connectivity();
    log('ExternalTransferBloc: Internet connectivity check: $hasConnectivity');

    if (!hasConnectivity) {
      log('ExternalTransferBloc: No internet connection');
      emit(
        state.copyWith(
          isTransferring: false,
          transferError: true,
          errorMessage: 'No internet connection. Please check your network.',
        ),
      );
      return;
    }

    // Use provided account ID or get from AccountsBloc if needed
    int fromAccountId = state.fromAccountId;
    log('ExternalTransferBloc: Initial account ID - from: $fromAccountId');

    // If account ID is not provided, get the ETB account from AccountsBloc
    if (fromAccountId <= 0 && state.currency.toUpperCase() == 'ETB') {
      log('ExternalTransferBloc: Source account ID is 0, trying to get from AccountsBloc');
      final accountsState = _accountsBloc.state;

      if (accountsState.accounts.isEmpty) {
        log('ExternalTransferBloc: No accounts available in AccountsBloc');
        emit(
          state.copyWith(
            isTransferring: false,
            transferError: true,
            errorMessage: 'No accounts available. Please try again later.',
          ),
        );
        return;
      }

      log('ExternalTransferBloc: AccountsBloc has ${accountsState.accounts.length} accounts');

      try {
        final etbAccount = accountsState.accounts.firstWhere(
          (account) =>
              account.currency.toLowerCase() == 'etb' ||
              account.currency.toLowerCase() == 'birr',
          orElse: () => accountsState.accounts.first,
        );

        fromAccountId = etbAccount.id;
        log('ExternalTransferBloc: Found source account - id: ${etbAccount.id}, currency: ${etbAccount.currency}');
      } catch (e) {
        log('ExternalTransferBloc: Error finding ETB account: $e');
        emit(
          state.copyWith(
            isTransferring: false,
            transferError: true,
            errorMessage: 'Unable to find a valid source account.',
          ),
        );
        return;
      }
    }

    log('ExternalTransferBloc: Final transfer parameters - fromAccountId: $fromAccountId, toBankCode: ${state.toBankCode}, toAccountNumber: ${state.toAccountNumber}, amount: ${state.amount}, currency: ${state.currency}');

    try {
      log('ExternalTransferBloc: Calling transfer repository');
      final request = ExternalTransferRequest(
        fromAccountId: fromAccountId,
        toBankCode: state.toBankCode,
        toAccountNumber: state.toAccountNumber,
        amount: state.amount,
        currency: state.currency,
        description: state.description,
      );

      final result = await _externalTransferRepository.makeExternalTransfer(request);

      log('ExternalTransferBloc: Got result from transfer repository');

      result.fold(
        (failure) {
          log('ExternalTransferBloc: Transfer failed: ${failure.toString()}');
          emit(
            state.copyWith(
              isTransferring: false,
              transferError: true,
              errorMessage: NetworkExceptions.getRawErrorMessage(failure),
            ),
          );
        },
        (transferResponse) {
          log('ExternalTransferBloc: Transfer successful, ID: ${transferResponse.id}');
          emit(
            state.copyWith(
              isTransferring: false,
              isTransferred: true,
              transferResponse: transferResponse,
            ),
          );
        },
      );
    } catch (e) {
      log('ExternalTransferBloc: Unexpected error during transfer: $e');
      emit(
        state.copyWith(
          isTransferring: false,
          transferError: true,
          errorMessage: 'An unexpected error occurred: ${e.toString()}',
        ),
      );
    }
  }
} 