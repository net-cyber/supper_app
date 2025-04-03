// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_verification_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OtpVerificationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String otpCode) otpCodeChanged,
    required TResult Function() verifyOtpSubmitted,
    required TResult Function() resendOtpRequested,
    required TResult Function(String phoneNumber) phoneNumberSet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String otpCode)? otpCodeChanged,
    TResult? Function()? verifyOtpSubmitted,
    TResult? Function()? resendOtpRequested,
    TResult? Function(String phoneNumber)? phoneNumberSet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String otpCode)? otpCodeChanged,
    TResult Function()? verifyOtpSubmitted,
    TResult Function()? resendOtpRequested,
    TResult Function(String phoneNumber)? phoneNumberSet,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpCodeChanged value) otpCodeChanged,
    required TResult Function(VerifyOtpSubmitted value) verifyOtpSubmitted,
    required TResult Function(ResendOtpRequested value) resendOtpRequested,
    required TResult Function(PhoneNumberSet value) phoneNumberSet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(VerifyOtpSubmitted value)? verifyOtpSubmitted,
    TResult? Function(ResendOtpRequested value)? resendOtpRequested,
    TResult? Function(PhoneNumberSet value)? phoneNumberSet,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpCodeChanged value)? otpCodeChanged,
    TResult Function(VerifyOtpSubmitted value)? verifyOtpSubmitted,
    TResult Function(ResendOtpRequested value)? resendOtpRequested,
    TResult Function(PhoneNumberSet value)? phoneNumberSet,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpVerificationEventCopyWith<$Res> {
  factory $OtpVerificationEventCopyWith(OtpVerificationEvent value,
          $Res Function(OtpVerificationEvent) then) =
      _$OtpVerificationEventCopyWithImpl<$Res, OtpVerificationEvent>;
}

/// @nodoc
class _$OtpVerificationEventCopyWithImpl<$Res,
        $Val extends OtpVerificationEvent>
    implements $OtpVerificationEventCopyWith<$Res> {
  _$OtpVerificationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpVerificationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$OtpCodeChangedImplCopyWith<$Res> {
  factory _$$OtpCodeChangedImplCopyWith(_$OtpCodeChangedImpl value,
          $Res Function(_$OtpCodeChangedImpl) then) =
      __$$OtpCodeChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String otpCode});
}

/// @nodoc
class __$$OtpCodeChangedImplCopyWithImpl<$Res>
    extends _$OtpVerificationEventCopyWithImpl<$Res, _$OtpCodeChangedImpl>
    implements _$$OtpCodeChangedImplCopyWith<$Res> {
  __$$OtpCodeChangedImplCopyWithImpl(
      _$OtpCodeChangedImpl _value, $Res Function(_$OtpCodeChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpVerificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otpCode = null,
  }) {
    return _then(_$OtpCodeChangedImpl(
      null == otpCode
          ? _value.otpCode
          : otpCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OtpCodeChangedImpl implements OtpCodeChanged {
  const _$OtpCodeChangedImpl(this.otpCode);

  @override
  final String otpCode;

  @override
  String toString() {
    return 'OtpVerificationEvent.otpCodeChanged(otpCode: $otpCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpCodeChangedImpl &&
            (identical(other.otpCode, otpCode) || other.otpCode == otpCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, otpCode);

  /// Create a copy of OtpVerificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpCodeChangedImplCopyWith<_$OtpCodeChangedImpl> get copyWith =>
      __$$OtpCodeChangedImplCopyWithImpl<_$OtpCodeChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String otpCode) otpCodeChanged,
    required TResult Function() verifyOtpSubmitted,
    required TResult Function() resendOtpRequested,
    required TResult Function(String phoneNumber) phoneNumberSet,
  }) {
    return otpCodeChanged(otpCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String otpCode)? otpCodeChanged,
    TResult? Function()? verifyOtpSubmitted,
    TResult? Function()? resendOtpRequested,
    TResult? Function(String phoneNumber)? phoneNumberSet,
  }) {
    return otpCodeChanged?.call(otpCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String otpCode)? otpCodeChanged,
    TResult Function()? verifyOtpSubmitted,
    TResult Function()? resendOtpRequested,
    TResult Function(String phoneNumber)? phoneNumberSet,
    required TResult orElse(),
  }) {
    if (otpCodeChanged != null) {
      return otpCodeChanged(otpCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpCodeChanged value) otpCodeChanged,
    required TResult Function(VerifyOtpSubmitted value) verifyOtpSubmitted,
    required TResult Function(ResendOtpRequested value) resendOtpRequested,
    required TResult Function(PhoneNumberSet value) phoneNumberSet,
  }) {
    return otpCodeChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(VerifyOtpSubmitted value)? verifyOtpSubmitted,
    TResult? Function(ResendOtpRequested value)? resendOtpRequested,
    TResult? Function(PhoneNumberSet value)? phoneNumberSet,
  }) {
    return otpCodeChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpCodeChanged value)? otpCodeChanged,
    TResult Function(VerifyOtpSubmitted value)? verifyOtpSubmitted,
    TResult Function(ResendOtpRequested value)? resendOtpRequested,
    TResult Function(PhoneNumberSet value)? phoneNumberSet,
    required TResult orElse(),
  }) {
    if (otpCodeChanged != null) {
      return otpCodeChanged(this);
    }
    return orElse();
  }
}

