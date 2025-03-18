// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SignupEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function(String confirmPassword) confirmPasswordChanged,
    required TResult Function(String fullName) fullNameChanged,
    required TResult Function(String country) countryChanged,
    required TResult Function() toggleShowPassword,
    required TResult Function() toggleShowConfirmPassword,
    required TResult Function(bool accepted) termsAcceptedChanged,
    required TResult Function() signupSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function(String confirmPassword)? confirmPasswordChanged,
    TResult? Function(String fullName)? fullNameChanged,
    TResult? Function(String country)? countryChanged,
    TResult? Function()? toggleShowPassword,
    TResult? Function()? toggleShowConfirmPassword,
    TResult? Function(bool accepted)? termsAcceptedChanged,
    TResult? Function()? signupSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function(String confirmPassword)? confirmPasswordChanged,
    TResult Function(String fullName)? fullNameChanged,
    TResult Function(String country)? countryChanged,
    TResult Function()? toggleShowPassword,
    TResult Function()? toggleShowConfirmPassword,
    TResult Function(bool accepted)? termsAcceptedChanged,
    TResult Function()? signupSubmitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(FullNameChanged value) fullNameChanged,
    required TResult Function(CountryChanged value) countryChanged,
    required TResult Function(ToggleShowPassword value) toggleShowPassword,
    required TResult Function(ToggleShowConfirmPassword value)
        toggleShowConfirmPassword,
    required TResult Function(TermsAcceptedChanged value) termsAcceptedChanged,
    required TResult Function(SignupSubmitted value) signupSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(FullNameChanged value)? fullNameChanged,
    TResult? Function(CountryChanged value)? countryChanged,
    TResult? Function(ToggleShowPassword value)? toggleShowPassword,
    TResult? Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult? Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult? Function(SignupSubmitted value)? signupSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(FullNameChanged value)? fullNameChanged,
    TResult Function(CountryChanged value)? countryChanged,
    TResult Function(ToggleShowPassword value)? toggleShowPassword,
    TResult Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult Function(SignupSubmitted value)? signupSubmitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupEventCopyWith<$Res> {
  factory $SignupEventCopyWith(
          SignupEvent value, $Res Function(SignupEvent) then) =
      _$SignupEventCopyWithImpl<$Res, SignupEvent>;
}

