// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'external_transfer_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExternalTransferRequest _$ExternalTransferRequestFromJson(
    Map<String, dynamic> json) {
  return _ExternalTransferRequest.fromJson(json);
}

/// @nodoc
mixin _$ExternalTransferRequest {
  @JsonKey(name: 'from_account_id')
  int get fromAccountId => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_bank_code')
  String get toBankCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_account_number')
  String get toAccountNumber => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this ExternalTransferRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExternalTransferRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExternalTransferRequestCopyWith<ExternalTransferRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExternalTransferRequestCopyWith<$Res> {
  factory $ExternalTransferRequestCopyWith(ExternalTransferRequest value,
          $Res Function(ExternalTransferRequest) then) =
      _$ExternalTransferRequestCopyWithImpl<$Res, ExternalTransferRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'from_account_id') int fromAccountId,
      @JsonKey(name: 'to_bank_code') String toBankCode,
      @JsonKey(name: 'to_account_number') String toAccountNumber,
      double amount,
      String currency,
      String? description});
}

/// @nodoc
class _$ExternalTransferRequestCopyWithImpl<$Res,
        $Val extends ExternalTransferRequest>
    implements $ExternalTransferRequestCopyWith<$Res> {
  _$ExternalTransferRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExternalTransferRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromAccountId = null,
    Object? toBankCode = null,
    Object? toAccountNumber = null,
    Object? amount = null,
    Object? currency = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
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
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExternalTransferRequestImplCopyWith<$Res>
    implements $ExternalTransferRequestCopyWith<$Res> {
  factory _$$ExternalTransferRequestImplCopyWith(
          _$ExternalTransferRequestImpl value,
          $Res Function(_$ExternalTransferRequestImpl) then) =
      __$$ExternalTransferRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'from_account_id') int fromAccountId,
      @JsonKey(name: 'to_bank_code') String toBankCode,
      @JsonKey(name: 'to_account_number') String toAccountNumber,
      double amount,
      String currency,
      String? description});
}

/// @nodoc
class __$$ExternalTransferRequestImplCopyWithImpl<$Res>
    extends _$ExternalTransferRequestCopyWithImpl<$Res,
        _$ExternalTransferRequestImpl>
    implements _$$ExternalTransferRequestImplCopyWith<$Res> {
  __$$ExternalTransferRequestImplCopyWithImpl(
      _$ExternalTransferRequestImpl _value,
      $Res Function(_$ExternalTransferRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExternalTransferRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromAccountId = null,
    Object? toBankCode = null,
    Object? toAccountNumber = null,
    Object? amount = null,
    Object? currency = null,
    Object? description = freezed,
  }) {
    return _then(_$ExternalTransferRequestImpl(
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
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExternalTransferRequestImpl implements _ExternalTransferRequest {
  const _$ExternalTransferRequestImpl(
      {@JsonKey(name: 'from_account_id') required this.fromAccountId,
      @JsonKey(name: 'to_bank_code') required this.toBankCode,
      @JsonKey(name: 'to_account_number') required this.toAccountNumber,
      required this.amount,
      required this.currency,
      this.description});

  factory _$ExternalTransferRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExternalTransferRequestImplFromJson(json);

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
  final double amount;
  @override
  final String currency;
  @override
  final String? description;

  @override
  String toString() {
    return 'ExternalTransferRequest(fromAccountId: $fromAccountId, toBankCode: $toBankCode, toAccountNumber: $toAccountNumber, amount: $amount, currency: $currency, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExternalTransferRequestImpl &&
            (identical(other.fromAccountId, fromAccountId) ||
                other.fromAccountId == fromAccountId) &&
            (identical(other.toBankCode, toBankCode) ||
                other.toBankCode == toBankCode) &&
            (identical(other.toAccountNumber, toAccountNumber) ||
                other.toAccountNumber == toAccountNumber) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fromAccountId, toBankCode,
      toAccountNumber, amount, currency, description);

  /// Create a copy of ExternalTransferRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExternalTransferRequestImplCopyWith<_$ExternalTransferRequestImpl>
      get copyWith => __$$ExternalTransferRequestImplCopyWithImpl<
          _$ExternalTransferRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExternalTransferRequestImplToJson(
      this,
    );
  }
}

abstract class _ExternalTransferRequest implements ExternalTransferRequest {
  const factory _ExternalTransferRequest(
      {@JsonKey(name: 'from_account_id') required final int fromAccountId,
      @JsonKey(name: 'to_bank_code') required final String toBankCode,
      @JsonKey(name: 'to_account_number') required final String toAccountNumber,
      required final double amount,
      required final String currency,
      final String? description}) = _$ExternalTransferRequestImpl;

  factory _ExternalTransferRequest.fromJson(Map<String, dynamic> json) =
      _$ExternalTransferRequestImpl.fromJson;

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
  double get amount;
  @override
  String get currency;
  @override
  String? get description;

  /// Create a copy of ExternalTransferRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExternalTransferRequestImplCopyWith<_$ExternalTransferRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