abstract class OtpCodeChanged implements OtpVerificationEvent {
  const factory OtpCodeChanged(final String otpCode) = _$OtpCodeChangedImpl;

  String get otpCode;

  /// Create a copy of OtpVerificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpCodeChangedImplCopyWith<_$OtpCodeChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VerifyOtpSubmittedImplCopyWith<$Res> {
  factory _$$VerifyOtpSubmittedImplCopyWith(_$VerifyOtpSubmittedImpl value,
          $Res Function(_$VerifyOtpSubmittedImpl) then) =
      __$$VerifyOtpSubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$VerifyOtpSubmittedImplCopyWithImpl<$Res>
    extends _$OtpVerificationEventCopyWithImpl<$Res, _$VerifyOtpSubmittedImpl>
    implements _$$VerifyOtpSubmittedImplCopyWith<$Res> {
  __$$VerifyOtpSubmittedImplCopyWithImpl(_$VerifyOtpSubmittedImpl _value,
      $Res Function(_$VerifyOtpSubmittedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpVerificationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$VerifyOtpSubmittedImpl implements VerifyOtpSubmitted {
  const _$VerifyOtpSubmittedImpl();

  @override
  String toString() {
    return 'OtpVerificationEvent.verifyOtpSubmitted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$VerifyOtpSubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String otpCode) otpCodeChanged,
    required TResult Function() verifyOtpSubmitted,
    required TResult Function() resendOtpRequested,
    required TResult Function(String phoneNumber) phoneNumberSet,
  }) {
    return verifyOtpSubmitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String otpCode)? otpCodeChanged,
    TResult? Function()? verifyOtpSubmitted,
    TResult? Function()? resendOtpRequested,
    TResult? Function(String phoneNumber)? phoneNumberSet,
  }) {
    return verifyOtpSubmitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String otpCode)? otpCodeChanged,
    TResult Function()? verifyOtpSubmitted,
    TResult Function()? resendOtpRequested,
    TResult Function(String phoneNumber)? phoneNumberSet,
    required TResult orElse(),
  }) {
    if (verifyOtpSubmitted != null) {
      return verifyOtpSubmitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpCodeChanged value) otpCodeChanged,
    required TResult Function(VerifyOtpSubmitted value) verifyOtpSubmitted,
    required TResult Function(ResendOtpRequested value) resendOtpRequested,
    required TResult Function(PhoneNumberSet value) phoneNumberSet,
  }) {
    return verifyOtpSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(VerifyOtpSubmitted value)? verifyOtpSubmitted,
    TResult? Function(ResendOtpRequested value)? resendOtpRequested,
    TResult? Function(PhoneNumberSet value)? phoneNumberSet,
  }) {
    return verifyOtpSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpCodeChanged value)? otpCodeChanged,
    TResult Function(VerifyOtpSubmitted value)? verifyOtpSubmitted,
    TResult Function(ResendOtpRequested value)? resendOtpRequested,
    TResult Function(PhoneNumberSet value)? phoneNumberSet,
    required TResult orElse(),
  }) {
    if (verifyOtpSubmitted != null) {
      return verifyOtpSubmitted(this);
    }
    return orElse();
  }
}

abstract class VerifyOtpSubmitted implements OtpVerificationEvent {
  const factory VerifyOtpSubmitted() = _$VerifyOtpSubmittedImpl;
}