/// @nodoc
class _$SignupEventCopyWithImpl<$Res, $Val extends SignupEvent>
    implements $SignupEventCopyWith<$Res> {
  _$SignupEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$EmailChangedImplCopyWith<$Res> {
  factory _$$EmailChangedImplCopyWith(
          _$EmailChangedImpl value, $Res Function(_$EmailChangedImpl) then) =
      __$$EmailChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$EmailChangedImplCopyWithImpl<$Res>
    extends _$SignupEventCopyWithImpl<$Res, _$EmailChangedImpl>
    implements _$$EmailChangedImplCopyWith<$Res> {
  __$$EmailChangedImplCopyWithImpl(
      _$EmailChangedImpl _value, $Res Function(_$EmailChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$EmailChangedImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EmailChangedImpl implements EmailChanged {
  const _$EmailChangedImpl(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'SignupEvent.emailChanged(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailChangedImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailChangedImplCopyWith<_$EmailChangedImpl> get copyWith =>
      __$$EmailChangedImplCopyWithImpl<_$EmailChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function(String confirmPassword) confirmPasswordChanged,
    required TResult Function(String fullName) fullNameChanged,
    required TResult Function(String country) countryChanged,
    required TResult Function() toggleShowPassword,
    required TResult Function() toggleShowConfirmPassword,
    required TResult Function(bool accepted) termsAcceptedChanged,
    required TResult Function() signupSubmitted,
  }) {
    return emailChanged(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function(String confirmPassword)? confirmPasswordChanged,
    TResult? Function(String fullName)? fullNameChanged,
    TResult? Function(String country)? countryChanged,
    TResult? Function()? toggleShowPassword,
    TResult? Function()? toggleShowConfirmPassword,
    TResult? Function(bool accepted)? termsAcceptedChanged,
    TResult? Function()? signupSubmitted,
  }) {
    return emailChanged?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function(String confirmPassword)? confirmPasswordChanged,
    TResult Function(String fullName)? fullNameChanged,
    TResult Function(String country)? countryChanged,
    TResult Function()? toggleShowPassword,
    TResult Function()? toggleShowConfirmPassword,
    TResult Function(bool accepted)? termsAcceptedChanged,
    TResult Function()? signupSubmitted,
    required TResult orElse(),
  }) {
    if (emailChanged != null) {
      return emailChanged(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(FullNameChanged value) fullNameChanged,
    required TResult Function(CountryChanged value) countryChanged,
    required TResult Function(ToggleShowPassword value) toggleShowPassword,
    required TResult Function(ToggleShowConfirmPassword value)
        toggleShowConfirmPassword,
    required TResult Function(TermsAcceptedChanged value) termsAcceptedChanged,
    required TResult Function(SignupSubmitted value) signupSubmitted,
  }) {
    return emailChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(FullNameChanged value)? fullNameChanged,
    TResult? Function(CountryChanged value)? countryChanged,
    TResult? Function(ToggleShowPassword value)? toggleShowPassword,
    TResult? Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult? Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult? Function(SignupSubmitted value)? signupSubmitted,
  }) {
    return emailChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(FullNameChanged value)? fullNameChanged,
    TResult Function(CountryChanged value)? countryChanged,
    TResult Function(ToggleShowPassword value)? toggleShowPassword,
    TResult Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult Function(SignupSubmitted value)? signupSubmitted,
    required TResult orElse(),
  }) {
    if (emailChanged != null) {
      return emailChanged(this);
    }
    return orElse();
  }
}

abstract class EmailChanged implements SignupEvent {
  const factory EmailChanged(final String email) = _$EmailChangedImpl;

  String get email;

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailChangedImplCopyWith<_$EmailChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PasswordChangedImplCopyWith<$Res> {
  factory _$$PasswordChangedImplCopyWith(_$PasswordChangedImpl value,
          $Res Function(_$PasswordChangedImpl) then) =
      __$$PasswordChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String password});
}

/// @nodoc
class __$$PasswordChangedImplCopyWithImpl<$Res>
    extends _$SignupEventCopyWithImpl<$Res, _$PasswordChangedImpl>
    implements _$$PasswordChangedImplCopyWith<$Res> {
  __$$PasswordChangedImplCopyWithImpl(
      _$PasswordChangedImpl _value, $Res Function(_$PasswordChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? password = null,
  }) {
    return _then(_$PasswordChangedImpl(
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PasswordChangedImpl implements PasswordChanged {
  const _$PasswordChangedImpl(this.password);

  @override
  final String password;

  @override
  String toString() {
    return 'SignupEvent.passwordChanged(password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordChangedImpl &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, password);

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordChangedImplCopyWith<_$PasswordChangedImpl> get copyWith =>
      __$$PasswordChangedImplCopyWithImpl<_$PasswordChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function(String confirmPassword) confirmPasswordChanged,
    required TResult Function(String fullName) fullNameChanged,
    required TResult Function(String country) countryChanged,
    required TResult Function() toggleShowPassword,
    required TResult Function() toggleShowConfirmPassword,
    required TResult Function(bool accepted) termsAcceptedChanged,
    required TResult Function() signupSubmitted,
  }) {
    return passwordChanged(password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function(String confirmPassword)? confirmPasswordChanged,
    TResult? Function(String fullName)? fullNameChanged,
    TResult? Function(String country)? countryChanged,
    TResult? Function()? toggleShowPassword,
    TResult? Function()? toggleShowConfirmPassword,
    TResult? Function(bool accepted)? termsAcceptedChanged,
    TResult? Function()? signupSubmitted,
  }) {
    return passwordChanged?.call(password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function(String confirmPassword)? confirmPasswordChanged,
    TResult Function(String fullName)? fullNameChanged,
    TResult Function(String country)? countryChanged,
    TResult Function()? toggleShowPassword,
    TResult Function()? toggleShowConfirmPassword,
    TResult Function(bool accepted)? termsAcceptedChanged,
    TResult Function()? signupSubmitted,
    required TResult orElse(),
  }) {
    if (passwordChanged != null) {
      return passwordChanged(password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(FullNameChanged value) fullNameChanged,
    required TResult Function(CountryChanged value) countryChanged,
    required TResult Function(ToggleShowPassword value) toggleShowPassword,
    required TResult Function(ToggleShowConfirmPassword value)
        toggleShowConfirmPassword,
    required TResult Function(TermsAcceptedChanged value) termsAcceptedChanged,
    required TResult Function(SignupSubmitted value) signupSubmitted,
  }) {
    return passwordChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(FullNameChanged value)? fullNameChanged,
    TResult? Function(CountryChanged value)? countryChanged,
    TResult? Function(ToggleShowPassword value)? toggleShowPassword,
    TResult? Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult? Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult? Function(SignupSubmitted value)? signupSubmitted,
  }) {
    return passwordChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(FullNameChanged value)? fullNameChanged,
    TResult Function(CountryChanged value)? countryChanged,
    TResult Function(ToggleShowPassword value)? toggleShowPassword,
    TResult Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult Function(SignupSubmitted value)? signupSubmitted,
    required TResult orElse(),
  }) {
    if (passwordChanged != null) {
      return passwordChanged(this);
    }
    return orElse();
  }
}

abstract class PasswordChanged implements SignupEvent {
  const factory PasswordChanged(final String password) = _$PasswordChangedImpl;

  String get password;

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PasswordChangedImplCopyWith<_$PasswordChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmPasswordChangedImplCopyWith<$Res> {
  factory _$$ConfirmPasswordChangedImplCopyWith(
          _$ConfirmPasswordChangedImpl value,
          $Res Function(_$ConfirmPasswordChangedImpl) then) =
      __$$ConfirmPasswordChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String confirmPassword});
}

/// @nodoc
class __$$ConfirmPasswordChangedImplCopyWithImpl<$Res>
    extends _$SignupEventCopyWithImpl<$Res, _$ConfirmPasswordChangedImpl>
    implements _$$ConfirmPasswordChangedImplCopyWith<$Res> {
  __$$ConfirmPasswordChangedImplCopyWithImpl(
      _$ConfirmPasswordChangedImpl _value,
      $Res Function(_$ConfirmPasswordChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? confirmPassword = null,
  }) {
    return _then(_$ConfirmPasswordChangedImpl(
      null == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ConfirmPasswordChangedImpl implements ConfirmPasswordChanged {
  const _$ConfirmPasswordChangedImpl(this.confirmPassword);

  @override
  final String confirmPassword;

  @override
  String toString() {
    return 'SignupEvent.confirmPasswordChanged(confirmPassword: $confirmPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmPasswordChangedImpl &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword));
  }

  @override
  int get hashCode => Object.hash(runtimeType, confirmPassword);

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmPasswordChangedImplCopyWith<_$ConfirmPasswordChangedImpl>
      get copyWith => __$$ConfirmPasswordChangedImplCopyWithImpl<
          _$ConfirmPasswordChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function(String confirmPassword) confirmPasswordChanged,
    required TResult Function(String fullName) fullNameChanged,
    required TResult Function(String country) countryChanged,
    required TResult Function() toggleShowPassword,
    required TResult Function() toggleShowConfirmPassword,
    required TResult Function(bool accepted) termsAcceptedChanged,
    required TResult Function() signupSubmitted,
  }) {
    return confirmPasswordChanged(confirmPassword);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function(String confirmPassword)? confirmPasswordChanged,
    TResult? Function(String fullName)? fullNameChanged,
    TResult? Function(String country)? countryChanged,
    TResult? Function()? toggleShowPassword,
    TResult? Function()? toggleShowConfirmPassword,
    TResult? Function(bool accepted)? termsAcceptedChanged,
    TResult? Function()? signupSubmitted,
  }) {
    return confirmPasswordChanged?.call(confirmPassword);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function(String confirmPassword)? confirmPasswordChanged,
    TResult Function(String fullName)? fullNameChanged,
    TResult Function(String country)? countryChanged,
    TResult Function()? toggleShowPassword,
    TResult Function()? toggleShowConfirmPassword,
    TResult Function(bool accepted)? termsAcceptedChanged,
    TResult Function()? signupSubmitted,
    required TResult orElse(),
  }) {
    if (confirmPasswordChanged != null) {
      return confirmPasswordChanged(confirmPassword);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(FullNameChanged value) fullNameChanged,
    required TResult Function(CountryChanged value) countryChanged,
    required TResult Function(ToggleShowPassword value) toggleShowPassword,
    required TResult Function(ToggleShowConfirmPassword value)
        toggleShowConfirmPassword,
    required TResult Function(TermsAcceptedChanged value) termsAcceptedChanged,
    required TResult Function(SignupSubmitted value) signupSubmitted,
  }) {
    return confirmPasswordChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(FullNameChanged value)? fullNameChanged,
    TResult? Function(CountryChanged value)? countryChanged,
    TResult? Function(ToggleShowPassword value)? toggleShowPassword,
    TResult? Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult? Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult? Function(SignupSubmitted value)? signupSubmitted,
  }) {
    return confirmPasswordChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(FullNameChanged value)? fullNameChanged,
    TResult Function(CountryChanged value)? countryChanged,
    TResult Function(ToggleShowPassword value)? toggleShowPassword,
    TResult Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult Function(SignupSubmitted value)? signupSubmitted,
    required TResult orElse(),
  }) {
    if (confirmPasswordChanged != null) {
      return confirmPasswordChanged(this);
    }
    return orElse();
  }
}

