import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/app_connectivity.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/history/domain/entities/transaction.dart';
import 'package:super_app/features/history/domain/repositories/transaction_repository.dart';

part 'transaction_detail_event.dart';
part 'transaction_detail_state.dart';
part 'transaction_detail_bloc.freezed.dart';

@injectable
class TransactionDetailBloc extends Bloc<TransactionDetailEvent, TransactionDetailState> {
  TransactionDetailBloc(
    this._transactionRepository,
    this._accountsBloc,
  ) : super(TransactionDetailState.initial()) {
    on<TransactionDetailFetched>(_onTransactionDetailFetched);
    on<TransactionDetailSetFromCache>(_onTransactionDetailSetFromCache);
  }

  final TransactionRepository _transactionRepository;
  final AccountsBloc _accountsBloc;

  Future<void> _onTransactionDetailFetched(
    TransactionDetailFetched event,
    Emitter<TransactionDetailState> emit,
  ) async {
    emit(state.copyWith(status: TransactionDetailStatus.loading));

    final hasConnectivity = await AppConnectivity.connectivity();

    if (!hasConnectivity) {
      emit(
        state.copyWith(
          status: TransactionDetailStatus.failure,
          errorMessage: 'No internet connection. Please check your network.',
        ),
      );
      return;
    }

    int accountId = event.accountId;
    if (accountId <= 0) {
      try {
        final accountsState = _accountsBloc.state;
        if (accountsState.accounts.isNotEmpty) {
          accountId = accountsState.accounts.first.id;
        } else {
          emit(
            state.copyWith(
              status: TransactionDetailStatus.failure,
              errorMessage: 'No accounts available. Please add an account first.',
            ),
          );
          return;
        }
      } catch (e) {
        emit(
          state.copyWith(
            status: TransactionDetailStatus.failure,
            errorMessage: 'Unable to load account. Please try again later.',
          ),
        );
        return;
      }
    }

    try {
      final result = await _transactionRepository.getTransactionById(
        transactionId: event.transactionId,
        accountId: accountId,
      );

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: TransactionDetailStatus.failure,
              errorMessage: NetworkExceptions.getRawErrorMessage(failure),
            ),
          );
        },
        (transaction) {
          emit(
            state.copyWith(
              status: TransactionDetailStatus.success,
              transaction: transaction,
              errorMessage: '',
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TransactionDetailStatus.failure,
          errorMessage: 'An unexpected error occurred. Please try again later.',
        ),
      );
    }
  }

  void _onTransactionDetailSetFromCache(
    TransactionDetailSetFromCache event,
    Emitter<TransactionDetailState> emit,
  ) {
    emit(
      state.copyWith(
        status: TransactionDetailStatus.success,
        transaction: event.transaction,
        errorMessage: '',
      ),
    );
  }
} 