/// @nodoc
abstract class _$$ResendOtpRequestedImplCopyWith<$Res> {
  factory _$$ResendOtpRequestedImplCopyWith(_$ResendOtpRequestedImpl value,
          $Res Function(_$ResendOtpRequestedImpl) then) =
      __$$ResendOtpRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResendOtpRequestedImplCopyWithImpl<$Res>
    extends _$OtpVerificationEventCopyWithImpl<$Res, _$ResendOtpRequestedImpl>
    implements _$$ResendOtpRequestedImplCopyWith<$Res> {
  __$$ResendOtpRequestedImplCopyWithImpl(_$ResendOtpRequestedImpl _value,
      $Res Function(_$ResendOtpRequestedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpVerificationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResendOtpRequestedImpl implements ResendOtpRequested {
  const _$ResendOtpRequestedImpl();

  @override
  String toString() {
    return 'OtpVerificationEvent.resendOtpRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResendOtpRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String otpCode) otpCodeChanged,
    required TResult Function() verifyOtpSubmitted,
    required TResult Function() resendOtpRequested,
    required TResult Function(String phoneNumber) phoneNumberSet,
  }) {
    return resendOtpRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String otpCode)? otpCodeChanged,
    TResult? Function()? verifyOtpSubmitted,
    TResult? Function()? resendOtpRequested,
    TResult? Function(String phoneNumber)? phoneNumberSet,
  }) {
    return resendOtpRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String otpCode)? otpCodeChanged,
    TResult Function()? verifyOtpSubmitted,
    TResult Function()? resendOtpRequested,
    TResult Function(String phoneNumber)? phoneNumberSet,
    required TResult orElse(),
  }) {
    if (resendOtpRequested != null) {
      return resendOtpRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpCodeChanged value) otpCodeChanged,
    required TResult Function(VerifyOtpSubmitted value) verifyOtpSubmitted,
    required TResult Function(ResendOtpRequested value) resendOtpRequested,
    required TResult Function(PhoneNumberSet value) phoneNumberSet,
  }) {
    return resendOtpRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(VerifyOtpSubmitted value)? verifyOtpSubmitted,
    TResult? Function(ResendOtpRequested value)? resendOtpRequested,
    TResult? Function(PhoneNumberSet value)? phoneNumberSet,
  }) {
    return resendOtpRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpCodeChanged value)? otpCodeChanged,
    TResult Function(VerifyOtpSubmitted value)? verifyOtpSubmitted,
    TResult Function(ResendOtpRequested value)? resendOtpRequested,
    TResult Function(PhoneNumberSet value)? phoneNumberSet,
    required TResult orElse(),
  }) {
    if (resendOtpRequested != null) {
      return resendOtpRequested(this);
    }
    return orElse();
  }
}

abstract class ResendOtpRequested implements OtpVerificationEvent {
  const factory ResendOtpRequested() = _$ResendOtpRequestedImpl;
}

/// @nodoc
abstract class _$$PhoneNumberSetImplCopyWith<$Res> {
  factory _$$PhoneNumberSetImplCopyWith(_$PhoneNumberSetImpl value,
          $Res Function(_$PhoneNumberSetImpl) then) =
      __$$PhoneNumberSetImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String phoneNumber});
}

