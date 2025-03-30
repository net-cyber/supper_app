// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RegistrationResponse _$RegistrationResponseFromJson(Map<String, dynamic> json) {
  return _RegistrationResponse.fromJson(json);
}

/// @nodoc
mixin _$RegistrationResponse {
  String get username => throw _privateConstructorUsedError;
  String get full_name => throw _privateConstructorUsedError;
  String get international_phone_number => throw _privateConstructorUsedError;
  DateTime get password_changed_at => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;

  /// Serializes this RegistrationResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegistrationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegistrationResponseCopyWith<RegistrationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistrationResponseCopyWith<$Res> {
  factory $RegistrationResponseCopyWith(RegistrationResponse value,
          $Res Function(RegistrationResponse) then) =
      _$RegistrationResponseCopyWithImpl<$Res, RegistrationResponse>;
  @useResult
  $Res call(
      {String username,
      String full_name,
      String international_phone_number,
      DateTime password_changed_at,
      DateTime created_at});
}

/// @nodoc
class _$RegistrationResponseCopyWithImpl<$Res,
        $Val extends RegistrationResponse>
    implements $RegistrationResponseCopyWith<$Res> {
  _$RegistrationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegistrationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? full_name = null,
    Object? international_phone_number = null,
    Object? password_changed_at = null,
    Object? created_at = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      full_name: null == full_name
          ? _value.full_name
          : full_name // ignore: cast_nullable_to_non_nullable
              as String,
      international_phone_number: null == international_phone_number
          ? _value.international_phone_number
          : international_phone_number // ignore: cast_nullable_to_non_nullable
              as String,
      password_changed_at: null == password_changed_at
          ? _value.password_changed_at
          : password_changed_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegistrationResponseImplCopyWith<$Res>
    implements $RegistrationResponseCopyWith<$Res> {
  factory _$$RegistrationResponseImplCopyWith(_$RegistrationResponseImpl value,
          $Res Function(_$RegistrationResponseImpl) then) =
      __$$RegistrationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String username,
      String full_name,
      String international_phone_number,
      DateTime password_changed_at,
      DateTime created_at});
}

/// @nodoc
class __$$RegistrationResponseImplCopyWithImpl<$Res>
    extends _$RegistrationResponseCopyWithImpl<$Res, _$RegistrationResponseImpl>
    implements _$$RegistrationResponseImplCopyWith<$Res> {
  __$$RegistrationResponseImplCopyWithImpl(_$RegistrationResponseImpl _value,
      $Res Function(_$RegistrationResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegistrationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? full_name = null,
    Object? international_phone_number = null,
    Object? password_changed_at = null,
    Object? created_at = null,
  }) {
    return _then(_$RegistrationResponseImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      full_name: null == full_name
          ? _value.full_name
          : full_name // ignore: cast_nullable_to_non_nullable
              as String,
      international_phone_number: null == international_phone_number
          ? _value.international_phone_number
          : international_phone_number // ignore: cast_nullable_to_non_nullable
              as String,
      password_changed_at: null == password_changed_at
          ? _value.password_changed_at
          : password_changed_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegistrationResponseImpl extends _RegistrationResponse {
  const _$RegistrationResponseImpl(
      {required this.username,
      required this.full_name,
      required this.international_phone_number,
      required this.password_changed_at,
      required this.created_at})
      : super._();

  factory _$RegistrationResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegistrationResponseImplFromJson(json);

  @override
  final String username;
  @override
  final String full_name;
  @override
  final String international_phone_number;
  @override
  final DateTime password_changed_at;
  @override
  final DateTime created_at;

  @override
  String toString() {
    return 'RegistrationResponse(username: $username, full_name: $full_name, international_phone_number: $international_phone_number, password_changed_at: $password_changed_at, created_at: $created_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistrationResponseImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.full_name, full_name) ||
                other.full_name == full_name) &&
            (identical(other.international_phone_number,
                    international_phone_number) ||
                other.international_phone_number ==
                    international_phone_number) &&
            (identical(other.password_changed_at, password_changed_at) ||
                other.password_changed_at == password_changed_at) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, username, full_name,
      international_phone_number, password_changed_at, created_at);

  /// Create a copy of RegistrationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegistrationResponseImplCopyWith<_$RegistrationResponseImpl>
      get copyWith =>
          __$$RegistrationResponseImplCopyWithImpl<_$RegistrationResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegistrationResponseImplToJson(
      this,
    );
  }
}

abstract class _RegistrationResponse extends RegistrationResponse {
  const factory _RegistrationResponse(
      {required final String username,
      required final String full_name,
      required final String international_phone_number,
      required final DateTime password_changed_at,
      required final DateTime created_at}) = _$RegistrationResponseImpl;
  const _RegistrationResponse._() : super._();

  factory _RegistrationResponse.fromJson(Map<String, dynamic> json) =
      _$RegistrationResponseImpl.fromJson;

  @override
  String get username;
  @override
  String get full_name;
  @override
  String get international_phone_number;
  @override
  DateTime get password_changed_at;
  @override
  DateTime get created_at;

  /// Create a copy of RegistrationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegistrationResponseImplCopyWith<_$RegistrationResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
