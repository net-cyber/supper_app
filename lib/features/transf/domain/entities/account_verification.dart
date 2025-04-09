import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_verification.freezed.dart';
part 'account_verification.g.dart';

/// Entity that represents an account verification response
@freezed
class AccountVerification with _$AccountVerification {
  /// Creates a new [AccountVerification]
  const factory AccountVerification({
    /// The full name of the account holder
    @JsonKey(name: 'full_name') required String fullName,
  }) = _AccountVerification;

  /// Creates a new [AccountVerification] from JSON
  factory AccountVerification.fromJson(Map<String, dynamic> json) =>
      _$AccountVerificationFromJson(json);
}
