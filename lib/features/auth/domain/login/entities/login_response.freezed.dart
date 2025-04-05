// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return _LoginResponse.fromJson(json);
}

/// @nodoc
mixin _$LoginResponse {
  String get session_id => throw _privateConstructorUsedError;
  String get access_token => throw _privateConstructorUsedError;
  DateTime get access_token_expires_at => throw _privateConstructorUsedError;
  String get refresh_token => throw _privateConstructorUsedError;
  DateTime get refresh_token_expires_at => throw _privateConstructorUsedError;
  LoginUser get user => throw _privateConstructorUsedError;

  /// Serializes this LoginResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginResponseCopyWith<LoginResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginResponseCopyWith<$Res> {
  factory $LoginResponseCopyWith(
          LoginResponse value, $Res Function(LoginResponse) then) =
      _$LoginResponseCopyWithImpl<$Res, LoginResponse>;
  @useResult
  $Res call(
      {String session_id,
      String access_token,
      DateTime access_token_expires_at,
      String refresh_token,
      DateTime refresh_token_expires_at,
      LoginUser user});

  $LoginUserCopyWith<$Res> get user;
}

/// @nodoc
class _$LoginResponseCopyWithImpl<$Res, $Val extends LoginResponse>
    implements $LoginResponseCopyWith<$Res> {
  _$LoginResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session_id = null,
    Object? access_token = null,
    Object? access_token_expires_at = null,
    Object? refresh_token = null,
    Object? refresh_token_expires_at = null,
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      session_id: null == session_id
          ? _value.session_id
          : session_id // ignore: cast_nullable_to_non_nullable
              as String,
      access_token: null == access_token
          ? _value.access_token
          : access_token // ignore: cast_nullable_to_non_nullable
              as String,
      access_token_expires_at: null == access_token_expires_at
          ? _value.access_token_expires_at
          : access_token_expires_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      refresh_token: null == refresh_token
          ? _value.refresh_token
          : refresh_token // ignore: cast_nullable_to_non_nullable
              as String,
      refresh_token_expires_at: null == refresh_token_expires_at
          ? _value.refresh_token_expires_at
          : refresh_token_expires_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as LoginUser,
    ) as $Val);
  }

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LoginUserCopyWith<$Res> get user {
    return $LoginUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoginResponseImplCopyWith<$Res>
    implements $LoginResponseCopyWith<$Res> {
  factory _$$LoginResponseImplCopyWith(
          _$LoginResponseImpl value, $Res Function(_$LoginResponseImpl) then) =
      __$$LoginResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String session_id,
      String access_token,
      DateTime access_token_expires_at,
      String refresh_token,
      DateTime refresh_token_expires_at,
      LoginUser user});

  @override
  $LoginUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$LoginResponseImplCopyWithImpl<$Res>
    extends _$LoginResponseCopyWithImpl<$Res, _$LoginResponseImpl>
    implements _$$LoginResponseImplCopyWith<$Res> {
  __$$LoginResponseImplCopyWithImpl(
      _$LoginResponseImpl _value, $Res Function(_$LoginResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session_id = null,
    Object? access_token = null,
    Object? access_token_expires_at = null,
    Object? refresh_token = null,
    Object? refresh_token_expires_at = null,
    Object? user = null,
  }) {
    return _then(_$LoginResponseImpl(
      session_id: null == session_id
          ? _value.session_id
          : session_id // ignore: cast_nullable_to_non_nullable
              as String,
      access_token: null == access_token
          ? _value.access_token
          : access_token // ignore: cast_nullable_to_non_nullable
              as String,
      access_token_expires_at: null == access_token_expires_at
          ? _value.access_token_expires_at
          : access_token_expires_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      refresh_token: null == refresh_token
          ? _value.refresh_token
          : refresh_token // ignore: cast_nullable_to_non_nullable
              as String,
      refresh_token_expires_at: null == refresh_token_expires_at
          ? _value.refresh_token_expires_at
          : refresh_token_expires_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as LoginUser,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginResponseImpl extends _LoginResponse {
  const _$LoginResponseImpl(
      {required this.session_id,
      required this.access_token,
      required this.access_token_expires_at,
      required this.refresh_token,
      required this.refresh_token_expires_at,
      required this.user})
      : super._();

  factory _$LoginResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginResponseImplFromJson(json);

  @override
  final String session_id;
  @override
  final String access_token;
  @override
  final DateTime access_token_expires_at;
  @override
  final String refresh_token;
  @override
  final DateTime refresh_token_expires_at;
  @override
  final LoginUser user;

  @override
  String toString() {
    return 'LoginResponse(session_id: $session_id, access_token: $access_token, access_token_expires_at: $access_token_expires_at, refresh_token: $refresh_token, refresh_token_expires_at: $refresh_token_expires_at, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginResponseImpl &&
            (identical(other.session_id, session_id) ||
                other.session_id == session_id) &&
            (identical(other.access_token, access_token) ||
                other.access_token == access_token) &&
            (identical(
                    other.access_token_expires_at, access_token_expires_at) ||
                other.access_token_expires_at == access_token_expires_at) &&
            (identical(other.refresh_token, refresh_token) ||
                other.refresh_token == refresh_token) &&
            (identical(
                    other.refresh_token_expires_at, refresh_token_expires_at) ||
                other.refresh_token_expires_at == refresh_token_expires_at) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, session_id, access_token,
      access_token_expires_at, refresh_token, refresh_token_expires_at, user);

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginResponseImplCopyWith<_$LoginResponseImpl> get copyWith =>
      __$$LoginResponseImplCopyWithImpl<_$LoginResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginResponseImplToJson(
      this,
    );
  }
}

abstract class _LoginResponse extends LoginResponse {
  const factory _LoginResponse(
      {required final String session_id,
      required final String access_token,
      required final DateTime access_token_expires_at,
      required final String refresh_token,
      required final DateTime refresh_token_expires_at,
      required final LoginUser user}) = _$LoginResponseImpl;
  const _LoginResponse._() : super._();

  factory _LoginResponse.fromJson(Map<String, dynamic> json) =
      _$LoginResponseImpl.fromJson;

  @override
  String get session_id;
  @override
  String get access_token;
  @override
  DateTime get access_token_expires_at;
  @override
  String get refresh_token;
  @override
  DateTime get refresh_token_expires_at;
  @override
  LoginUser get user;

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginResponseImplCopyWith<_$LoginResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoginUser _$LoginUserFromJson(Map<String, dynamic> json) {
  return _LoginUser.fromJson(json);
}

/// @nodoc
mixin _$LoginUser {
  String get username => throw _privateConstructorUsedError;
  String get full_name => throw _privateConstructorUsedError;
  String get international_phone_number => throw _privateConstructorUsedError;
  bool get phone_verified => throw _privateConstructorUsedError;
  DateTime get password_changed_at => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;

  /// Serializes this LoginUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginUserCopyWith<LoginUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginUserCopyWith<$Res> {
  factory $LoginUserCopyWith(LoginUser value, $Res Function(LoginUser) then) =
      _$LoginUserCopyWithImpl<$Res, LoginUser>;
  @useResult
  $Res call(
      {String username,
      String full_name,
      String international_phone_number,
      bool phone_verified,
      DateTime password_changed_at,
      DateTime created_at});
}

/// @nodoc
class _$LoginUserCopyWithImpl<$Res, $Val extends LoginUser>
    implements $LoginUserCopyWith<$Res> {
  _$LoginUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? full_name = null,
    Object? international_phone_number = null,
    Object? phone_verified = null,
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
      phone_verified: null == phone_verified
          ? _value.phone_verified
          : phone_verified // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$LoginUserImplCopyWith<$Res>
    implements $LoginUserCopyWith<$Res> {
  factory _$$LoginUserImplCopyWith(
          _$LoginUserImpl value, $Res Function(_$LoginUserImpl) then) =
      __$$LoginUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String username,
      String full_name,
      String international_phone_number,
      bool phone_verified,
      DateTime password_changed_at,
      DateTime created_at});
}

/// @nodoc
class __$$LoginUserImplCopyWithImpl<$Res>
    extends _$LoginUserCopyWithImpl<$Res, _$LoginUserImpl>
    implements _$$LoginUserImplCopyWith<$Res> {
  __$$LoginUserImplCopyWithImpl(
      _$LoginUserImpl _value, $Res Function(_$LoginUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? full_name = null,
    Object? international_phone_number = null,
    Object? phone_verified = null,
    Object? password_changed_at = null,
    Object? created_at = null,
  }) {
    return _then(_$LoginUserImpl(
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
      phone_verified: null == phone_verified
          ? _value.phone_verified
          : phone_verified // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$LoginUserImpl extends _LoginUser {
  const _$LoginUserImpl(
      {required this.username,
      required this.full_name,
      required this.international_phone_number,
      required this.phone_verified,
      required this.password_changed_at,
      required this.created_at})
      : super._();

  factory _$LoginUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginUserImplFromJson(json);

  @override
  final String username;
  @override
  final String full_name;
  @override
  final String international_phone_number;
  @override
  final bool phone_verified;
  @override
  final DateTime password_changed_at;
  @override
  final DateTime created_at;

  @override
  String toString() {
    return 'LoginUser(username: $username, full_name: $full_name, international_phone_number: $international_phone_number, phone_verified: $phone_verified, password_changed_at: $password_changed_at, created_at: $created_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginUserImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.full_name, full_name) ||
                other.full_name == full_name) &&
            (identical(other.international_phone_number,
                    international_phone_number) ||
                other.international_phone_number ==
                    international_phone_number) &&
            (identical(other.phone_verified, phone_verified) ||
                other.phone_verified == phone_verified) &&
            (identical(other.password_changed_at, password_changed_at) ||
                other.password_changed_at == password_changed_at) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      username,
      full_name,
      international_phone_number,
      phone_verified,
      password_changed_at,
      created_at);

  /// Create a copy of LoginUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginUserImplCopyWith<_$LoginUserImpl> get copyWith =>
      __$$LoginUserImplCopyWithImpl<_$LoginUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginUserImplToJson(
      this,
    );
  }
}

abstract class _LoginUser extends LoginUser {
  const factory _LoginUser(
      {required final String username,
      required final String full_name,
      required final String international_phone_number,
      required final bool phone_verified,
      required final DateTime password_changed_at,
      required final DateTime created_at}) = _$LoginUserImpl;
  const _LoginUser._() : super._();

  factory _LoginUser.fromJson(Map<String, dynamic> json) =
      _$LoginUserImpl.fromJson;

  @override
  String get username;
  @override
  String get full_name;
  @override
  String get international_phone_number;
  @override
  bool get phone_verified;
  @override
  DateTime get password_changed_at;
  @override
  DateTime get created_at;

  /// Create a copy of LoginUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginUserImplCopyWith<_$LoginUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
