// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransferResult _$TransferResultFromJson(Map<String, dynamic> json) {
  return _TransferResult.fromJson(json);
}

/// @nodoc
mixin _$TransferResult {
  String get transactionId => throw _privateConstructorUsedError;
  @AccountNumberConverter()
  AccountNumber get fromAccountNumber => throw _privateConstructorUsedError;
  @AccountNumberConverter()
  AccountNumber get toAccountNumber => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get reference => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this TransferResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransferResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransferResultCopyWith<TransferResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferResultCopyWith<$Res> {
  factory $TransferResultCopyWith(
          TransferResult value, $Res Function(TransferResult) then) =
      _$TransferResultCopyWithImpl<$Res, TransferResult>;
  @useResult
  $Res call(
      {String transactionId,
      @AccountNumberConverter() AccountNumber fromAccountNumber,
      @AccountNumberConverter() AccountNumber toAccountNumber,
      double amount,
      String currency,
      DateTime timestamp,
      String status,
      String? reference,
      String? description});
}

/// @nodoc
class _$TransferResultCopyWithImpl<$Res, $Val extends TransferResult>
    implements $TransferResultCopyWith<$Res> {
  _$TransferResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransferResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? fromAccountNumber = null,
    Object? toAccountNumber = null,
    Object? amount = null,
    Object? currency = null,
    Object? timestamp = null,
    Object? status = null,
    Object? reference = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      fromAccountNumber: null == fromAccountNumber
          ? _value.fromAccountNumber
          : fromAccountNumber // ignore: cast_nullable_to_non_nullable
              as AccountNumber,
      toAccountNumber: null == toAccountNumber
          ? _value.toAccountNumber
          : toAccountNumber // ignore: cast_nullable_to_non_nullable
              as AccountNumber,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransferResultImplCopyWith<$Res>
    implements $TransferResultCopyWith<$Res> {
  factory _$$TransferResultImplCopyWith(_$TransferResultImpl value,
          $Res Function(_$TransferResultImpl) then) =
      __$$TransferResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String transactionId,
      @AccountNumberConverter() AccountNumber fromAccountNumber,
      @AccountNumberConverter() AccountNumber toAccountNumber,
      double amount,
      String currency,
      DateTime timestamp,
      String status,
      String? reference,
      String? description});
}

/// @nodoc
class __$$TransferResultImplCopyWithImpl<$Res>
    extends _$TransferResultCopyWithImpl<$Res, _$TransferResultImpl>
    implements _$$TransferResultImplCopyWith<$Res> {
  __$$TransferResultImplCopyWithImpl(
      _$TransferResultImpl _value, $Res Function(_$TransferResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransferResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? fromAccountNumber = null,
    Object? toAccountNumber = null,
    Object? amount = null,
    Object? currency = null,
    Object? timestamp = null,
    Object? status = null,
    Object? reference = freezed,
    Object? description = freezed,
  }) {
    return _then(_$TransferResultImpl(
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      fromAccountNumber: null == fromAccountNumber
          ? _value.fromAccountNumber
          : fromAccountNumber // ignore: cast_nullable_to_non_nullable
              as AccountNumber,
      toAccountNumber: null == toAccountNumber
          ? _value.toAccountNumber
          : toAccountNumber // ignore: cast_nullable_to_non_nullable
              as AccountNumber,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransferResultImpl implements _TransferResult {
  const _$TransferResultImpl(
      {required this.transactionId,
      @AccountNumberConverter() required this.fromAccountNumber,
      @AccountNumberConverter() required this.toAccountNumber,
      required this.amount,
      required this.currency,
      required this.timestamp,
      required this.status,
      this.reference,
      this.description});

  factory _$TransferResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferResultImplFromJson(json);

  @override
  final String transactionId;
  @override
  @AccountNumberConverter()
  final AccountNumber fromAccountNumber;
  @override
  @AccountNumberConverter()
  final AccountNumber toAccountNumber;
  @override
  final double amount;
  @override
  final String currency;
  @override
  final DateTime timestamp;
  @override
  final String status;
  @override
  final String? reference;
  @override
  final String? description;

  @override
  String toString() {
    return 'TransferResult(transactionId: $transactionId, fromAccountNumber: $fromAccountNumber, toAccountNumber: $toAccountNumber, amount: $amount, currency: $currency, timestamp: $timestamp, status: $status, reference: $reference, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferResultImpl &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.fromAccountNumber, fromAccountNumber) ||
                other.fromAccountNumber == fromAccountNumber) &&
            (identical(other.toAccountNumber, toAccountNumber) ||
                other.toAccountNumber == toAccountNumber) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      transactionId,
      fromAccountNumber,
      toAccountNumber,
      amount,
      currency,
      timestamp,
      status,
      reference,
      description);

  /// Create a copy of TransferResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferResultImplCopyWith<_$TransferResultImpl> get copyWith =>
      __$$TransferResultImplCopyWithImpl<_$TransferResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferResultImplToJson(
      this,
    );
  }
}

abstract class _TransferResult implements TransferResult {
  const factory _TransferResult(
      {required final String transactionId,
      @AccountNumberConverter() required final AccountNumber fromAccountNumber,
      @AccountNumberConverter() required final AccountNumber toAccountNumber,
      required final double amount,
      required final String currency,
      required final DateTime timestamp,
      required final String status,
      final String? reference,
      final String? description}) = _$TransferResultImpl;

  factory _TransferResult.fromJson(Map<String, dynamic> json) =
      _$TransferResultImpl.fromJson;

  @override
  String get transactionId;
  @override
  @AccountNumberConverter()
  AccountNumber get fromAccountNumber;
  @override
  @AccountNumberConverter()
  AccountNumber get toAccountNumber;
  @override
  double get amount;
  @override
  String get currency;
  @override
  DateTime get timestamp;
  @override
  String get status;
  @override
  String? get reference;
  @override
  String? get description;

  /// Create a copy of TransferResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferResultImplCopyWith<_$TransferResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
