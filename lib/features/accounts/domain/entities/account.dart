// lib/features/accounts/domain/entities/account.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
class Account with _$Account {
  const factory Account({
    required int id,
    required String owner,
    required double balance,
    required String currency,
    required DateTime created_at,
  }) = _Account;

  const Account._();

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
}