abstract class ConfirmPasswordChanged implements SignupEvent {
  const factory ConfirmPasswordChanged(final String confirmPassword) =
      _$ConfirmPasswordChangedImpl;

  String get confirmPassword;

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmPasswordChangedImplCopyWith<_$ConfirmPasswordChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FullNameChangedImplCopyWith<$Res> {
  factory _$$FullNameChangedImplCopyWith(_$FullNameChangedImpl value,
          $Res Function(_$FullNameChangedImpl) then) =
      __$$FullNameChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String fullName});
}

/// @nodoc
class __$$FullNameChangedImplCopyWithImpl<$Res>
    extends _$SignupEventCopyWithImpl<$Res, _$FullNameChangedImpl>
    implements _$$FullNameChangedImplCopyWith<$Res> {
  __$$FullNameChangedImplCopyWithImpl(
      _$FullNameChangedImpl _value, $Res Function(_$FullNameChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
  }) {
    return _then(_$FullNameChangedImpl(
      null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FullNameChangedImpl implements FullNameChanged {
  const _$FullNameChangedImpl(this.fullName);

  @override
  final String fullName;

  @override
  String toString() {
    return 'SignupEvent.fullNameChanged(fullName: $fullName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FullNameChangedImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fullName);

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FullNameChangedImplCopyWith<_$FullNameChangedImpl> get copyWith =>
      __$$FullNameChangedImplCopyWithImpl<_$FullNameChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function(String confirmPassword) confirmPasswordChanged,
    required TResult Function(String fullName) fullNameChanged,
    required TResult Function(String country) countryChanged,
    required TResult Function() toggleShowPassword,
    required TResult Function() toggleShowConfirmPassword,
    required TResult Function(bool accepted) termsAcceptedChanged,
    required TResult Function() signupSubmitted,
  }) {
    return fullNameChanged(fullName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function(String confirmPassword)? confirmPasswordChanged,
    TResult? Function(String fullName)? fullNameChanged,
    TResult? Function(String country)? countryChanged,
    TResult? Function()? toggleShowPassword,
    TResult? Function()? toggleShowConfirmPassword,
    TResult? Function(bool accepted)? termsAcceptedChanged,
    TResult? Function()? signupSubmitted,
  }) {
    return fullNameChanged?.call(fullName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function(String confirmPassword)? confirmPasswordChanged,
    TResult Function(String fullName)? fullNameChanged,
    TResult Function(String country)? countryChanged,
    TResult Function()? toggleShowPassword,
    TResult Function()? toggleShowConfirmPassword,
    TResult Function(bool accepted)? termsAcceptedChanged,
    TResult Function()? signupSubmitted,
    required TResult orElse(),
  }) {
    if (fullNameChanged != null) {
      return fullNameChanged(fullName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(FullNameChanged value) fullNameChanged,
    required TResult Function(CountryChanged value) countryChanged,
    required TResult Function(ToggleShowPassword value) toggleShowPassword,
    required TResult Function(ToggleShowConfirmPassword value)
        toggleShowConfirmPassword,
    required TResult Function(TermsAcceptedChanged value) termsAcceptedChanged,
    required TResult Function(SignupSubmitted value) signupSubmitted,
  }) {
    return fullNameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(FullNameChanged value)? fullNameChanged,
    TResult? Function(CountryChanged value)? countryChanged,
    TResult? Function(ToggleShowPassword value)? toggleShowPassword,
    TResult? Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult? Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult? Function(SignupSubmitted value)? signupSubmitted,
  }) {
    return fullNameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(FullNameChanged value)? fullNameChanged,
    TResult Function(CountryChanged value)? countryChanged,
    TResult Function(ToggleShowPassword value)? toggleShowPassword,
    TResult Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult Function(SignupSubmitted value)? signupSubmitted,
    required TResult orElse(),
  }) {
    if (fullNameChanged != null) {
      return fullNameChanged(this);
    }
    return orElse();
  }
}

abstract class FullNameChanged implements SignupEvent {
  const factory FullNameChanged(final String fullName) = _$FullNameChangedImpl;

  String get fullName;

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FullNameChangedImplCopyWith<_$FullNameChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CountryChangedImplCopyWith<$Res> {
  factory _$$CountryChangedImplCopyWith(_$CountryChangedImpl value,
          $Res Function(_$CountryChangedImpl) then) =
      __$$CountryChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String country});
}

/// @nodoc
class __$$CountryChangedImplCopyWithImpl<$Res>
    extends _$SignupEventCopyWithImpl<$Res, _$CountryChangedImpl>
    implements _$$CountryChangedImplCopyWith<$Res> {
  __$$CountryChangedImplCopyWithImpl(
      _$CountryChangedImpl _value, $Res Function(_$CountryChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? country = null,
  }) {
    return _then(_$CountryChangedImpl(
      null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CountryChangedImpl implements CountryChanged {
  const _$CountryChangedImpl(this.country);

  @override
  final String country;

  @override
  String toString() {
    return 'SignupEvent.countryChanged(country: $country)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountryChangedImpl &&
            (identical(other.country, country) || other.country == country));
  }

  @override
  int get hashCode => Object.hash(runtimeType, country);

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CountryChangedImplCopyWith<_$CountryChangedImpl> get copyWith =>
      __$$CountryChangedImplCopyWithImpl<_$CountryChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function(String confirmPassword) confirmPasswordChanged,
    required TResult Function(String fullName) fullNameChanged,
    required TResult Function(String country) countryChanged,
    required TResult Function() toggleShowPassword,
    required TResult Function() toggleShowConfirmPassword,
    required TResult Function(bool accepted) termsAcceptedChanged,
    required TResult Function() signupSubmitted,
  }) {
    return countryChanged(country);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function(String confirmPassword)? confirmPasswordChanged,
    TResult? Function(String fullName)? fullNameChanged,
    TResult? Function(String country)? countryChanged,
    TResult? Function()? toggleShowPassword,
    TResult? Function()? toggleShowConfirmPassword,
    TResult? Function(bool accepted)? termsAcceptedChanged,
    TResult? Function()? signupSubmitted,
  }) {
    return countryChanged?.call(country);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function(String confirmPassword)? confirmPasswordChanged,
    TResult Function(String fullName)? fullNameChanged,
    TResult Function(String country)? countryChanged,
    TResult Function()? toggleShowPassword,
    TResult Function()? toggleShowConfirmPassword,
    TResult Function(bool accepted)? termsAcceptedChanged,
    TResult Function()? signupSubmitted,
    required TResult orElse(),
  }) {
    if (countryChanged != null) {
      return countryChanged(country);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(FullNameChanged value) fullNameChanged,
    required TResult Function(CountryChanged value) countryChanged,
    required TResult Function(ToggleShowPassword value) toggleShowPassword,
    required TResult Function(ToggleShowConfirmPassword value)
        toggleShowConfirmPassword,
    required TResult Function(TermsAcceptedChanged value) termsAcceptedChanged,
    required TResult Function(SignupSubmitted value) signupSubmitted,
  }) {
    return countryChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(FullNameChanged value)? fullNameChanged,
    TResult? Function(CountryChanged value)? countryChanged,
    TResult? Function(ToggleShowPassword value)? toggleShowPassword,
    TResult? Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult? Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult? Function(SignupSubmitted value)? signupSubmitted,
  }) {
    return countryChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(FullNameChanged value)? fullNameChanged,
    TResult Function(CountryChanged value)? countryChanged,
    TResult Function(ToggleShowPassword value)? toggleShowPassword,
    TResult Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult Function(SignupSubmitted value)? signupSubmitted,
    required TResult orElse(),
  }) {
    if (countryChanged != null) {
      return countryChanged(this);
    }
    return orElse();
  }
}

