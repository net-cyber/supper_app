import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfer_response.freezed.dart';
part 'transfer_response.g.dart';

/// Transfer response entity
@freezed
class TransferResponse with _$TransferResponse {
  /// Factory constructor for TransferResponse
  const factory TransferResponse({
    /// Transfer ID
    @JsonKey(name: 'transfer_id') required String transferId,

    /// Status of the transfer
    required String status,

    /// Transaction reference number
    @JsonKey(name: 'transaction_ref') required String transactionRef,

    /// Date and time of the transfer
    @JsonKey(name: 'timestamp') required String timestamp,

    /// Amount transferred
    required double amount,

    /// Source account ID
    @JsonKey(name: 'from_account_id') required String fromAccountId,

    /// Destination account ID
    @JsonKey(name: 'to_account_id') required String toAccountId,

    /// Optional message
    String? message,
  }) = _TransferResponse;

  /// Creates a TransferResponse from JSON
  factory TransferResponse.fromJson(Map<String, dynamic> json) =>
      _$TransferResponseFromJson(json);
}

/// Entity representing transfer details
@freezed
class Transfer with _$Transfer {
  /// Creates a new [Transfer]
  const factory Transfer({
    required int id,
    @JsonKey(name: 'from_account_id') required int fromAccountId,
    @JsonKey(name: 'to_account_id') required int toAccountId,
    required double amount,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Transfer;

  /// Creates a new [Transfer] from JSON
  factory Transfer.fromJson(Map<String, dynamic> json) =>
      _$TransferFromJson(json);
}

/// Entity representing account details
@freezed
class Account with _$Account {
  /// Creates a new [Account]
  const factory Account({
    required int id,
    required String owner,
    required double balance,
    required String currency,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Account;

  /// Creates a new [Account] from JSON
  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}

/// Entity representing entry details
@freezed
class Entry with _$Entry {
  /// Creates a new [Entry]
  const factory Entry({
    required int id,
    @JsonKey(name: 'account_id') required int accountId,
    required double amount,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _Entry;

  /// Creates a new [Entry] from JSON
  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);
}
