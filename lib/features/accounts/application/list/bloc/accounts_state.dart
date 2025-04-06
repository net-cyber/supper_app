import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:super_app/features/accounts/domain/entities/account.dart';

part 'accounts_state.freezed.dart';

@freezed
class AccountsState with _$AccountsState {
  const factory AccountsState({
    required List<Account> accounts,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasError,
    @Default(false) bool hasReachedMax,
    @Default(1) int currentPage,
    @Default(10) int pageSize,
  }) = _AccountsState;

  const AccountsState._();

  factory AccountsState.initial() => const AccountsState(accounts: []);
}
