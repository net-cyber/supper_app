// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bank_account_validation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BankAccountValidation _$BankAccountValidationFromJson(
    Map<String, dynamic> json) {
  return _BankAccountValidation.fromJson(json);
}

/// @nodoc
mixin _$BankAccountValidation {
  String get bankCode => throw _privateConstructorUsedError;
  String get accountNumber => throw _privateConstructorUsedError;
  String get accountName => throw _privateConstructorUsedError;
  bool get found => throw _privateConstructorUsedError;
  String get accountType => throw _privateConstructorUsedError;
  String get branchName => throw _privateConstructorUsedError;

  /// Serializes this BankAccountValidation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BankAccountValidation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BankAccountValidationCopyWith<BankAccountValidation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankAccountValidationCopyWith<$Res> {
  factory $BankAccountValidationCopyWith(BankAccountValidation value,
          $Res Function(BankAccountValidation) then) =
      _$BankAccountValidationCopyWithImpl<$Res, BankAccountValidation>;
  @useResult
  $Res call(
      {String bankCode,
      String accountNumber,
      String accountName,
      bool found,
      String accountType,
      String branchName});
}

/// @nodoc
class _$BankAccountValidationCopyWithImpl<$Res,
        $Val extends BankAccountValidation>
    implements $BankAccountValidationCopyWith<$Res> {
  _$BankAccountValidationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BankAccountValidation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankCode = null,
    Object? accountNumber = null,
    Object? accountName = null,
    Object? found = null,
    Object? accountType = null,
    Object? branchName = null,
  }) {
    return _then(_value.copyWith(
      bankCode: null == bankCode
          ? _value.bankCode
          : bankCode // ignore: cast_nullable_to_non_nullable
              as String,
      accountNumber: null == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String,
      accountName: null == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String,
      found: null == found
          ? _value.found
          : found // ignore: cast_nullable_to_non_nullable
              as bool,
      accountType: null == accountType
          ? _value.accountType
          : accountType // ignore: cast_nullable_to_non_nullable
              as String,
      branchName: null == branchName
          ? _value.branchName
          : branchName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BankAccountValidationImplCopyWith<$Res>
    implements $BankAccountValidationCopyWith<$Res> {
  factory _$$BankAccountValidationImplCopyWith(
          _$BankAccountValidationImpl value,
          $Res Function(_$BankAccountValidationImpl) then) =
      __$$BankAccountValidationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String bankCode,
      String accountNumber,
      String accountName,
      bool found,
      String accountType,
      String branchName});
}

/// @nodoc
class __$$BankAccountValidationImplCopyWithImpl<$Res>
    extends _$BankAccountValidationCopyWithImpl<$Res,
        _$BankAccountValidationImpl>
    implements _$$BankAccountValidationImplCopyWith<$Res> {
  __$$BankAccountValidationImplCopyWithImpl(_$BankAccountValidationImpl _value,
      $Res Function(_$BankAccountValidationImpl) _then)
      : super(_value, _then);

  /// Create a copy of BankAccountValidation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankCode = null,
    Object? accountNumber = null,
    Object? accountName = null,
    Object? found = null,
    Object? accountType = null,
    Object? branchName = null,
  }) {
    return _then(_$BankAccountValidationImpl(
      bankCode: null == bankCode
          ? _value.bankCode
          : bankCode // ignore: cast_nullable_to_non_nullable
              as String,
      accountNumber: null == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String,
      accountName: null == accountName
          ? _value.accountName
          : accountName // ignore: cast_nullable_to_non_nullable
              as String,
      found: null == found
          ? _value.found
          : found // ignore: cast_nullable_to_non_nullable
              as bool,
      accountType: null == accountType
          ? _value.accountType
          : accountType // ignore: cast_nullable_to_non_nullable
              as String,
      branchName: null == branchName
          ? _value.branchName
          : branchName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BankAccountValidationImpl implements _BankAccountValidation {
  const _$BankAccountValidationImpl(
      {required this.bankCode,
      required this.accountNumber,
      required this.accountName,
      required this.found,
      this.accountType = '',
      this.branchName = ''});

  factory _$BankAccountValidationImpl.fromJson(Map<String, dynamic> json) =>
      _$$BankAccountValidationImplFromJson(json);

  @override
  final String bankCode;
  @override
  final String accountNumber;
  @override
  final String accountName;
  @override
  final bool found;
  @override
  @JsonKey()
  final String accountType;
  @override
  @JsonKey()
  final String branchName;

  @override
  String toString() {
    return 'BankAccountValidation(bankCode: $bankCode, accountNumber: $accountNumber, accountName: $accountName, found: $found, accountType: $accountType, branchName: $branchName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BankAccountValidationImpl &&
            (identical(other.bankCode, bankCode) ||
                other.bankCode == bankCode) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.accountName, accountName) ||
                other.accountName == accountName) &&
            (identical(other.found, found) || other.found == found) &&
            (identical(other.accountType, accountType) ||
                other.accountType == accountType) &&
            (identical(other.branchName, branchName) ||
                other.branchName == branchName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, bankCode, accountNumber,
      accountName, found, accountType, branchName);

  /// Create a copy of BankAccountValidation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BankAccountValidationImplCopyWith<_$BankAccountValidationImpl>
      get copyWith => __$$BankAccountValidationImplCopyWithImpl<
          _$BankAccountValidationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BankAccountValidationImplToJson(
      this,
    );
  }
}

abstract class _BankAccountValidation implements BankAccountValidation {
  const factory _BankAccountValidation(
      {required final String bankCode,
      required final String accountNumber,
      required final String accountName,
      required final bool found,
      final String accountType,
      final String branchName}) = _$BankAccountValidationImpl;

  factory _BankAccountValidation.fromJson(Map<String, dynamic> json) =
      _$BankAccountValidationImpl.fromJson;

  @override
  String get bankCode;
  @override
  String get accountNumber;
  @override
  String get accountName;
  @override
  bool get found;
  @override
  String get accountType;
  @override
  String get branchName;

  /// Create a copy of BankAccountValidation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BankAccountValidationImplCopyWith<_$BankAccountValidationImpl>
      get copyWith => throw _privateConstructorUsedError;
}