abstract class CountryChanged implements SignupEvent {
  const factory CountryChanged(final String country) = _$CountryChangedImpl;

  String get country;

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CountryChangedImplCopyWith<_$CountryChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleShowPasswordImplCopyWith<$Res> {
  factory _$$ToggleShowPasswordImplCopyWith(_$ToggleShowPasswordImpl value,
          $Res Function(_$ToggleShowPasswordImpl) then) =
      __$$ToggleShowPasswordImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ToggleShowPasswordImplCopyWithImpl<$Res>
    extends _$SignupEventCopyWithImpl<$Res, _$ToggleShowPasswordImpl>
    implements _$$ToggleShowPasswordImplCopyWith<$Res> {
  __$$ToggleShowPasswordImplCopyWithImpl(_$ToggleShowPasswordImpl _value,
      $Res Function(_$ToggleShowPasswordImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ToggleShowPasswordImpl implements ToggleShowPassword {
  const _$ToggleShowPasswordImpl();

  @override
  String toString() {
    return 'SignupEvent.toggleShowPassword()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ToggleShowPasswordImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function(String confirmPassword) confirmPasswordChanged,
    required TResult Function(String fullName) fullNameChanged,
    required TResult Function(String country) countryChanged,
    required TResult Function() toggleShowPassword,
    required TResult Function() toggleShowConfirmPassword,
    required TResult Function(bool accepted) termsAcceptedChanged,
    required TResult Function() signupSubmitted,
  }) {
    return toggleShowPassword();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function(String confirmPassword)? confirmPasswordChanged,
    TResult? Function(String fullName)? fullNameChanged,
    TResult? Function(String country)? countryChanged,
    TResult? Function()? toggleShowPassword,
    TResult? Function()? toggleShowConfirmPassword,
    TResult? Function(bool accepted)? termsAcceptedChanged,
    TResult? Function()? signupSubmitted,
  }) {
    return toggleShowPassword?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function(String confirmPassword)? confirmPasswordChanged,
    TResult Function(String fullName)? fullNameChanged,
    TResult Function(String country)? countryChanged,
    TResult Function()? toggleShowPassword,
    TResult Function()? toggleShowConfirmPassword,
    TResult Function(bool accepted)? termsAcceptedChanged,
    TResult Function()? signupSubmitted,
    required TResult orElse(),
  }) {
    if (toggleShowPassword != null) {
      return toggleShowPassword();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(FullNameChanged value) fullNameChanged,
    required TResult Function(CountryChanged value) countryChanged,
    required TResult Function(ToggleShowPassword value) toggleShowPassword,
    required TResult Function(ToggleShowConfirmPassword value)
        toggleShowConfirmPassword,
    required TResult Function(TermsAcceptedChanged value) termsAcceptedChanged,
    required TResult Function(SignupSubmitted value) signupSubmitted,
  }) {
    return toggleShowPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(FullNameChanged value)? fullNameChanged,
    TResult? Function(CountryChanged value)? countryChanged,
    TResult? Function(ToggleShowPassword value)? toggleShowPassword,
    TResult? Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult? Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult? Function(SignupSubmitted value)? signupSubmitted,
  }) {
    return toggleShowPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(FullNameChanged value)? fullNameChanged,
    TResult Function(CountryChanged value)? countryChanged,
    TResult Function(ToggleShowPassword value)? toggleShowPassword,
    TResult Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult Function(SignupSubmitted value)? signupSubmitted,
    required TResult orElse(),
  }) {
    if (toggleShowPassword != null) {
      return toggleShowPassword(this);
    }
    return orElse();
  }
}

