import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_response.freezed.dart';
part 'transaction_response.g.dart';

@freezed
class TransactionResponse with _$TransactionResponse {
  const factory TransactionResponse({
    required TransferDetails transfer,
    required AccountDetails fromAccount,
    required AccountDetails toAccount,
    required EntryDetails fromEntry,
    required EntryDetails toEntry,
  }) = _TransactionResponse;

  const TransactionResponse._();

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);
}

@freezed
class TransferDetails with _$TransferDetails {
  const factory TransferDetails({
    required int id,
    required int from_account_id,
    required int to_account_id,
    required double amount,
    required DateTime created_at,
  }) = _TransferDetails;

  const TransferDetails._();

  factory TransferDetails.fromJson(Map<String, dynamic> json) =>
      _$TransferDetailsFromJson(json);
}

@freezed
class AccountDetails with _$AccountDetails {
  const factory AccountDetails({
    required int id,
    required String owner,
    required double balance,
    required String currency,
    required DateTime created_at,
  }) = _AccountDetails;

  const AccountDetails._();

  factory AccountDetails.fromJson(Map<String, dynamic> json) =>
      _$AccountDetailsFromJson(json);
}

@freezed
class EntryDetails with _$EntryDetails {
  const factory EntryDetails({
    required int id,
    required int account_id,
    required double amount,
    required DateTime created_at,
  }) = _EntryDetails;

  const EntryDetails._();

  factory EntryDetails.fromJson(Map<String, dynamic> json) =>
      _$EntryDetailsFromJson(json);
}
