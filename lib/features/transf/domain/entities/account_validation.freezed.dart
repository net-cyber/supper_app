// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_validation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AccountValidation _$AccountValidationFromJson(Map<String, dynamic> json) {
  return _AccountValidation.fromJson(json);
}

/// @nodoc
mixin _$AccountValidation {
  /// The message indicating validation status
  String get message => throw _privateConstructorUsedError;

  /// Whether the account has sufficient balance
  @JsonKey(name: 'is_sufficient')
  bool get isSufficient => throw _privateConstructorUsedError;

  /// Serializes this AccountValidation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccountValidation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountValidationCopyWith<AccountValidation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountValidationCopyWith<$Res> {
  factory $AccountValidationCopyWith(
          AccountValidation value, $Res Function(AccountValidation) then) =
      _$AccountValidationCopyWithImpl<$Res, AccountValidation>;
  @useResult
  $Res call(
      {String message, @JsonKey(name: 'is_sufficient') bool isSufficient});
}

/// @nodoc
class _$AccountValidationCopyWithImpl<$Res, $Val extends AccountValidation>
    implements $AccountValidationCopyWith<$Res> {
  _$AccountValidationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountValidation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? isSufficient = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      isSufficient: null == isSufficient
          ? _value.isSufficient
          : isSufficient // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountValidationImplCopyWith<$Res>
    implements $AccountValidationCopyWith<$Res> {
  factory _$$AccountValidationImplCopyWith(_$AccountValidationImpl value,
          $Res Function(_$AccountValidationImpl) then) =
      __$$AccountValidationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message, @JsonKey(name: 'is_sufficient') bool isSufficient});
}

/// @nodoc
class __$$AccountValidationImplCopyWithImpl<$Res>
    extends _$AccountValidationCopyWithImpl<$Res, _$AccountValidationImpl>
    implements _$$AccountValidationImplCopyWith<$Res> {
  __$$AccountValidationImplCopyWithImpl(_$AccountValidationImpl _value,
      $Res Function(_$AccountValidationImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountValidation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? isSufficient = null,
  }) {
    return _then(_$AccountValidationImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      isSufficient: null == isSufficient
          ? _value.isSufficient
          : isSufficient // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountValidationImpl implements _AccountValidation {
  const _$AccountValidationImpl(
      {required this.message,
      @JsonKey(name: 'is_sufficient') required this.isSufficient});

  factory _$AccountValidationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountValidationImplFromJson(json);

  /// The message indicating validation status
  @override
  final String message;

  /// Whether the account has sufficient balance
  @override
  @JsonKey(name: 'is_sufficient')
  final bool isSufficient;

  @override
  String toString() {
    return 'AccountValidation(message: $message, isSufficient: $isSufficient)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountValidationImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isSufficient, isSufficient) ||
                other.isSufficient == isSufficient));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, isSufficient);

  /// Create a copy of AccountValidation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountValidationImplCopyWith<_$AccountValidationImpl> get copyWith =>
      __$$AccountValidationImplCopyWithImpl<_$AccountValidationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountValidationImplToJson(
      this,
    );
  }
}

abstract class _AccountValidation implements AccountValidation {
  const factory _AccountValidation(
          {required final String message,
          @JsonKey(name: 'is_sufficient') required final bool isSufficient}) =
      _$AccountValidationImpl;

  factory _AccountValidation.fromJson(Map<String, dynamic> json) =
      _$AccountValidationImpl.fromJson;

  /// The message indicating validation status
  @override
  String get message;

  /// Whether the account has sufficient balance
  @override
  @JsonKey(name: 'is_sufficient')
  bool get isSufficient;

  /// Create a copy of AccountValidation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountValidationImplCopyWith<_$AccountValidationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
