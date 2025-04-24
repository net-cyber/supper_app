import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/app_connectivity.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_event.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_state.dart';
import 'package:super_app/features/accounts/domain/repositories/account_repository.dart';

@singleton
class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc(this._accountRepository) : super(AccountsState.initial()) {
    on<FetchAccounts>(_onFetchAccounts);
    on<LoadMoreAccounts>(_onLoadMoreAccounts);
    on<RefreshAccounts>(_onRefreshAccounts);
    on<ResetAccounts>(_onResetAccounts);
    add(const FetchAccounts());
  }

  final AccountRespository _accountRepository;

  Future<void> _onFetchAccounts(
    FetchAccounts event,
    Emitter<AccountsState> emit,
  ) async {
    final connected = await AppConnectivity.connectivity();

    if (!connected) {
      emit(state.copyWith(hasError: true, isLoading: false));
      return;
    }

    emit(state.copyWith(isLoading: true, hasError: false));

    final result = await _accountRepository.getAccounts(
      pageId: 1,
      pageSize: state.pageSize,
    );

    await result.fold(
      (failure) async => emit(state.copyWith(
        isLoading: false,
        hasError: true,
      )),
      (accounts) async {
        final hasReachedMax = accounts.length < state.pageSize;
        
        if (!emit.isDone) {
          emit(state.copyWith(
            accounts: accounts,
            isLoading: false,
            hasError: false,
            currentPage: 1,
            hasReachedMax: hasReachedMax,
          ));
        }
      },
    );
  }

  Future<void> _onLoadMoreAccounts(
    LoadMoreAccounts event,
    Emitter<AccountsState> emit,
  ) async {
    if (state.isLoadingMore || state.hasReachedMax) return;

    final connected = await AppConnectivity.connectivity();

    if (!connected) {
      emit(state.copyWith(hasError: true, isLoadingMore: false));
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.currentPage + 1;

    final result = await _accountRepository.getAccounts(
      pageId: nextPage,
      pageSize: state.pageSize,
    );

    await result.fold(
      (failure) async => emit(state.copyWith(
        isLoadingMore: false,
        hasError: true,
      )),
      (newAccounts) async {
        final hasReachedMax = newAccounts.length < state.pageSize;
        
        if (!emit.isDone) {
          emit(state.copyWith(
            accounts: [...state.accounts, ...newAccounts],
            isLoadingMore: false,
            hasError: false,
            currentPage: nextPage,
            hasReachedMax: hasReachedMax,
          ));
        }
      },
    );
  }

  Future<void> _onRefreshAccounts(
    RefreshAccounts event, 
    Emitter<AccountsState> emit,
  ) async {
    add(const FetchAccounts());
  }
  
  void _onResetAccounts(
    ResetAccounts event,
    Emitter<AccountsState> emit,
  ) {
    emit(AccountsState.initial());
  }
}
