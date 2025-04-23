import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/app_connectivity.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/history/domain/entities/transaction_summary.dart';
import 'package:super_app/features/history/domain/repositories/transaction_repository.dart';

part 'transaction_summary_event.dart';
part 'transaction_summary_state.dart';
part 'transaction_summary_bloc.freezed.dart';

@injectable
class TransactionSummaryBloc extends Bloc<TransactionSummaryEvent, TransactionSummaryState> {
  TransactionSummaryBloc(
    this._transactionRepository,
    this._accountsBloc,
  ) : super(TransactionSummaryState.initial()) {
    on<TransactionSummaryFetched>(_onTransactionSummaryFetched);
    on<TransactionSummaryDateRangeChanged>(_onTransactionSummaryDateRangeChanged);
    on<TransactionSummaryAccountChanged>(_onTransactionSummaryAccountChanged);
  }

  final TransactionRepository _transactionRepository;
  final AccountsBloc _accountsBloc;

  Future<void> _onTransactionSummaryFetched(
    TransactionSummaryFetched event,
    Emitter<TransactionSummaryState> emit,
  ) async {
    log('TransactionSummaryBloc: Fetching transaction summary');

    // If already loading, do nothing
    if (state.status == TransactionSummaryStatus.loading) {
      log('TransactionSummaryBloc: Already loading, ignoring fetch request');
      return;
    }

    // Set loading state
    emit(state.copyWith(status: TransactionSummaryStatus.loading));

    // Check internet connection
    final hasConnectivity = await AppConnectivity.connectivity();
    log('TransactionSummaryBloc: Internet connectivity check: $hasConnectivity');

    if (!hasConnectivity) {
      log('TransactionSummaryBloc: No internet connection');
      emit(
        state.copyWith(
          status: TransactionSummaryStatus.failure,
          errorMessage: 'No internet connection. Please check your network.',
        ),
      );
      return;
    }

    // Get active account
    int accountId = state.accountId;
    if (accountId <= 0) {
      log('TransactionSummaryBloc: No active account, getting from AccountsBloc');
      try {
        final accountsState = _accountsBloc.state;
        if (accountsState.accounts.isNotEmpty) {
          accountId = accountsState.accounts.first.id;
          log('TransactionSummaryBloc: Using account ID: $accountId');
        } else {
          log('TransactionSummaryBloc: No accounts available');
          emit(
            state.copyWith(
              status: TransactionSummaryStatus.failure,
              errorMessage: 'No accounts available. Please add an account first.',
            ),
          );
          return;
        }
      } catch (e) {
        log('TransactionSummaryBloc: Error getting account: $e');
        emit(
          state.copyWith(
            status: TransactionSummaryStatus.failure,
            errorMessage: 'Unable to load accounts. Please try again later.',
          ),
        );
        return;
      }
    }

    try {
      log('TransactionSummaryBloc: Calling repository for account: $accountId');
      final result = await _transactionRepository.getTransactionSummary(
        accountId: accountId,
        startDate: state.startDate,
        endDate: state.endDate,
      );

      result.fold(
        (failure) {
          log('TransactionSummaryBloc: Failed to fetch summary: ${failure.toString()}');
          emit(
            state.copyWith(
              status: TransactionSummaryStatus.failure,
              errorMessage: NetworkExceptions.getRawErrorMessage(failure),
            ),
          );
        },
        (summary) {
          log('TransactionSummaryBloc: Successfully fetched summary');
          emit(
            state.copyWith(
              status: TransactionSummaryStatus.success,
              summary: summary,
              accountId: accountId,
              errorMessage: '',
            ),
          );
        },
      );
    } catch (e) {
      log('TransactionSummaryBloc: Unexpected error: $e');
      emit(
        state.copyWith(
          status: TransactionSummaryStatus.failure,
          errorMessage: 'An unexpected error occurred. Please try again later.',
        ),
      );
    }
  }

  Future<void> _onTransactionSummaryDateRangeChanged(
    TransactionSummaryDateRangeChanged event,
    Emitter<TransactionSummaryState> emit,
  ) async {
    log('TransactionSummaryBloc: Date range changed - start: ${event.startDate}, end: ${event.endDate}');
    
    emit(state.copyWith(
      startDate: event.startDate,
      endDate: event.endDate,
      status: TransactionSummaryStatus.initial,
      summary: null,
    ));
    
    add(const TransactionSummaryFetched());
  }

  Future<void> _onTransactionSummaryAccountChanged(
    TransactionSummaryAccountChanged event,
    Emitter<TransactionSummaryState> emit,
  ) async {
    log('TransactionSummaryBloc: Account changed to ID: ${event.accountId}');
    
    emit(state.copyWith(
      accountId: event.accountId,
      status: TransactionSummaryStatus.initial,
      summary: null,
    ));
    
    add(const TransactionSummaryFetched());
  }
} 