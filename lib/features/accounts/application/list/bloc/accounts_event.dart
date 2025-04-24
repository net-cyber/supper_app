import 'package:freezed_annotation/freezed_annotation.dart';

part 'accounts_event.freezed.dart';

@freezed
class AccountsEvent with _$AccountsEvent {
  const factory AccountsEvent.fetchAccounts() = FetchAccounts;
  const factory AccountsEvent.loadMoreAccounts() = LoadMoreAccounts;
  const factory AccountsEvent.refreshAccounts() = RefreshAccounts;
  const factory AccountsEvent.resetAccounts() = ResetAccounts;
}
