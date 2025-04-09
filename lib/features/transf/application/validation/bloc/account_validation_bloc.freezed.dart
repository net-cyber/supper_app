// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_validation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountValidationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int accountId, double amount)
        accountDetailsChanged,
    required TResult Function() validateAccountSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int accountId, double amount)? accountDetailsChanged,
    TResult? Function()? validateAccountSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int accountId, double amount)? accountDetailsChanged,
    TResult Function()? validateAccountSubmitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountDetailsChanged value)
        accountDetailsChanged,
    required TResult Function(ValidateAccountSubmitted value)
        validateAccountSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountDetailsChanged value)? accountDetailsChanged,
    TResult? Function(ValidateAccountSubmitted value)? validateAccountSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountDetailsChanged value)? accountDetailsChanged,
    TResult Function(ValidateAccountSubmitted value)? validateAccountSubmitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountValidationEventCopyWith<$Res> {
  factory $AccountValidationEventCopyWith(AccountValidationEvent value,
          $Res Function(AccountValidationEvent) then) =
      _$AccountValidationEventCopyWithImpl<$Res, AccountValidationEvent>;
}

/// @nodoc
class _$AccountValidationEventCopyWithImpl<$Res,
        $Val extends AccountValidationEvent>
    implements $AccountValidationEventCopyWith<$Res> {
  _$AccountValidationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountValidationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AccountDetailsChangedImplCopyWith<$Res> {
  factory _$$AccountDetailsChangedImplCopyWith(
          _$AccountDetailsChangedImpl value,
          $Res Function(_$AccountDetailsChangedImpl) then) =
      __$$AccountDetailsChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int accountId, double amount});
}

/// @nodoc
class __$$AccountDetailsChangedImplCopyWithImpl<$Res>
    extends _$AccountValidationEventCopyWithImpl<$Res,
        _$AccountDetailsChangedImpl>
    implements _$$AccountDetailsChangedImplCopyWith<$Res> {
  __$$AccountDetailsChangedImplCopyWithImpl(_$AccountDetailsChangedImpl _value,
      $Res Function(_$AccountDetailsChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountValidationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
    Object? amount = null,
  }) {
    return _then(_$AccountDetailsChangedImpl(
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$AccountDetailsChangedImpl implements AccountDetailsChanged {
  const _$AccountDetailsChangedImpl(
      {required this.accountId, required this.amount});

  @override
  final int accountId;
  @override
  final double amount;

  @override
  String toString() {
    return 'AccountValidationEvent.accountDetailsChanged(accountId: $accountId, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountDetailsChangedImpl &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accountId, amount);

  /// Create a copy of AccountValidationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountDetailsChangedImplCopyWith<_$AccountDetailsChangedImpl>
      get copyWith => __$$AccountDetailsChangedImplCopyWithImpl<
          _$AccountDetailsChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int accountId, double amount)
        accountDetailsChanged,
    required TResult Function() validateAccountSubmitted,
  }) {
    return accountDetailsChanged(accountId, amount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int accountId, double amount)? accountDetailsChanged,
    TResult? Function()? validateAccountSubmitted,
  }) {
    return accountDetailsChanged?.call(accountId, amount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int accountId, double amount)? accountDetailsChanged,
    TResult Function()? validateAccountSubmitted,
    required TResult orElse(),
  }) {
    if (accountDetailsChanged != null) {
      return accountDetailsChanged(accountId, amount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountDetailsChanged value)
        accountDetailsChanged,
    required TResult Function(ValidateAccountSubmitted value)
        validateAccountSubmitted,
  }) {
    return accountDetailsChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountDetailsChanged value)? accountDetailsChanged,
    TResult? Function(ValidateAccountSubmitted value)? validateAccountSubmitted,
  }) {
    return accountDetailsChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountDetailsChanged value)? accountDetailsChanged,
    TResult Function(ValidateAccountSubmitted value)? validateAccountSubmitted,
    required TResult orElse(),
  }) {
    if (accountDetailsChanged != null) {
      return accountDetailsChanged(this);
    }
    return orElse();
  }
}

