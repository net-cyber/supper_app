import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_request.freezed.dart';
part 'transaction_request.g.dart';

@freezed
class TransactionRequest with _$TransactionRequest {
  const factory TransactionRequest({
    required int from_account_id,
    required int to_account_id,
    required double amount,
    required String currency,
  }) = _TransactionRequest;

  const TransactionRequest._();

  factory TransactionRequest.fromJson(Map<String, dynamic> json) =>
      _$TransactionRequestFromJson(json);
}
