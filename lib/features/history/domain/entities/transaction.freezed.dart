// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return _Transaction.fromJson(json);
}

/// @nodoc
mixin _$Transaction {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get direction => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get reference => throw _privateConstructorUsedError;
  String? get counterparty_name => throw _privateConstructorUsedError;
  String? get bank_code => throw _privateConstructorUsedError;
  String? get account_number => throw _privateConstructorUsedError;
  double? get transaction_fees => throw _privateConstructorUsedError;
  int? get counterparty_id => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;

  /// Serializes this Transaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
          Transaction value, $Res Function(Transaction) then) =
      _$TransactionCopyWithImpl<$Res, Transaction>;
  @useResult
  $Res call(
      {int id,
      String type,
      String direction,
      double amount,
      String currency,
      String status,
      String? reference,
      String? counterparty_name,
      String? bank_code,
      String? account_number,
      double? transaction_fees,
      int? counterparty_id,
      String? description,
      DateTime created_at});
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res, $Val extends Transaction>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? direction = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? reference = freezed,
    Object? counterparty_name = freezed,
    Object? bank_code = freezed,
    Object? account_number = freezed,
    Object? transaction_fees = freezed,
    Object? counterparty_id = freezed,
    Object? description = freezed,
    Object? created_at = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      counterparty_name: freezed == counterparty_name
          ? _value.counterparty_name
          : counterparty_name // ignore: cast_nullable_to_non_nullable
              as String?,
      bank_code: freezed == bank_code
          ? _value.bank_code
          : bank_code // ignore: cast_nullable_to_non_nullable
              as String?,
      account_number: freezed == account_number
          ? _value.account_number
          : account_number // ignore: cast_nullable_to_non_nullable
              as String?,
      transaction_fees: freezed == transaction_fees
          ? _value.transaction_fees
          : transaction_fees // ignore: cast_nullable_to_non_nullable
              as double?,
      counterparty_id: freezed == counterparty_id
          ? _value.counterparty_id
          : counterparty_id // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionImplCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$TransactionImplCopyWith(
          _$TransactionImpl value, $Res Function(_$TransactionImpl) then) =
      __$$TransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String type,
      String direction,
      double amount,
      String currency,
      String status,
      String? reference,
      String? counterparty_name,
      String? bank_code,
      String? account_number,
      double? transaction_fees,
      int? counterparty_id,
      String? description,
      DateTime created_at});
}

/// @nodoc
class __$$TransactionImplCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$TransactionImpl>
    implements _$$TransactionImplCopyWith<$Res> {
  __$$TransactionImplCopyWithImpl(
      _$TransactionImpl _value, $Res Function(_$TransactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? direction = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? reference = freezed,
    Object? counterparty_name = freezed,
    Object? bank_code = freezed,
    Object? account_number = freezed,
    Object? transaction_fees = freezed,
    Object? counterparty_id = freezed,
    Object? description = freezed,
    Object? created_at = null,
  }) {
    return _then(_$TransactionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      counterparty_name: freezed == counterparty_name
          ? _value.counterparty_name
          : counterparty_name // ignore: cast_nullable_to_non_nullable
              as String?,
      bank_code: freezed == bank_code
          ? _value.bank_code
          : bank_code // ignore: cast_nullable_to_non_nullable
              as String?,
      account_number: freezed == account_number
          ? _value.account_number
          : account_number // ignore: cast_nullable_to_non_nullable
              as String?,
      transaction_fees: freezed == transaction_fees
          ? _value.transaction_fees
          : transaction_fees // ignore: cast_nullable_to_non_nullable
              as double?,
      counterparty_id: freezed == counterparty_id
          ? _value.counterparty_id
          : counterparty_id // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionImpl extends _Transaction {
  const _$TransactionImpl(
      {required this.id,
      required this.type,
      required this.direction,
      required this.amount,
      required this.currency,
      required this.status,
      this.reference,
      this.counterparty_name,
      this.bank_code,
      this.account_number,
      this.transaction_fees,
      this.counterparty_id,
      this.description,
      required this.created_at})
      : super._();

  factory _$TransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionImplFromJson(json);

  @override
  final int id;
  @override
  final String type;
  @override
  final String direction;
  @override
  final double amount;
  @override
  final String currency;
  @override
  final String status;
  @override
  final String? reference;
  @override
  final String? counterparty_name;
  @override
  final String? bank_code;
  @override
  final String? account_number;
  @override
  final double? transaction_fees;
  @override
  final int? counterparty_id;
  @override
  final String? description;
  @override
  final DateTime created_at;

  @override
  String toString() {
    return 'Transaction(id: $id, type: $type, direction: $direction, amount: $amount, currency: $currency, status: $status, reference: $reference, counterparty_name: $counterparty_name, bank_code: $bank_code, account_number: $account_number, transaction_fees: $transaction_fees, counterparty_id: $counterparty_id, description: $description, created_at: $created_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.counterparty_name, counterparty_name) ||
                other.counterparty_name == counterparty_name) &&
            (identical(other.bank_code, bank_code) ||
                other.bank_code == bank_code) &&
            (identical(other.account_number, account_number) ||
                other.account_number == account_number) &&
            (identical(other.transaction_fees, transaction_fees) ||
                other.transaction_fees == transaction_fees) &&
            (identical(other.counterparty_id, counterparty_id) ||
                other.counterparty_id == counterparty_id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      direction,
      amount,
      currency,
      status,
      reference,
      counterparty_name,
      bank_code,
      account_number,
      transaction_fees,
      counterparty_id,
      description,
      created_at);

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      __$$TransactionImplCopyWithImpl<_$TransactionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionImplToJson(
      this,
    );
  }
}

abstract class _Transaction extends Transaction {
  const factory _Transaction(
      {required final int id,
      required final String type,
      required final String direction,
      required final double amount,
      required final String currency,
      required final String status,
      final String? reference,
      final String? counterparty_name,
      final String? bank_code,
      final String? account_number,
      final double? transaction_fees,
      final int? counterparty_id,
      final String? description,
      required final DateTime created_at}) = _$TransactionImpl;
  const _Transaction._() : super._();

  factory _Transaction.fromJson(Map<String, dynamic> json) =
      _$TransactionImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  String get direction;
  @override
  double get amount;
  @override
  String get currency;
  @override
  String get status;
  @override
  String? get reference;
  @override
  String? get counterparty_name;
  @override
  String? get bank_code;
  @override
  String? get account_number;
  @override
  double? get transaction_fees;
  @override
  int? get counterparty_id;
  @override
  String? get description;
  @override
  DateTime get created_at;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