abstract class AccountDetailsChanged implements AccountValidationEvent {
  const factory AccountDetailsChanged(
      {required final int accountId,
      required final double amount}) = _$AccountDetailsChangedImpl;

  int get accountId;
  double get amount;

  /// Create a copy of AccountValidationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountDetailsChangedImplCopyWith<_$AccountDetailsChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidateAccountSubmittedImplCopyWith<$Res> {
  factory _$$ValidateAccountSubmittedImplCopyWith(
          _$ValidateAccountSubmittedImpl value,
          $Res Function(_$ValidateAccountSubmittedImpl) then) =
      __$$ValidateAccountSubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ValidateAccountSubmittedImplCopyWithImpl<$Res>
    extends _$AccountValidationEventCopyWithImpl<$Res,
        _$ValidateAccountSubmittedImpl>
    implements _$$ValidateAccountSubmittedImplCopyWith<$Res> {
  __$$ValidateAccountSubmittedImplCopyWithImpl(
      _$ValidateAccountSubmittedImpl _value,
      $Res Function(_$ValidateAccountSubmittedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountValidationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ValidateAccountSubmittedImpl implements ValidateAccountSubmitted {
  const _$ValidateAccountSubmittedImpl();

  @override
  String toString() {
    return 'AccountValidationEvent.validateAccountSubmitted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidateAccountSubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int accountId, double amount)
        accountDetailsChanged,
    required TResult Function() validateAccountSubmitted,
  }) {
    return validateAccountSubmitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int accountId, double amount)? accountDetailsChanged,
    TResult? Function()? validateAccountSubmitted,
  }) {
    return validateAccountSubmitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int accountId, double amount)? accountDetailsChanged,
    TResult Function()? validateAccountSubmitted,
    required TResult orElse(),
  }) {
    if (validateAccountSubmitted != null) {
      return validateAccountSubmitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountDetailsChanged value)
        accountDetailsChanged,
    required TResult Function(ValidateAccountSubmitted value)
        validateAccountSubmitted,
  }) {
    return validateAccountSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountDetailsChanged value)? accountDetailsChanged,
    TResult? Function(ValidateAccountSubmitted value)? validateAccountSubmitted,
  }) {
    return validateAccountSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountDetailsChanged value)? accountDetailsChanged,
    TResult Function(ValidateAccountSubmitted value)? validateAccountSubmitted,
    required TResult orElse(),
  }) {
    if (validateAccountSubmitted != null) {
      return validateAccountSubmitted(this);
    }
    return orElse();
  }
}

abstract class ValidateAccountSubmitted implements AccountValidationEvent {
  const factory ValidateAccountSubmitted() = _$ValidateAccountSubmittedImpl;
}

/// @nodoc
mixin _$AccountValidationState {
  int get accountId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  bool get isValidating => throw _privateConstructorUsedError;
  bool get isValidated => throw _privateConstructorUsedError;
  bool get isSufficient => throw _privateConstructorUsedError;
  bool get validationError => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Create a copy of AccountValidationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountValidationStateCopyWith<AccountValidationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountValidationStateCopyWith<$Res> {
  factory $AccountValidationStateCopyWith(AccountValidationState value,
          $Res Function(AccountValidationState) then) =
      _$AccountValidationStateCopyWithImpl<$Res, AccountValidationState>;
  @useResult
  $Res call(
      {int accountId,
      double amount,
      bool isValidating,
      bool isValidated,
      bool isSufficient,
      bool validationError,
      String errorMessage,
      String message});
}

/// @nodoc
class _$AccountValidationStateCopyWithImpl<$Res,
        $Val extends AccountValidationState>
    implements $AccountValidationStateCopyWith<$Res> {
  _$AccountValidationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountValidationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
    Object? amount = null,
    Object? isValidating = null,
    Object? isValidated = null,
    Object? isSufficient = null,
    Object? validationError = null,
    Object? errorMessage = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      isValidating: null == isValidating
          ? _value.isValidating
          : isValidating // ignore: cast_nullable_to_non_nullable
              as bool,
      isValidated: null == isValidated
          ? _value.isValidated
          : isValidated // ignore: cast_nullable_to_non_nullable
              as bool,
      isSufficient: null == isSufficient
          ? _value.isSufficient
          : isSufficient // ignore: cast_nullable_to_non_nullable
              as bool,
      validationError: null == validationError
          ? _value.validationError
          : validationError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountValidationStateImplCopyWith<$Res>
    implements $AccountValidationStateCopyWith<$Res> {
  factory _$$AccountValidationStateImplCopyWith(
          _$AccountValidationStateImpl value,
          $Res Function(_$AccountValidationStateImpl) then) =
      __$$AccountValidationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int accountId,
      double amount,
      bool isValidating,
      bool isValidated,
      bool isSufficient,
      bool validationError,
      String errorMessage,
      String message});
}

