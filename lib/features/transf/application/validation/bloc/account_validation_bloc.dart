import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/app_connectivity.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/transf/domain/repositories/account_validation_repository.dart';

part 'account_validation_event.dart';
part 'account_validation_state.dart';
part 'account_validation_bloc.freezed.dart';

@injectable
class AccountValidationBloc
    extends Bloc<AccountValidationEvent, AccountValidationState> {
  AccountValidationBloc(
    this._validationRepository,
    this._accountsBloc,
  ) : super(AccountValidationState.initial()) {
    on<AccountDetailsChanged>(_onAccountDetailsChanged);
    on<ValidateAccountSubmitted>(_onValidateAccountSubmitted);
  }

  final AccountValidationRepository _validationRepository;
  final AccountsBloc _accountsBloc;

  void _onAccountDetailsChanged(
      AccountDetailsChanged event, Emitter<AccountValidationState> emit) {
    emit(
      state.copyWith(
        accountId: event.accountId,
        amount: event.amount,
        validationError: false,
        errorMessage: '',
        isValidated: false,
        isSufficient: false,
        message: '',
      ),
    );
  }

  Future<void> _onValidateAccountSubmitted(ValidateAccountSubmitted event,
      Emitter<AccountValidationState> emit) async {
    if (state.accountId <= 0) {
      emit(
        state.copyWith(
          validationError: true,
          errorMessage: 'Please enter a valid account ID',
        ),
      );
      return;
    }

    if (state.amount <= 0) {
      emit(
        state.copyWith(
          validationError: true,
          errorMessage: 'Please enter a valid amount',
        ),
      );
      return;
    }

    emit(state.copyWith(isValidating: true));

    // Check internet connection
    if (!await AppConnectivity.connectivity()) {
      emit(
        state.copyWith(
          isValidating: false,
          validationError: true,
          errorMessage: 'No internet connection. Please check your network.',
        ),
      );
      return;
    }

    // Get current account from accounts bloc
    final accountsState = _accountsBloc.state;
    if (accountsState.accounts.isEmpty) {
      emit(
        state.copyWith(
          isValidating: false,
          validationError: true,
          errorMessage: 'No accounts available. Please try again later.',
        ),
      );
      return;
    }

    // Get the current account (first one or selected one)
    final currentAccount = accountsState.accounts[0]; // Or use selected account

    // Use the account ID from the account entity
    final currentAccountId = currentAccount.id;

    final result = await _validationRepository.validateAccount(
      state.amount,
      currentAccountId,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isValidating: false,
            validationError: true,
            errorMessage: NetworkExceptions.getErrorMessage(failure),
          ),
        );
      },
      (validation) {
        emit(
          state.copyWith(
            isValidating: false,
            isValidated: true,
            isSufficient: validation.isSufficient,
            message: validation.message,
          ),
        );
      },
    );
  }
}
