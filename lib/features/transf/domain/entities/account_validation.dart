import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_validation.freezed.dart';
part 'account_validation.g.dart';

/// Entity that represents an account validation response
@freezed
class AccountValidation with _$AccountValidation {
  /// Creates a new [AccountValidation]
  const factory AccountValidation({
    /// The message indicating validation status
    required String message,

    /// Whether the account has sufficient balance
    @JsonKey(name: 'is_sufficient') required bool isSufficient,
  }) = _AccountValidation;

  /// Creates a new [AccountValidation] from JSON
  factory AccountValidation.fromJson(Map<String, dynamic> json) =>
      _$AccountValidationFromJson(json);
}
