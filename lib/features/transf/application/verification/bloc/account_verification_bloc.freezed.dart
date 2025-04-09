// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_verification_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountVerificationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int accountId) accountIdChanged,
    required TResult Function() verifyAccountSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int accountId)? accountIdChanged,
    TResult? Function()? verifyAccountSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int accountId)? accountIdChanged,
    TResult Function()? verifyAccountSubmitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountIdChanged value) accountIdChanged,
    required TResult Function(VerifyAccountSubmitted value)
        verifyAccountSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountIdChanged value)? accountIdChanged,
    TResult? Function(VerifyAccountSubmitted value)? verifyAccountSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountIdChanged value)? accountIdChanged,
    TResult Function(VerifyAccountSubmitted value)? verifyAccountSubmitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountVerificationEventCopyWith<$Res> {
  factory $AccountVerificationEventCopyWith(AccountVerificationEvent value,
          $Res Function(AccountVerificationEvent) then) =
      _$AccountVerificationEventCopyWithImpl<$Res, AccountVerificationEvent>;
}

/// @nodoc
class _$AccountVerificationEventCopyWithImpl<$Res,
        $Val extends AccountVerificationEvent>
    implements $AccountVerificationEventCopyWith<$Res> {
  _$AccountVerificationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountVerificationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AccountIdChangedImplCopyWith<$Res> {
  factory _$$AccountIdChangedImplCopyWith(_$AccountIdChangedImpl value,
          $Res Function(_$AccountIdChangedImpl) then) =
      __$$AccountIdChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int accountId});
}

/// @nodoc
class __$$AccountIdChangedImplCopyWithImpl<$Res>
    extends _$AccountVerificationEventCopyWithImpl<$Res, _$AccountIdChangedImpl>
    implements _$$AccountIdChangedImplCopyWith<$Res> {
  __$$AccountIdChangedImplCopyWithImpl(_$AccountIdChangedImpl _value,
      $Res Function(_$AccountIdChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountVerificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
  }) {
    return _then(_$AccountIdChangedImpl(
      null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AccountIdChangedImpl implements AccountIdChanged {
  const _$AccountIdChangedImpl(this.accountId);

  @override
  final int accountId;

  @override
  String toString() {
    return 'AccountVerificationEvent.accountIdChanged(accountId: $accountId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountIdChangedImpl &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accountId);

  /// Create a copy of AccountVerificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountIdChangedImplCopyWith<_$AccountIdChangedImpl> get copyWith =>
      __$$AccountIdChangedImplCopyWithImpl<_$AccountIdChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int accountId) accountIdChanged,
    required TResult Function() verifyAccountSubmitted,
  }) {
    return accountIdChanged(accountId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int accountId)? accountIdChanged,
    TResult? Function()? verifyAccountSubmitted,
  }) {
    return accountIdChanged?.call(accountId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int accountId)? accountIdChanged,
    TResult Function()? verifyAccountSubmitted,
    required TResult orElse(),
  }) {
    if (accountIdChanged != null) {
      return accountIdChanged(accountId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountIdChanged value) accountIdChanged,
    required TResult Function(VerifyAccountSubmitted value)
        verifyAccountSubmitted,
  }) {
    return accountIdChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountIdChanged value)? accountIdChanged,
    TResult? Function(VerifyAccountSubmitted value)? verifyAccountSubmitted,
  }) {
    return accountIdChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountIdChanged value)? accountIdChanged,
    TResult Function(VerifyAccountSubmitted value)? verifyAccountSubmitted,
    required TResult orElse(),
  }) {
    if (accountIdChanged != null) {
      return accountIdChanged(this);
    }
    return orElse();
  }
}

abstract class AccountIdChanged implements AccountVerificationEvent {
  const factory AccountIdChanged(final int accountId) = _$AccountIdChangedImpl;

  int get accountId;

  /// Create a copy of AccountVerificationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountIdChangedImplCopyWith<_$AccountIdChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VerifyAccountSubmittedImplCopyWith<$Res> {
  factory _$$VerifyAccountSubmittedImplCopyWith(
          _$VerifyAccountSubmittedImpl value,
          $Res Function(_$VerifyAccountSubmittedImpl) then) =
      __$$VerifyAccountSubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$VerifyAccountSubmittedImplCopyWithImpl<$Res>
    extends _$AccountVerificationEventCopyWithImpl<$Res,
        _$VerifyAccountSubmittedImpl>
    implements _$$VerifyAccountSubmittedImplCopyWith<$Res> {
  __$$VerifyAccountSubmittedImplCopyWithImpl(
      _$VerifyAccountSubmittedImpl _value,
      $Res Function(_$VerifyAccountSubmittedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountVerificationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$VerifyAccountSubmittedImpl implements VerifyAccountSubmitted {
  const _$VerifyAccountSubmittedImpl();

  @override
  String toString() {
    return 'AccountVerificationEvent.verifyAccountSubmitted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyAccountSubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int accountId) accountIdChanged,
    required TResult Function() verifyAccountSubmitted,
  }) {
    return verifyAccountSubmitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int accountId)? accountIdChanged,
    TResult? Function()? verifyAccountSubmitted,
  }) {
    return verifyAccountSubmitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int accountId)? accountIdChanged,
    TResult Function()? verifyAccountSubmitted,
    required TResult orElse(),
  }) {
    if (verifyAccountSubmitted != null) {
      return verifyAccountSubmitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountIdChanged value) accountIdChanged,
    required TResult Function(VerifyAccountSubmitted value)
        verifyAccountSubmitted,
  }) {
    return verifyAccountSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountIdChanged value)? accountIdChanged,
    TResult? Function(VerifyAccountSubmitted value)? verifyAccountSubmitted,
  }) {
    return verifyAccountSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountIdChanged value)? accountIdChanged,
    TResult Function(VerifyAccountSubmitted value)? verifyAccountSubmitted,
    required TResult orElse(),
  }) {
    if (verifyAccountSubmitted != null) {
      return verifyAccountSubmitted(this);
    }
    return orElse();
  }
}