abstract class ToggleShowPassword implements SignupEvent {
  const factory ToggleShowPassword() = _$ToggleShowPasswordImpl;
}

/// @nodoc
abstract class _$$ToggleShowConfirmPasswordImplCopyWith<$Res> {
  factory _$$ToggleShowConfirmPasswordImplCopyWith(
          _$ToggleShowConfirmPasswordImpl value,
          $Res Function(_$ToggleShowConfirmPasswordImpl) then) =
      __$$ToggleShowConfirmPasswordImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ToggleShowConfirmPasswordImplCopyWithImpl<$Res>
    extends _$SignupEventCopyWithImpl<$Res, _$ToggleShowConfirmPasswordImpl>
    implements _$$ToggleShowConfirmPasswordImplCopyWith<$Res> {
  __$$ToggleShowConfirmPasswordImplCopyWithImpl(
      _$ToggleShowConfirmPasswordImpl _value,
      $Res Function(_$ToggleShowConfirmPasswordImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ToggleShowConfirmPasswordImpl implements ToggleShowConfirmPassword {
  const _$ToggleShowConfirmPasswordImpl();

  @override
  String toString() {
    return 'SignupEvent.toggleShowConfirmPassword()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleShowConfirmPasswordImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function(String confirmPassword) confirmPasswordChanged,
    required TResult Function(String fullName) fullNameChanged,
    required TResult Function(String country) countryChanged,
    required TResult Function() toggleShowPassword,
    required TResult Function() toggleShowConfirmPassword,
    required TResult Function(bool accepted) termsAcceptedChanged,
    required TResult Function() signupSubmitted,
  }) {
    return toggleShowConfirmPassword();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function(String confirmPassword)? confirmPasswordChanged,
    TResult? Function(String fullName)? fullNameChanged,
    TResult? Function(String country)? countryChanged,
    TResult? Function()? toggleShowPassword,
    TResult? Function()? toggleShowConfirmPassword,
    TResult? Function(bool accepted)? termsAcceptedChanged,
    TResult? Function()? signupSubmitted,
  }) {
    return toggleShowConfirmPassword?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function(String confirmPassword)? confirmPasswordChanged,
    TResult Function(String fullName)? fullNameChanged,
    TResult Function(String country)? countryChanged,
    TResult Function()? toggleShowPassword,
    TResult Function()? toggleShowConfirmPassword,
    TResult Function(bool accepted)? termsAcceptedChanged,
    TResult Function()? signupSubmitted,
    required TResult orElse(),
  }) {
    if (toggleShowConfirmPassword != null) {
      return toggleShowConfirmPassword();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(FullNameChanged value) fullNameChanged,
    required TResult Function(CountryChanged value) countryChanged,
    required TResult Function(ToggleShowPassword value) toggleShowPassword,
    required TResult Function(ToggleShowConfirmPassword value)
        toggleShowConfirmPassword,
    required TResult Function(TermsAcceptedChanged value) termsAcceptedChanged,
    required TResult Function(SignupSubmitted value) signupSubmitted,
  }) {
    return toggleShowConfirmPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(FullNameChanged value)? fullNameChanged,
    TResult? Function(CountryChanged value)? countryChanged,
    TResult? Function(ToggleShowPassword value)? toggleShowPassword,
    TResult? Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult? Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult? Function(SignupSubmitted value)? signupSubmitted,
  }) {
    return toggleShowConfirmPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(FullNameChanged value)? fullNameChanged,
    TResult Function(CountryChanged value)? countryChanged,
    TResult Function(ToggleShowPassword value)? toggleShowPassword,
    TResult Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult Function(SignupSubmitted value)? signupSubmitted,
    required TResult orElse(),
  }) {
    if (toggleShowConfirmPassword != null) {
      return toggleShowConfirmPassword(this);
    }
    return orElse();
  }
}

