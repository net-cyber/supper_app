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
          errorMessage: 'Invalid account information',
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

    final etbAccount = accountsState.accounts.firstWhere(
      (account) =>
          account.currency.toLowerCase() == 'etb' ||
          account.currency.toLowerCase() == 'birr',
      orElse: () => accountsState.accounts.first,
    );

    final senderAccountId = etbAccount.id;

    try {
      final result = await _validationRepository.validateAccount(
        state.amount,
        senderAccountId,
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
    } catch (e) {
      emit(
        state.copyWith(
          isValidating: false,
          validationError: true,
          errorMessage: 'An unexpected error occurred. Please try again.',
        ),
      );
    }
  }
}
