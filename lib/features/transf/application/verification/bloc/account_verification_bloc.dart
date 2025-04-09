import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/app_connectivity.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/repositories/transfer_account_repository.dart';

part 'account_verification_event.dart';
part 'account_verification_state.dart';
part 'account_verification_bloc.freezed.dart';

@injectable
class AccountVerificationBloc
    extends Bloc<AccountVerificationEvent, AccountVerificationState> {
  AccountVerificationBloc(this._accountRepository)
      : super(AccountVerificationState.initial()) {
    on<AccountIdChanged>(_onAccountIdChanged);
    on<VerifyAccountSubmitted>(_onVerifyAccountSubmitted);
  }

  final TransferAccountRepository _accountRepository;

  void _onAccountIdChanged(
      AccountIdChanged event, Emitter<AccountVerificationState> emit) {
    emit(
      state.copyWith(
        accountId: event.accountId,
        verificationError: false,
        errorMessage: '',
        isVerified: false,
        fullName: '',
      ),
    );
  }

  Future<void> _onVerifyAccountSubmitted(VerifyAccountSubmitted event,
      Emitter<AccountVerificationState> emit) async {
    if (state.accountId <= 0) {
      emit(
        state.copyWith(
          verificationError: true,
          errorMessage: 'Please enter a valid account ID',
        ),
      );
      return;
    }

    emit(state.copyWith(isVerifying: true));

    // Check internet connection
    if (!await AppConnectivity.connectivity()) {
      emit(
        state.copyWith(
          isVerifying: false,
          verificationError: true,
          errorMessage: 'No internet connection. Please check your network.',
        ),
      );
      return;
    }

    final result = await _accountRepository.verifyAccount(state.accountId);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isVerifying: false,
            verificationError: true,
            errorMessage: NetworkExceptions.getErrorMessage(failure),
          ),
        );
      },
      (verification) {
        emit(
          state.copyWith(
            isVerifying: false,
            isVerified: true,
            fullName: verification.fullName,
          ),
        );
      },
    );
  }
}