abstract class ToggleShowConfirmPassword implements SignupEvent {
  const factory ToggleShowConfirmPassword() = _$ToggleShowConfirmPasswordImpl;
}

/// @nodoc
abstract class _$$TermsAcceptedChangedImplCopyWith<$Res> {
  factory _$$TermsAcceptedChangedImplCopyWith(_$TermsAcceptedChangedImpl value,
          $Res Function(_$TermsAcceptedChangedImpl) then) =
      __$$TermsAcceptedChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool accepted});
}

/// @nodoc
class __$$TermsAcceptedChangedImplCopyWithImpl<$Res>
    extends _$SignupEventCopyWithImpl<$Res, _$TermsAcceptedChangedImpl>
    implements _$$TermsAcceptedChangedImplCopyWith<$Res> {
  __$$TermsAcceptedChangedImplCopyWithImpl(_$TermsAcceptedChangedImpl _value,
      $Res Function(_$TermsAcceptedChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accepted = null,
  }) {
    return _then(_$TermsAcceptedChangedImpl(
      null == accepted
          ? _value.accepted
          : accepted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TermsAcceptedChangedImpl implements TermsAcceptedChanged {
  const _$TermsAcceptedChangedImpl(this.accepted);

  @override
  final bool accepted;

  @override
  String toString() {
    return 'SignupEvent.termsAcceptedChanged(accepted: $accepted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermsAcceptedChangedImpl &&
            (identical(other.accepted, accepted) ||
                other.accepted == accepted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accepted);

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TermsAcceptedChangedImplCopyWith<_$TermsAcceptedChangedImpl>
      get copyWith =>
          __$$TermsAcceptedChangedImplCopyWithImpl<_$TermsAcceptedChangedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function(String confirmPassword) confirmPasswordChanged,
    required TResult Function(String fullName) fullNameChanged,
    required TResult Function(String country) countryChanged,
    required TResult Function() toggleShowPassword,
    required TResult Function() toggleShowConfirmPassword,
    required TResult Function(bool accepted) termsAcceptedChanged,
    required TResult Function() signupSubmitted,
  }) {
    return termsAcceptedChanged(accepted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function(String confirmPassword)? confirmPasswordChanged,
    TResult? Function(String fullName)? fullNameChanged,
    TResult? Function(String country)? countryChanged,
    TResult? Function()? toggleShowPassword,
    TResult? Function()? toggleShowConfirmPassword,
    TResult? Function(bool accepted)? termsAcceptedChanged,
    TResult? Function()? signupSubmitted,
  }) {
    return termsAcceptedChanged?.call(accepted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function(String confirmPassword)? confirmPasswordChanged,
    TResult Function(String fullName)? fullNameChanged,
    TResult Function(String country)? countryChanged,
    TResult Function()? toggleShowPassword,
    TResult Function()? toggleShowConfirmPassword,
    TResult Function(bool accepted)? termsAcceptedChanged,
    TResult Function()? signupSubmitted,
    required TResult orElse(),
  }) {
    if (termsAcceptedChanged != null) {
      return termsAcceptedChanged(accepted);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(FullNameChanged value) fullNameChanged,
    required TResult Function(CountryChanged value) countryChanged,
    required TResult Function(ToggleShowPassword value) toggleShowPassword,
    required TResult Function(ToggleShowConfirmPassword value)
        toggleShowConfirmPassword,
    required TResult Function(TermsAcceptedChanged value) termsAcceptedChanged,
    required TResult Function(SignupSubmitted value) signupSubmitted,
  }) {
    return termsAcceptedChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(FullNameChanged value)? fullNameChanged,
    TResult? Function(CountryChanged value)? countryChanged,
    TResult? Function(ToggleShowPassword value)? toggleShowPassword,
    TResult? Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult? Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult? Function(SignupSubmitted value)? signupSubmitted,
  }) {
    return termsAcceptedChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(FullNameChanged value)? fullNameChanged,
    TResult Function(CountryChanged value)? countryChanged,
    TResult Function(ToggleShowPassword value)? toggleShowPassword,
    TResult Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult Function(SignupSubmitted value)? signupSubmitted,
    required TResult orElse(),
  }) {
    if (termsAcceptedChanged != null) {
      return termsAcceptedChanged(this);
    }
    return orElse();
  }
}

abstract class TermsAcceptedChanged implements SignupEvent {
  const factory TermsAcceptedChanged(final bool accepted) =
      _$TermsAcceptedChangedImpl;

  bool get accepted;

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TermsAcceptedChangedImplCopyWith<_$TermsAcceptedChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignupSubmittedImplCopyWith<$Res> {
  factory _$$SignupSubmittedImplCopyWith(_$SignupSubmittedImpl value,
          $Res Function(_$SignupSubmittedImpl) then) =
      __$$SignupSubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SignupSubmittedImplCopyWithImpl<$Res>
    extends _$SignupEventCopyWithImpl<$Res, _$SignupSubmittedImpl>
    implements _$$SignupSubmittedImplCopyWith<$Res> {
  __$$SignupSubmittedImplCopyWithImpl(
      _$SignupSubmittedImpl _value, $Res Function(_$SignupSubmittedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SignupSubmittedImpl implements SignupSubmitted {
  const _$SignupSubmittedImpl();

  @override
  String toString() {
    return 'SignupEvent.signupSubmitted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SignupSubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function(String confirmPassword) confirmPasswordChanged,
    required TResult Function(String fullName) fullNameChanged,
    required TResult Function(String country) countryChanged,
    required TResult Function() toggleShowPassword,
    required TResult Function() toggleShowConfirmPassword,
    required TResult Function(bool accepted) termsAcceptedChanged,
    required TResult Function() signupSubmitted,
  }) {
    return signupSubmitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? emailChanged,
    TResult? Function(String password)? passwordChanged,
    TResult? Function(String confirmPassword)? confirmPasswordChanged,
    TResult? Function(String fullName)? fullNameChanged,
    TResult? Function(String country)? countryChanged,
    TResult? Function()? toggleShowPassword,
    TResult? Function()? toggleShowConfirmPassword,
    TResult? Function(bool accepted)? termsAcceptedChanged,
    TResult? Function()? signupSubmitted,
  }) {
    return signupSubmitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function(String confirmPassword)? confirmPasswordChanged,
    TResult Function(String fullName)? fullNameChanged,
    TResult Function(String country)? countryChanged,
    TResult Function()? toggleShowPassword,
    TResult Function()? toggleShowConfirmPassword,
    TResult Function(bool accepted)? termsAcceptedChanged,
    TResult Function()? signupSubmitted,
    required TResult orElse(),
  }) {
    if (signupSubmitted != null) {
      return signupSubmitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmailChanged value) emailChanged,
    required TResult Function(PasswordChanged value) passwordChanged,
    required TResult Function(ConfirmPasswordChanged value)
        confirmPasswordChanged,
    required TResult Function(FullNameChanged value) fullNameChanged,
    required TResult Function(CountryChanged value) countryChanged,
    required TResult Function(ToggleShowPassword value) toggleShowPassword,
    required TResult Function(ToggleShowConfirmPassword value)
        toggleShowConfirmPassword,
    required TResult Function(TermsAcceptedChanged value) termsAcceptedChanged,
    required TResult Function(SignupSubmitted value) signupSubmitted,
  }) {
    return signupSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmailChanged value)? emailChanged,
    TResult? Function(PasswordChanged value)? passwordChanged,
    TResult? Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult? Function(FullNameChanged value)? fullNameChanged,
    TResult? Function(CountryChanged value)? countryChanged,
    TResult? Function(ToggleShowPassword value)? toggleShowPassword,
    TResult? Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult? Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult? Function(SignupSubmitted value)? signupSubmitted,
  }) {
    return signupSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmailChanged value)? emailChanged,
    TResult Function(PasswordChanged value)? passwordChanged,
    TResult Function(ConfirmPasswordChanged value)? confirmPasswordChanged,
    TResult Function(FullNameChanged value)? fullNameChanged,
    TResult Function(CountryChanged value)? countryChanged,
    TResult Function(ToggleShowPassword value)? toggleShowPassword,
    TResult Function(ToggleShowConfirmPassword value)?
        toggleShowConfirmPassword,
    TResult Function(TermsAcceptedChanged value)? termsAcceptedChanged,
    TResult Function(SignupSubmitted value)? signupSubmitted,
    required TResult orElse(),
  }) {
    if (signupSubmitted != null) {
      return signupSubmitted(this);
    }
    return orElse();
  }
}

abstract class SignupSubmitted implements SignupEvent {
  const factory SignupSubmitted() = _$SignupSubmittedImpl;
}
