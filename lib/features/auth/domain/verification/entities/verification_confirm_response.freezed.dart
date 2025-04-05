// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verification_confirm_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VerificationConfirmResponse _$VerificationConfirmResponseFromJson(
    Map<String, dynamic> json) {
  return _VerificationConfirmResponse.fromJson(json);
}

/// @nodoc
mixin _$VerificationConfirmResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get phone_number => throw _privateConstructorUsedError;
  bool get phone_verified => throw _privateConstructorUsedError;

  /// Serializes this VerificationConfirmResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VerificationConfirmResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VerificationConfirmResponseCopyWith<VerificationConfirmResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerificationConfirmResponseCopyWith<$Res> {
  factory $VerificationConfirmResponseCopyWith(
          VerificationConfirmResponse value,
          $Res Function(VerificationConfirmResponse) then) =
      _$VerificationConfirmResponseCopyWithImpl<$Res,
          VerificationConfirmResponse>;
  @useResult
  $Res call(
      {bool success, String message, String phone_number, bool phone_verified});
}

/// @nodoc
class _$VerificationConfirmResponseCopyWithImpl<$Res,
        $Val extends VerificationConfirmResponse>
    implements $VerificationConfirmResponseCopyWith<$Res> {
  _$VerificationConfirmResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VerificationConfirmResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? phone_number = null,
    Object? phone_verified = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      phone_number: null == phone_number
          ? _value.phone_number
          : phone_number // ignore: cast_nullable_to_non_nullable
              as String,
      phone_verified: null == phone_verified
          ? _value.phone_verified
          : phone_verified // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerificationConfirmResponseImplCopyWith<$Res>
    implements $VerificationConfirmResponseCopyWith<$Res> {
  factory _$$VerificationConfirmResponseImplCopyWith(
          _$VerificationConfirmResponseImpl value,
          $Res Function(_$VerificationConfirmResponseImpl) then) =
      __$$VerificationConfirmResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success, String message, String phone_number, bool phone_verified});
}

/// @nodoc
class __$$VerificationConfirmResponseImplCopyWithImpl<$Res>
    extends _$VerificationConfirmResponseCopyWithImpl<$Res,
        _$VerificationConfirmResponseImpl>
    implements _$$VerificationConfirmResponseImplCopyWith<$Res> {
  __$$VerificationConfirmResponseImplCopyWithImpl(
      _$VerificationConfirmResponseImpl _value,
      $Res Function(_$VerificationConfirmResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of VerificationConfirmResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? phone_number = null,
    Object? phone_verified = null,
  }) {
    return _then(_$VerificationConfirmResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      phone_number: null == phone_number
          ? _value.phone_number
          : phone_number // ignore: cast_nullable_to_non_nullable
              as String,
      phone_verified: null == phone_verified
          ? _value.phone_verified
          : phone_verified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerificationConfirmResponseImpl extends _VerificationConfirmResponse {
  const _$VerificationConfirmResponseImpl(
      {required this.success,
      required this.message,
      required this.phone_number,
      required this.phone_verified})
      : super._();

  factory _$VerificationConfirmResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$VerificationConfirmResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final String phone_number;
  @override
  final bool phone_verified;

  @override
  String toString() {
    return 'VerificationConfirmResponse(success: $success, message: $message, phone_number: $phone_number, phone_verified: $phone_verified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerificationConfirmResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.phone_number, phone_number) ||
                other.phone_number == phone_number) &&
            (identical(other.phone_verified, phone_verified) ||
                other.phone_verified == phone_verified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, success, message, phone_number, phone_verified);

  /// Create a copy of VerificationConfirmResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VerificationConfirmResponseImplCopyWith<_$VerificationConfirmResponseImpl>
      get copyWith => __$$VerificationConfirmResponseImplCopyWithImpl<
          _$VerificationConfirmResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerificationConfirmResponseImplToJson(
      this,
    );
  }
}

abstract class _VerificationConfirmResponse
    extends VerificationConfirmResponse {
  const factory _VerificationConfirmResponse(
      {required final bool success,
      required final String message,
      required final String phone_number,
      required final bool phone_verified}) = _$VerificationConfirmResponseImpl;
  const _VerificationConfirmResponse._() : super._();

  factory _VerificationConfirmResponse.fromJson(Map<String, dynamic> json) =
      _$VerificationConfirmResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  String get phone_number;
  @override
  bool get phone_verified;

  /// Create a copy of VerificationConfirmResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerificationConfirmResponseImplCopyWith<_$VerificationConfirmResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
