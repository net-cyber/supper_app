// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'external_transfer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExternalTransfer _$ExternalTransferFromJson(Map<String, dynamic> json) {
  return _ExternalTransfer.fromJson(json);
}

/// @nodoc
mixin _$ExternalTransfer {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'from_account_id')
  int get fromAccountId => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_bank_code')
  String get toBankCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_account_number')
  String get toAccountNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'recipient_name')
  String get recipientName => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get reference => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'transaction_id')
  String get transactionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'transaction_fees')
  double get transactionFees => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ExternalTransfer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExternalTransfer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExternalTransferCopyWith<ExternalTransfer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExternalTransferCopyWith<$Res> {
  factory $ExternalTransferCopyWith(
          ExternalTransfer value, $Res Function(ExternalTransfer) then) =
      _$ExternalTransferCopyWithImpl<$Res, ExternalTransfer>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'from_account_id') int fromAccountId,
      @JsonKey(name: 'to_bank_code') String toBankCode,
      @JsonKey(name: 'to_account_number') String toAccountNumber,
      @JsonKey(name: 'recipient_name') String recipientName,
      double amount,
      String currency,
      String status,
      String reference,
      String description,
      @JsonKey(name: 'transaction_id') String transactionId,
      @JsonKey(name: 'transaction_fees') double transactionFees,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$ExternalTransferCopyWithImpl<$Res, $Val extends ExternalTransfer>
    implements $ExternalTransferCopyWith<$Res> {
  _$ExternalTransferCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExternalTransfer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromAccountId = null,
    Object? toBankCode = null,
    Object? toAccountNumber = null,
    Object? recipientName = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? reference = null,
    Object? description = null,
    Object? transactionId = null,
    Object? transactionFees = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      fromAccountId: null == fromAccountId
          ? _value.fromAccountId
          : fromAccountId // ignore: cast_nullable_to_non_nullable
              as int,
      toBankCode: null == toBankCode
          ? _value.toBankCode
          : toBankCode // ignore: cast_nullable_to_non_nullable
              as String,
      toAccountNumber: null == toAccountNumber
          ? _value.toAccountNumber
          : toAccountNumber // ignore: cast_nullable_to_non_nullable
              as String,
      recipientName: null == recipientName
          ? _value.recipientName
          : recipientName // ignore: cast_nullable_to_non_nullable
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
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      transactionFees: null == transactionFees
          ? _value.transactionFees
          : transactionFees // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExternalTransferImplCopyWith<$Res>
    implements $ExternalTransferCopyWith<$Res> {
  factory _$$ExternalTransferImplCopyWith(_$ExternalTransferImpl value,
          $Res Function(_$ExternalTransferImpl) then) =
      __$$ExternalTransferImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'from_account_id') int fromAccountId,
      @JsonKey(name: 'to_bank_code') String toBankCode,
      @JsonKey(name: 'to_account_number') String toAccountNumber,
      @JsonKey(name: 'recipient_name') String recipientName,
      double amount,
      String currency,
      String status,
      String reference,
      String description,
      @JsonKey(name: 'transaction_id') String transactionId,
      @JsonKey(name: 'transaction_fees') double transactionFees,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$ExternalTransferImplCopyWithImpl<$Res>
    extends _$ExternalTransferCopyWithImpl<$Res, _$ExternalTransferImpl>
    implements _$$ExternalTransferImplCopyWith<$Res> {
  __$$ExternalTransferImplCopyWithImpl(_$ExternalTransferImpl _value,
      $Res Function(_$ExternalTransferImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExternalTransfer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromAccountId = null,
    Object? toBankCode = null,
    Object? toAccountNumber = null,
    Object? recipientName = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? reference = null,
    Object? description = null,
    Object? transactionId = null,
    Object? transactionFees = null,
    Object? createdAt = null,
  }) {
    return _then(_$ExternalTransferImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      fromAccountId: null == fromAccountId
          ? _value.fromAccountId
          : fromAccountId // ignore: cast_nullable_to_non_nullable
              as int,
      toBankCode: null == toBankCode
          ? _value.toBankCode
          : toBankCode // ignore: cast_nullable_to_non_nullable
              as String,
      toAccountNumber: null == toAccountNumber
          ? _value.toAccountNumber
          : toAccountNumber // ignore: cast_nullable_to_non_nullable
              as String,
      recipientName: null == recipientName
          ? _value.recipientName
          : recipientName // ignore: cast_nullable_to_non_nullable
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
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      transactionFees: null == transactionFees
          ? _value.transactionFees
          : transactionFees // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExternalTransferImpl implements _ExternalTransfer {
  const _$ExternalTransferImpl(
      {required this.id,
      @JsonKey(name: 'from_account_id') required this.fromAccountId,
      @JsonKey(name: 'to_bank_code') required this.toBankCode,
      @JsonKey(name: 'to_account_number') required this.toAccountNumber,
      @JsonKey(name: 'recipient_name') required this.recipientName,
      required this.amount,
      required this.currency,
      required this.status,
      required this.reference,
      required this.description,
      @JsonKey(name: 'transaction_id') required this.transactionId,
      @JsonKey(name: 'transaction_fees') required this.transactionFees,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$ExternalTransferImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExternalTransferImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'from_account_id')
  final int fromAccountId;
  @override
  @JsonKey(name: 'to_bank_code')
  final String toBankCode;
  @override
  @JsonKey(name: 'to_account_number')
  final String toAccountNumber;
  @override
  @JsonKey(name: 'recipient_name')
  final String recipientName;
  @override
  final double amount;
  @override
  final String currency;
  @override
  final String status;
  @override
  final String reference;
  @override
  final String description;
  @override
  @JsonKey(name: 'transaction_id')
  final String transactionId;
  @override
  @JsonKey(name: 'transaction_fees')
  final double transactionFees;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'ExternalTransfer(id: $id, fromAccountId: $fromAccountId, toBankCode: $toBankCode, toAccountNumber: $toAccountNumber, recipientName: $recipientName, amount: $amount, currency: $currency, status: $status, reference: $reference, description: $description, transactionId: $transactionId, transactionFees: $transactionFees, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExternalTransferImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fromAccountId, fromAccountId) ||
                other.fromAccountId == fromAccountId) &&
            (identical(other.toBankCode, toBankCode) ||
                other.toBankCode == toBankCode) &&
            (identical(other.toAccountNumber, toAccountNumber) ||
                other.toAccountNumber == toAccountNumber) &&
            (identical(other.recipientName, recipientName) ||
                other.recipientName == recipientName) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.transactionFees, transactionFees) ||
                other.transactionFees == transactionFees) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      fromAccountId,
      toBankCode,
      toAccountNumber,
      recipientName,
      amount,
      currency,
      status,
      reference,
      description,
      transactionId,
      transactionFees,
      createdAt);

  /// Create a copy of ExternalTransfer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExternalTransferImplCopyWith<_$ExternalTransferImpl> get copyWith =>
      __$$ExternalTransferImplCopyWithImpl<_$ExternalTransferImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExternalTransferImplToJson(
      this,
    );
  }
}

