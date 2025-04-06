// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Registration {
  UserName get userName => throw _privateConstructorUsedError;
  FullName get fullName => throw _privateConstructorUsedError;
  PhoneNumber get phoneNumber => throw _privateConstructorUsedError;
  Password get password => throw _privateConstructorUsedError;
  ConfirmPassword get confirmPassword => throw _privateConstructorUsedError;
  TermsAcceptance get termsAcceptance => throw _privateConstructorUsedError;

  /// Create a copy of Registration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegistrationCopyWith<Registration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistrationCopyWith<$Res> {
  factory $RegistrationCopyWith(
          Registration value, $Res Function(Registration) then) =
      _$RegistrationCopyWithImpl<$Res, Registration>;
  @useResult
  $Res call(
      {UserName userName,
      FullName fullName,
      PhoneNumber phoneNumber,
      Password password,
      ConfirmPassword confirmPassword,
      TermsAcceptance termsAcceptance});
}

/// @nodoc
class _$RegistrationCopyWithImpl<$Res, $Val extends Registration>
    implements $RegistrationCopyWith<$Res> {
  _$RegistrationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Registration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? fullName = null,
    Object? phoneNumber = null,
    Object? password = null,
    Object? confirmPassword = null,
    Object? termsAcceptance = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as UserName,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as FullName,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as PhoneNumber,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as Password,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as ConfirmPassword,
      termsAcceptance: null == termsAcceptance
          ? _value.termsAcceptance
          : termsAcceptance // ignore: cast_nullable_to_non_nullable
              as TermsAcceptance,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegistrationImplCopyWith<$Res>
    implements $RegistrationCopyWith<$Res> {
  factory _$$RegistrationImplCopyWith(
          _$RegistrationImpl value, $Res Function(_$RegistrationImpl) then) =
      __$$RegistrationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserName userName,
      FullName fullName,
      PhoneNumber phoneNumber,
      Password password,
      ConfirmPassword confirmPassword,
      TermsAcceptance termsAcceptance});
}

/// @nodoc
class __$$RegistrationImplCopyWithImpl<$Res>
    extends _$RegistrationCopyWithImpl<$Res, _$RegistrationImpl>
    implements _$$RegistrationImplCopyWith<$Res> {
  __$$RegistrationImplCopyWithImpl(
      _$RegistrationImpl _value, $Res Function(_$RegistrationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Registration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? fullName = null,
    Object? phoneNumber = null,
    Object? password = null,
    Object? confirmPassword = null,
    Object? termsAcceptance = null,
  }) {
    return _then(_$RegistrationImpl(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as UserName,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as FullName,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as PhoneNumber,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as Password,
      confirmPassword: null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as ConfirmPassword,
      termsAcceptance: null == termsAcceptance
          ? _value.termsAcceptance
          : termsAcceptance // ignore: cast_nullable_to_non_nullable
              as TermsAcceptance,
    ));
  }
}

/// @nodoc

class _$RegistrationImpl extends _Registration {
  const _$RegistrationImpl(
      {required this.userName,
      required this.fullName,
      required this.phoneNumber,
      required this.password,
      required this.confirmPassword,
      required this.termsAcceptance})
      : super._();

  @override
  final UserName userName;
  @override
  final FullName fullName;
  @override
  final PhoneNumber phoneNumber;
  @override
  final Password password;
  @override
  final ConfirmPassword confirmPassword;
  @override
  final TermsAcceptance termsAcceptance;

  @override
  String toString() {
    return 'Registration(userName: $userName, fullName: $fullName, phoneNumber: $phoneNumber, password: $password, confirmPassword: $confirmPassword, termsAcceptance: $termsAcceptance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistrationImpl &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword) &&
            (identical(other.termsAcceptance, termsAcceptance) ||
                other.termsAcceptance == termsAcceptance));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userName, fullName, phoneNumber,
      password, confirmPassword, termsAcceptance);

  /// Create a copy of Registration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegistrationImplCopyWith<_$RegistrationImpl> get copyWith =>
      __$$RegistrationImplCopyWithImpl<_$RegistrationImpl>(this, _$identity);
}

abstract class _Registration extends Registration {
  const factory _Registration(
      {required final UserName userName,
      required final FullName fullName,
      required final PhoneNumber phoneNumber,
      required final Password password,
      required final ConfirmPassword confirmPassword,
      required final TermsAcceptance termsAcceptance}) = _$RegistrationImpl;
  const _Registration._() : super._();

  @override
  UserName get userName;
  @override
  FullName get fullName;
  @override
  PhoneNumber get phoneNumber;
  @override
  Password get password;
  @override
  ConfirmPassword get confirmPassword;
  @override
  TermsAcceptance get termsAcceptance;

  /// Create a copy of Registration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegistrationImplCopyWith<_$RegistrationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
