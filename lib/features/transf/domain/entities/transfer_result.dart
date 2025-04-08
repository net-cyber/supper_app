import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

part 'transfer_result.freezed.dart';
part 'transfer_result.g.dart';

/// Converter for AccountNumber value object
class AccountNumberConverter implements JsonConverter<AccountNumber, String> {
  const AccountNumberConverter();

  @override
  AccountNumber fromJson(String json) => AccountNumber(json);

  @override
  String toJson(AccountNumber object) => object.getOrElse('');
}

/// Converter for Amount value object
class AmountConverter implements JsonConverter<Amount, double> {
  const AmountConverter();

  @override
  Amount fromJson(double json) => Amount(json);

  @override
  double toJson(Amount object) => object.getValue();
}

@freezed
class TransferResult with _$TransferResult {
  const factory TransferResult({
    required String transactionId,
    @AccountNumberConverter() required AccountNumber fromAccountNumber,
    @AccountNumberConverter() required AccountNumber toAccountNumber,
    required double amount,
    required String currency,
    required DateTime timestamp,
    required String status,
    String? reference,
    String? description,
  }) = _TransferResult;

  factory TransferResult.fromJson(Map<String, dynamic> json) =>
      _$TransferResultFromJson(json);
}
