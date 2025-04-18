// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_verification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AccountVerification _$AccountVerificationFromJson(Map<String, dynamic> json) {
  return _AccountVerification.fromJson(json);
}

/// @nodoc
mixin _$AccountVerification {
  /// The full name of the account holder
  @JsonKey(name: 'full_name')
  String get fullName => throw _privateConstructorUsedError;

  /// Serializes this AccountVerification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccountVerification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountVerificationCopyWith<AccountVerification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountVerificationCopyWith<$Res> {
  factory $AccountVerificationCopyWith(
          AccountVerification value, $Res Function(AccountVerification) then) =
      _$AccountVerificationCopyWithImpl<$Res, AccountVerification>;
  @useResult
  $Res call({@JsonKey(name: 'full_name') String fullName});
}

/// @nodoc
class _$AccountVerificationCopyWithImpl<$Res, $Val extends AccountVerification>
    implements $AccountVerificationCopyWith<$Res> {
  _$AccountVerificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountVerification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
  }) {
    return _then(_value.copyWith(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountVerificationImplCopyWith<$Res>
    implements $AccountVerificationCopyWith<$Res> {
  factory _$$AccountVerificationImplCopyWith(_$AccountVerificationImpl value,
          $Res Function(_$AccountVerificationImpl) then) =
      __$$AccountVerificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'full_name') String fullName});
}

/// @nodoc
class __$$AccountVerificationImplCopyWithImpl<$Res>
    extends _$AccountVerificationCopyWithImpl<$Res, _$AccountVerificationImpl>
    implements _$$AccountVerificationImplCopyWith<$Res> {
  __$$AccountVerificationImplCopyWithImpl(_$AccountVerificationImpl _value,
      $Res Function(_$AccountVerificationImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountVerification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
  }) {
    return _then(_$AccountVerificationImpl(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountVerificationImpl implements _AccountVerification {
  const _$AccountVerificationImpl(
      {@JsonKey(name: 'full_name') required this.fullName});

  factory _$AccountVerificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountVerificationImplFromJson(json);

  /// The full name of the account holder
  @override
  @JsonKey(name: 'full_name')
  final String fullName;

  @override
  String toString() {
    return 'AccountVerification(fullName: $fullName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountVerificationImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fullName);

  /// Create a copy of AccountVerification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountVerificationImplCopyWith<_$AccountVerificationImpl> get copyWith =>
      __$$AccountVerificationImplCopyWithImpl<_$AccountVerificationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountVerificationImplToJson(
      this,
    );
  }
}

abstract class _AccountVerification implements AccountVerification {
  const factory _AccountVerification(
          {@JsonKey(name: 'full_name') required final String fullName}) =
      _$AccountVerificationImpl;

  factory _AccountVerification.fromJson(Map<String, dynamic> json) =
      _$AccountVerificationImpl.fromJson;

  /// The full name of the account holder
  @override
  @JsonKey(name: 'full_name')
  String get fullName;

  /// Create a copy of AccountVerification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountVerificationImplCopyWith<_$AccountVerificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