/// @nodoc
class __$$PhoneNumberSetImplCopyWithImpl<$Res>
    extends _$OtpVerificationEventCopyWithImpl<$Res, _$PhoneNumberSetImpl>
    implements _$$PhoneNumberSetImplCopyWith<$Res> {
  __$$PhoneNumberSetImplCopyWithImpl(
      _$PhoneNumberSetImpl _value, $Res Function(_$PhoneNumberSetImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpVerificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
  }) {
    return _then(_$PhoneNumberSetImpl(
      null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PhoneNumberSetImpl implements PhoneNumberSet {
  const _$PhoneNumberSetImpl(this.phoneNumber);

  @override
  final String phoneNumber;

  @override
  String toString() {
    return 'OtpVerificationEvent.phoneNumberSet(phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneNumberSetImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber);

  /// Create a copy of OtpVerificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneNumberSetImplCopyWith<_$PhoneNumberSetImpl> get copyWith =>
      __$$PhoneNumberSetImplCopyWithImpl<_$PhoneNumberSetImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String otpCode) otpCodeChanged,
    required TResult Function() verifyOtpSubmitted,
    required TResult Function() resendOtpRequested,
    required TResult Function(String phoneNumber) phoneNumberSet,
  }) {
    return phoneNumberSet(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String otpCode)? otpCodeChanged,
    TResult? Function()? verifyOtpSubmitted,
    TResult? Function()? resendOtpRequested,
    TResult? Function(String phoneNumber)? phoneNumberSet,
  }) {
    return phoneNumberSet?.call(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String otpCode)? otpCodeChanged,
    TResult Function()? verifyOtpSubmitted,
    TResult Function()? resendOtpRequested,
    TResult Function(String phoneNumber)? phoneNumberSet,
    required TResult orElse(),
  }) {
    if (phoneNumberSet != null) {
      return phoneNumberSet(phoneNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtpCodeChanged value) otpCodeChanged,
    required TResult Function(VerifyOtpSubmitted value) verifyOtpSubmitted,
    required TResult Function(ResendOtpRequested value) resendOtpRequested,
    required TResult Function(PhoneNumberSet value) phoneNumberSet,
  }) {
    return phoneNumberSet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OtpCodeChanged value)? otpCodeChanged,
    TResult? Function(VerifyOtpSubmitted value)? verifyOtpSubmitted,
    TResult? Function(ResendOtpRequested value)? resendOtpRequested,
    TResult? Function(PhoneNumberSet value)? phoneNumberSet,
  }) {
    return phoneNumberSet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtpCodeChanged value)? otpCodeChanged,
    TResult Function(VerifyOtpSubmitted value)? verifyOtpSubmitted,
    TResult Function(ResendOtpRequested value)? resendOtpRequested,
    TResult Function(PhoneNumberSet value)? phoneNumberSet,
    required TResult orElse(),
  }) {
    if (phoneNumberSet != null) {
      return phoneNumberSet(this);
    }
    return orElse();
  }
}

abstract class PhoneNumberSet implements OtpVerificationEvent {
  const factory PhoneNumberSet(final String phoneNumber) = _$PhoneNumberSetImpl;

  String get phoneNumber;

  /// Create a copy of OtpVerificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhoneNumberSetImplCopyWith<_$PhoneNumberSetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OtpVerificationState {
  String get otpCode => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  bool get isVerifying => throw _privateConstructorUsedError;
  bool get isResending => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  bool get verificationError => throw _privateConstructorUsedError;
  bool get resendError => throw _privateConstructorUsedError;
  bool get resendSuccess => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// Create a copy of OtpVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OtpVerificationStateCopyWith<OtpVerificationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpVerificationStateCopyWith<$Res> {
  factory $OtpVerificationStateCopyWith(OtpVerificationState value,
          $Res Function(OtpVerificationState) then) =
      _$OtpVerificationStateCopyWithImpl<$Res, OtpVerificationState>;
  @useResult
  $Res call(
      {String otpCode,
      String phoneNumber,
      bool isVerifying,
      bool isResending,
      bool isVerified,
      bool verificationError,
      bool resendError,
      bool resendSuccess,
      String errorMessage,
      DateTime? expiresAt});
}