abstract class VerifyAccountSubmitted implements AccountVerificationEvent {
  const factory VerifyAccountSubmitted() = _$VerifyAccountSubmittedImpl;
}

/// @nodoc
mixin _$AccountVerificationState {
  int get accountId => throw _privateConstructorUsedError;
  bool get isVerifying => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  bool get verificationError => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;

  /// Create a copy of AccountVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountVerificationStateCopyWith<AccountVerificationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountVerificationStateCopyWith<$Res> {
  factory $AccountVerificationStateCopyWith(AccountVerificationState value,
          $Res Function(AccountVerificationState) then) =
      _$AccountVerificationStateCopyWithImpl<$Res, AccountVerificationState>;
  @useResult
  $Res call(
      {int accountId,
      bool isVerifying,
      bool isVerified,
      bool verificationError,
      String errorMessage,
      String fullName});
}

/// @nodoc
class _$AccountVerificationStateCopyWithImpl<$Res,
        $Val extends AccountVerificationState>
    implements $AccountVerificationStateCopyWith<$Res> {
  _$AccountVerificationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
    Object? isVerifying = null,
    Object? isVerified = null,
    Object? verificationError = null,
    Object? errorMessage = null,
    Object? fullName = null,
  }) {
    return _then(_value.copyWith(
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      isVerifying: null == isVerifying
          ? _value.isVerifying
          : isVerifying // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      verificationError: null == verificationError
          ? _value.verificationError
          : verificationError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountVerificationStateImplCopyWith<$Res>
    implements $AccountVerificationStateCopyWith<$Res> {
  factory _$$AccountVerificationStateImplCopyWith(
          _$AccountVerificationStateImpl value,
          $Res Function(_$AccountVerificationStateImpl) then) =
      __$$AccountVerificationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int accountId,
      bool isVerifying,
      bool isVerified,
      bool verificationError,
      String errorMessage,
      String fullName});
}

/// @nodoc
class __$$AccountVerificationStateImplCopyWithImpl<$Res>
    extends _$AccountVerificationStateCopyWithImpl<$Res,
        _$AccountVerificationStateImpl>
    implements _$$AccountVerificationStateImplCopyWith<$Res> {
  __$$AccountVerificationStateImplCopyWithImpl(
      _$AccountVerificationStateImpl _value,
      $Res Function(_$AccountVerificationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
    Object? isVerifying = null,
    Object? isVerified = null,
    Object? verificationError = null,
    Object? errorMessage = null,
    Object? fullName = null,
  }) {
    return _then(_$AccountVerificationStateImpl(
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      isVerifying: null == isVerifying
          ? _value.isVerifying
          : isVerifying // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      verificationError: null == verificationError
          ? _value.verificationError
          : verificationError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AccountVerificationStateImpl implements _AccountVerificationState {
  const _$AccountVerificationStateImpl(
      {required this.accountId,
      required this.isVerifying,
      required this.isVerified,
      required this.verificationError,
      required this.errorMessage,
      required this.fullName});

  @override
  final int accountId;
  @override
  final bool isVerifying;
  @override
  final bool isVerified;
  @override
  final bool verificationError;
  @override
  final String errorMessage;
  @override
  final String fullName;

  @override
  String toString() {
    return 'AccountVerificationState(accountId: $accountId, isVerifying: $isVerifying, isVerified: $isVerified, verificationError: $verificationError, errorMessage: $errorMessage, fullName: $fullName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountVerificationStateImpl &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.isVerifying, isVerifying) ||
                other.isVerifying == isVerifying) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.verificationError, verificationError) ||
                other.verificationError == verificationError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accountId, isVerifying,
      isVerified, verificationError, errorMessage, fullName);

  /// Create a copy of AccountVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountVerificationStateImplCopyWith<_$AccountVerificationStateImpl>
      get copyWith => __$$AccountVerificationStateImplCopyWithImpl<
          _$AccountVerificationStateImpl>(this, _$identity);
}

abstract class _AccountVerificationState implements AccountVerificationState {
  const factory _AccountVerificationState(
      {required final int accountId,
      required final bool isVerifying,
      required final bool isVerified,
      required final bool verificationError,
      required final String errorMessage,
      required final String fullName}) = _$AccountVerificationStateImpl;

  @override
  int get accountId;
  @override
  bool get isVerifying;
  @override
  bool get isVerified;
  @override
  bool get verificationError;
  @override
  String get errorMessage;
  @override
  String get fullName;

  /// Create a copy of AccountVerificationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountVerificationStateImplCopyWith<_$AccountVerificationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
