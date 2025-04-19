import 'package:freezed_annotation/freezed_annotation.dart';

part 'external_transfer.freezed.dart';
part 'external_transfer.g.dart';

@freezed
class ExternalTransfer with _$ExternalTransfer {
  const factory ExternalTransfer({
    required int id,
    @JsonKey(name: 'from_account_id') required int fromAccountId,
    @JsonKey(name: 'to_bank_code') required String toBankCode,
    @JsonKey(name: 'to_account_number') required String toAccountNumber,
    @JsonKey(name: 'recipient_name') required String recipientName,
    required double amount,
    required String currency,
    required String status,
    required String reference,
    required String description,
    @JsonKey(name: 'transaction_id') required String transactionId,
    @JsonKey(name: 'transaction_fees') required double transactionFees,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _ExternalTransfer;

  factory ExternalTransfer.fromJson(Map<String, dynamic> json) =>
      _$ExternalTransferFromJson(json);
} 