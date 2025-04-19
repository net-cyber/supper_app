import 'package:freezed_annotation/freezed_annotation.dart';

part 'external_transfer_request.freezed.dart';
part 'external_transfer_request.g.dart';

@freezed
class ExternalTransferRequest with _$ExternalTransferRequest {
  const factory ExternalTransferRequest({
    @JsonKey(name: 'from_account_id') required int fromAccountId,
    @JsonKey(name: 'to_bank_code') required String toBankCode,
    @JsonKey(name: 'to_account_number') required String toAccountNumber,
    required double amount,
    required String currency,
    String? description,
  }) = _ExternalTransferRequest;

  factory ExternalTransferRequest.fromJson(Map<String, dynamic> json) =>
      _$ExternalTransferRequestFromJson(json);
} 