/// @nodoc
class __$$AccountValidationStateImplCopyWithImpl<$Res>
    extends _$AccountValidationStateCopyWithImpl<$Res,
        _$AccountValidationStateImpl>
    implements _$$AccountValidationStateImplCopyWith<$Res> {
  __$$AccountValidationStateImplCopyWithImpl(
      _$AccountValidationStateImpl _value,
      $Res Function(_$AccountValidationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountValidationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
    Object? amount = null,
    Object? isValidating = null,
    Object? isValidated = null,
    Object? isSufficient = null,
    Object? validationError = null,
    Object? errorMessage = null,
    Object? message = null,
  }) {
    return _then(_$AccountValidationStateImpl(
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      isValidating: null == isValidating
          ? _value.isValidating
          : isValidating // ignore: cast_nullable_to_non_nullable
              as bool,
      isValidated: null == isValidated
          ? _value.isValidated
          : isValidated // ignore: cast_nullable_to_non_nullable
              as bool,
      isSufficient: null == isSufficient
          ? _value.isSufficient
          : isSufficient // ignore: cast_nullable_to_non_nullable
              as bool,
      validationError: null == validationError
          ? _value.validationError
          : validationError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AccountValidationStateImpl implements _AccountValidationState {
  const _$AccountValidationStateImpl(
      {required this.accountId,
      required this.amount,
      required this.isValidating,
      required this.isValidated,
      required this.isSufficient,
      required this.validationError,
      required this.errorMessage,
      required this.message});

  @override
  final int accountId;
  @override
  final double amount;
  @override
  final bool isValidating;
  @override
  final bool isValidated;
  @override
  final bool isSufficient;
  @override
  final bool validationError;
  @override
  final String errorMessage;
  @override
  final String message;

  @override
  String toString() {
    return 'AccountValidationState(accountId: $accountId, amount: $amount, isValidating: $isValidating, isValidated: $isValidated, isSufficient: $isSufficient, validationError: $validationError, errorMessage: $errorMessage, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountValidationStateImpl &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.isValidating, isValidating) ||
                other.isValidating == isValidating) &&
            (identical(other.isValidated, isValidated) ||
                other.isValidated == isValidated) &&
            (identical(other.isSufficient, isSufficient) ||
                other.isSufficient == isSufficient) &&
            (identical(other.validationError, validationError) ||
                other.validationError == validationError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accountId, amount, isValidating,
      isValidated, isSufficient, validationError, errorMessage, message);

  /// Create a copy of AccountValidationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountValidationStateImplCopyWith<_$AccountValidationStateImpl>
      get copyWith => __$$AccountValidationStateImplCopyWithImpl<
          _$AccountValidationStateImpl>(this, _$identity);
}

abstract class _AccountValidationState implements AccountValidationState {
  const factory _AccountValidationState(
      {required final int accountId,
      required final double amount,
      required final bool isValidating,
      required final bool isValidated,
      required final bool isSufficient,
      required final bool validationError,
      required final String errorMessage,
      required final String message}) = _$AccountValidationStateImpl;

  @override
  int get accountId;
  @override
  double get amount;
  @override
  bool get isValidating;
  @override
  bool get isValidated;
  @override
  bool get isSufficient;
  @override
  bool get validationError;
  @override
  String get errorMessage;
  @override
  String get message;

  /// Create a copy of AccountValidationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountValidationStateImplCopyWith<_$AccountValidationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