/// @nodoc
class _$OtpVerificationStateCopyWithImpl<$Res,
        $Val extends OtpVerificationState>
    implements $OtpVerificationStateCopyWith<$Res> {
  _$OtpVerificationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OtpVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otpCode = null,
    Object? phoneNumber = null,
    Object? isVerifying = null,
    Object? isResending = null,
    Object? isVerified = null,
    Object? verificationError = null,
    Object? resendError = null,
    Object? resendSuccess = null,
    Object? errorMessage = null,
    Object? expiresAt = freezed,
  }) {
    return _then(_value.copyWith(
      otpCode: null == otpCode
          ? _value.otpCode
          : otpCode // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      isVerifying: null == isVerifying
          ? _value.isVerifying
          : isVerifying // ignore: cast_nullable_to_non_nullable
              as bool,
      isResending: null == isResending
          ? _value.isResending
          : isResending // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      verificationError: null == verificationError
          ? _value.verificationError
          : verificationError // ignore: cast_nullable_to_non_nullable
              as bool,
      resendError: null == resendError
          ? _value.resendError
          : resendError // ignore: cast_nullable_to_non_nullable
              as bool,
      resendSuccess: null == resendSuccess
          ? _value.resendSuccess
          : resendSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OtpVerificationStateImplCopyWith<$Res>
    implements $OtpVerificationStateCopyWith<$Res> {
  factory _$$OtpVerificationStateImplCopyWith(_$OtpVerificationStateImpl value,
          $Res Function(_$OtpVerificationStateImpl) then) =
      __$$OtpVerificationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String otpCode,
      String phoneNumber,
      bool isVerifying,
      bool isResending,
      bool isVerified,
      bool verificationError,
      bool resendError,
      bool resendSuccess,
      String errorMessage,
      DateTime? expiresAt});
}

/// @nodoc
class __$$OtpVerificationStateImplCopyWithImpl<$Res>
    extends _$OtpVerificationStateCopyWithImpl<$Res, _$OtpVerificationStateImpl>
    implements _$$OtpVerificationStateImplCopyWith<$Res> {
  __$$OtpVerificationStateImplCopyWithImpl(_$OtpVerificationStateImpl _value,
      $Res Function(_$OtpVerificationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of OtpVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otpCode = null,
    Object? phoneNumber = null,
    Object? isVerifying = null,
    Object? isResending = null,
    Object? isVerified = null,
    Object? verificationError = null,
    Object? resendError = null,
    Object? resendSuccess = null,
    Object? errorMessage = null,
    Object? expiresAt = freezed,
  }) {
    return _then(_$OtpVerificationStateImpl(
      otpCode: null == otpCode
          ? _value.otpCode
          : otpCode // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      isVerifying: null == isVerifying
          ? _value.isVerifying
          : isVerifying // ignore: cast_nullable_to_non_nullable
              as bool,
      isResending: null == isResending
          ? _value.isResending
          : isResending // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      verificationError: null == verificationError
          ? _value.verificationError
          : verificationError // ignore: cast_nullable_to_non_nullable
              as bool,
      resendError: null == resendError
          ? _value.resendError
          : resendError // ignore: cast_nullable_to_non_nullable
              as bool,
      resendSuccess: null == resendSuccess
          ? _value.resendSuccess
          : resendSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$OtpVerificationStateImpl implements _OtpVerificationState {
  const _$OtpVerificationStateImpl(
      {required this.otpCode,
      required this.phoneNumber,
      required this.isVerifying,
      required this.isResending,
      required this.isVerified,
      required this.verificationError,
      required this.resendError,
      required this.resendSuccess,
      required this.errorMessage,
      this.expiresAt});

  @override
  final String otpCode;
  @override
  final String phoneNumber;
  @override
  final bool isVerifying;
  @override
  final bool isResending;
  @override
  final bool isVerified;
  @override
  final bool verificationError;
  @override
  final bool resendError;
  @override
  final bool resendSuccess;
  @override
  final String errorMessage;
  @override
  final DateTime? expiresAt;

  @override
  String toString() {
    return 'OtpVerificationState(otpCode: $otpCode, phoneNumber: $phoneNumber, isVerifying: $isVerifying, isResending: $isResending, isVerified: $isVerified, verificationError: $verificationError, resendError: $resendError, resendSuccess: $resendSuccess, errorMessage: $errorMessage, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OtpVerificationStateImpl &&
            (identical(other.otpCode, otpCode) || other.otpCode == otpCode) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.isVerifying, isVerifying) ||
                other.isVerifying == isVerifying) &&
            (identical(other.isResending, isResending) ||
                other.isResending == isResending) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.verificationError, verificationError) ||
                other.verificationError == verificationError) &&
            (identical(other.resendError, resendError) ||
                other.resendError == resendError) &&
            (identical(other.resendSuccess, resendSuccess) ||
                other.resendSuccess == resendSuccess) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      otpCode,
      phoneNumber,
      isVerifying,
      isResending,
      isVerified,
      verificationError,
      resendError,
      resendSuccess,
      errorMessage,
      expiresAt);

  /// Create a copy of OtpVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpVerificationStateImplCopyWith<_$OtpVerificationStateImpl>
      get copyWith =>
          __$$OtpVerificationStateImplCopyWithImpl<_$OtpVerificationStateImpl>(
              this, _$identity);
}

abstract class _OtpVerificationState implements OtpVerificationState {
  const factory _OtpVerificationState(
      {required final String otpCode,
      required final String phoneNumber,
      required final bool isVerifying,
      required final bool isResending,
      required final bool isVerified,
      required final bool verificationError,
      required final bool resendError,
      required final bool resendSuccess,
      required final String errorMessage,
      final DateTime? expiresAt}) = _$OtpVerificationStateImpl;

  @override
  String get otpCode;
  @override
  String get phoneNumber;
  @override
  bool get isVerifying;
  @override
  bool get isResending;
  @override
  bool get isVerified;
  @override
  bool get verificationError;
  @override
  bool get resendError;
  @override
  bool get resendSuccess;
  @override
  String get errorMessage;
  @override
  DateTime? get expiresAt;

  /// Create a copy of OtpVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OtpVerificationStateImplCopyWith<_$OtpVerificationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
