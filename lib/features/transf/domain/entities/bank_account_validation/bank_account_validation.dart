import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_account_validation.freezed.dart';
part 'bank_account_validation.g.dart';

@freezed
class BankAccountValidation with _$BankAccountValidation {
  const factory BankAccountValidation({
    required String bankCode,
    required String accountNumber,
    required String accountName,
    required bool found,
    @Default('') String accountType,
    @Default('') String branchName,
  }) = _BankAccountValidation;

  factory BankAccountValidation.fromJson(Map<String, dynamic> json) =>
      _$BankAccountValidationFromJson(json);
} 