abstract class _ExternalTransfer implements ExternalTransfer {
  const factory _ExternalTransfer(
      {required final int id,
      @JsonKey(name: 'from_account_id') required final int fromAccountId,
      @JsonKey(name: 'to_bank_code') required final String toBankCode,
      @JsonKey(name: 'to_account_number') required final String toAccountNumber,
      @JsonKey(name: 'recipient_name') required final String recipientName,
      required final double amount,
      required final String currency,
      required final String status,
      required final String reference,
      required final String description,
      @JsonKey(name: 'transaction_id') required final String transactionId,
      @JsonKey(name: 'transaction_fees') required final double transactionFees,
      @JsonKey(name: 'created_at')
      required final DateTime createdAt}) = _$ExternalTransferImpl;

  factory _ExternalTransfer.fromJson(Map<String, dynamic> json) =
      _$ExternalTransferImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'from_account_id')
  int get fromAccountId;
  @override
  @JsonKey(name: 'to_bank_code')
  String get toBankCode;
  @override
  @JsonKey(name: 'to_account_number')
  String get toAccountNumber;
  @override
  @JsonKey(name: 'recipient_name')
  String get recipientName;
  @override
  double get amount;
  @override
  String get currency;
  @override
  String get status;
  @override
  String get reference;
  @override
  String get description;
  @override
  @JsonKey(name: 'transaction_id')
  String get transactionId;
  @override
  @JsonKey(name: 'transaction_fees')
  double get transactionFees;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of ExternalTransfer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExternalTransferImplCopyWith<_$ExternalTransferImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
