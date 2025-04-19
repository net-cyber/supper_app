import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/app_connectivity.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/transf/domain/entities/transfer_response/transfer_response.dart';
import 'package:super_app/features/transf/domain/repositories/transfer_repository.dart';

part 'transfer_event.dart';
part 'transfer_state.dart';
part 'transfer_bloc.freezed.dart';

@injectable
class TransferBloc extends Bloc<TransferEvent, TransferState> {
  TransferBloc(
    this._transferRepository,
    this._accountsBloc,
  ) : super(TransferState.initial()) {
    on<TransferDetailsChanged>(_onTransferDetailsChanged);
    on<CreateTransferSubmitted>(_onCreateTransferSubmitted);
  }

  final TransferRepository _transferRepository;
  final AccountsBloc _accountsBloc;

  void _onTransferDetailsChanged(
      TransferDetailsChanged event, Emitter<TransferState> emit) {
    emit(
      state.copyWith(
        fromAccountId: event.fromAccountId,
        toAccountId: event.toAccountId,
        amount: event.amount,
        currency: event.currency,
        transferError: false,
        errorMessage: '',
        isTransferred: false,
        transferResponse: null,
      ),
    );
  }

  Future<void> _onCreateTransferSubmitted(
      CreateTransferSubmitted event, Emitter<TransferState> emit) async {
    log('TransferBloc: Starting create transfer submission');

    // Validate input
    if (state.fromAccountId <= 0) {
      log('TransferBloc: Invalid source account ID: ${state.fromAccountId}');
      emit(
        state.copyWith(
          transferError: true,
          errorMessage: 'Invalid source account',
        ),
      );
      return;
    }

    if (state.toAccountId <= 0) {
      log('TransferBloc: Invalid destination account ID: ${state.toAccountId}');
      emit(
        state.copyWith(
          transferError: true,
          errorMessage: 'Invalid destination account',
        ),
      );
      return;
    }

    if (state.amount <= 0) {
      log('TransferBloc: Invalid amount: ${state.amount}');
      emit(
        state.copyWith(
          transferError: true,
          errorMessage: 'Amount must be greater than zero',
        ),
      );
      return;
    }

    if (state.currency.isEmpty) {
      log('TransferBloc: Empty currency, defaulting to ETB');
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
    log('TransferBloc: Setting transferring state to true');
    emit(state.copyWith(isTransferring: true));

    // Check internet connection
    final hasConnectivity = await AppConnectivity.connectivity();
    log('TransferBloc: Internet connectivity check: $hasConnectivity');

    if (!hasConnectivity) {
      log('TransferBloc: No internet connection');
      emit(
        state.copyWith(
          isTransferring: false,
          transferError: true,
          errorMessage: 'No internet connection. Please check your network.',
        ),
      );
      return;
    }

    // Use provided account IDs or get from AccountsBloc if needed
    int fromAccountId = state.fromAccountId;
    int toAccountId = state.toAccountId;
    log('TransferBloc: Initial account IDs - from: $fromAccountId, to: $toAccountId');

    // If account ID is not provided, get the ETB account from AccountsBloc
    if (fromAccountId <= 0 && state.currency.toUpperCase() == 'ETB') {
      log('TransferBloc: Source account ID is 0, trying to get from AccountsBloc');
      final accountsState = _accountsBloc.state;

      if (accountsState.accounts.isEmpty) {
        log('TransferBloc: No accounts available in AccountsBloc');
        emit(
          state.copyWith(
            isTransferring: false,
            transferError: true,
            errorMessage: 'No accounts available. Please try again later.',
          ),
        );
        return;
      }

      log('TransferBloc: AccountsBloc has ${accountsState.accounts.length} accounts');

      try {
        final etbAccount = accountsState.accounts.firstWhere(
          (account) =>
              account.currency.toLowerCase() == 'etb' ||
              account.currency.toLowerCase() == 'birr',
          orElse: () => accountsState.accounts.first,
        );

        fromAccountId = etbAccount.id;
        log('TransferBloc: Found source account - id: ${etbAccount.id}, currency: ${etbAccount.currency}');
      } catch (e) {
        log('TransferBloc: Error finding ETB account: $e');
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

    log('TransferBloc: Final transfer parameters - fromAccountId: $fromAccountId, toAccountId: $toAccountId, amount: ${state.amount}, currency: ${state.currency}');

    try {
      log('TransferBloc: Calling transfer repository');
      final result = await _transferRepository.createTransfer(
        fromAccountId: fromAccountId,
        toAccountId: toAccountId,
        amount: state.amount,
        currency: state.currency,
      );

      log('TransferBloc: Got result from transfer repository');

      result.fold(
        (failure) {
          log('TransferBloc: Transfer failed: ${failure.toString()}');
          emit(
            state.copyWith(
              isTransferring: false,
              transferError: true,
              errorMessage: NetworkExceptions.getRawErrorMessage(failure),
            ),
          );
        },
        (transferResponse) {
          log('TransferBloc: Transfer successful, ID: ${transferResponse.transferId}');
          emit(
            state.copyWith(
              isTransferring: false,
              isTransferred: true,
              transferResponse: transferResponse,
              transferId: transferResponse.transferId,
              status: transferResponse.status,
              transactionRef: transferResponse.transactionRef,
              timestamp: transferResponse.timestamp,
            ),
          );
        },
      );
    } catch (e) {
      log('TransferBloc: Unexpected error during transfer: $e');
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
