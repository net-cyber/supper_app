// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bank_account_validation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BankAccountValidationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String bankCode, String accountNumber)
        validateBankAccount,
    required TResult Function() resetBankAccountValidation,
    required TResult Function(String message) setBankAccountValidationError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String bankCode, String accountNumber)?
        validateBankAccount,
    TResult? Function()? resetBankAccountValidation,
    TResult? Function(String message)? setBankAccountValidationError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String bankCode, String accountNumber)?
        validateBankAccount,
    TResult Function()? resetBankAccountValidation,
    TResult Function(String message)? setBankAccountValidationError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidateBankAccount value) validateBankAccount,
    required TResult Function(ResetBankAccountValidation value)
        resetBankAccountValidation,
    required TResult Function(SetBankAccountValidationError value)
        setBankAccountValidationError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidateBankAccount value)? validateBankAccount,
    TResult? Function(ResetBankAccountValidation value)?
        resetBankAccountValidation,
    TResult? Function(SetBankAccountValidationError value)?
        setBankAccountValidationError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidateBankAccount value)? validateBankAccount,
    TResult Function(ResetBankAccountValidation value)?
        resetBankAccountValidation,
    TResult Function(SetBankAccountValidationError value)?
        setBankAccountValidationError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankAccountValidationEventCopyWith<$Res> {
  factory $BankAccountValidationEventCopyWith(BankAccountValidationEvent value,
          $Res Function(BankAccountValidationEvent) then) =
      _$BankAccountValidationEventCopyWithImpl<$Res,
          BankAccountValidationEvent>;
}

/// @nodoc
class _$BankAccountValidationEventCopyWithImpl<$Res,
        $Val extends BankAccountValidationEvent>
    implements $BankAccountValidationEventCopyWith<$Res> {
  _$BankAccountValidationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BankAccountValidationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ValidateBankAccountImplCopyWith<$Res> {
  factory _$$ValidateBankAccountImplCopyWith(_$ValidateBankAccountImpl value,
          $Res Function(_$ValidateBankAccountImpl) then) =
      __$$ValidateBankAccountImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String bankCode, String accountNumber});
}

/// @nodoc
class __$$ValidateBankAccountImplCopyWithImpl<$Res>
    extends _$BankAccountValidationEventCopyWithImpl<$Res,
        _$ValidateBankAccountImpl>
    implements _$$ValidateBankAccountImplCopyWith<$Res> {
  __$$ValidateBankAccountImplCopyWithImpl(_$ValidateBankAccountImpl _value,
      $Res Function(_$ValidateBankAccountImpl) _then)
      : super(_value, _then);

  /// Create a copy of BankAccountValidationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankCode = null,
    Object? accountNumber = null,
  }) {
    return _then(_$ValidateBankAccountImpl(
      bankCode: null == bankCode
          ? _value.bankCode
          : bankCode // ignore: cast_nullable_to_non_nullable
              as String,
      accountNumber: null == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ValidateBankAccountImpl implements ValidateBankAccount {
  const _$ValidateBankAccountImpl(
      {required this.bankCode, required this.accountNumber});

  @override
  final String bankCode;
  @override
  final String accountNumber;

  @override
  String toString() {
    return 'BankAccountValidationEvent.validateBankAccount(bankCode: $bankCode, accountNumber: $accountNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidateBankAccountImpl &&
            (identical(other.bankCode, bankCode) ||
                other.bankCode == bankCode) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bankCode, accountNumber);

  /// Create a copy of BankAccountValidationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidateBankAccountImplCopyWith<_$ValidateBankAccountImpl> get copyWith =>
      __$$ValidateBankAccountImplCopyWithImpl<_$ValidateBankAccountImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String bankCode, String accountNumber)
        validateBankAccount,
    required TResult Function() resetBankAccountValidation,
    required TResult Function(String message) setBankAccountValidationError,
  }) {
    return validateBankAccount(bankCode, accountNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String bankCode, String accountNumber)?
        validateBankAccount,
    TResult? Function()? resetBankAccountValidation,
    TResult? Function(String message)? setBankAccountValidationError,
  }) {
    return validateBankAccount?.call(bankCode, accountNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String bankCode, String accountNumber)?
        validateBankAccount,
    TResult Function()? resetBankAccountValidation,
    TResult Function(String message)? setBankAccountValidationError,
    required TResult orElse(),
  }) {
    if (validateBankAccount != null) {
      return validateBankAccount(bankCode, accountNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidateBankAccount value) validateBankAccount,
    required TResult Function(ResetBankAccountValidation value)
        resetBankAccountValidation,
    required TResult Function(SetBankAccountValidationError value)
        setBankAccountValidationError,
  }) {
    return validateBankAccount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidateBankAccount value)? validateBankAccount,
    TResult? Function(ResetBankAccountValidation value)?
        resetBankAccountValidation,
    TResult? Function(SetBankAccountValidationError value)?
        setBankAccountValidationError,
  }) {
    return validateBankAccount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidateBankAccount value)? validateBankAccount,
    TResult Function(ResetBankAccountValidation value)?
        resetBankAccountValidation,
    TResult Function(SetBankAccountValidationError value)?
        setBankAccountValidationError,
    required TResult orElse(),
  }) {
    if (validateBankAccount != null) {
      return validateBankAccount(this);
    }
    return orElse();
  }
}

abstract class ValidateBankAccount implements BankAccountValidationEvent {
  const factory ValidateBankAccount(
      {required final String bankCode,
      required final String accountNumber}) = _$ValidateBankAccountImpl;

  String get bankCode;
  String get accountNumber;

  /// Create a copy of BankAccountValidationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidateBankAccountImplCopyWith<_$ValidateBankAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetBankAccountValidationImplCopyWith<$Res> {
  factory _$$ResetBankAccountValidationImplCopyWith(
          _$ResetBankAccountValidationImpl value,
          $Res Function(_$ResetBankAccountValidationImpl) then) =
      __$$ResetBankAccountValidationImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetBankAccountValidationImplCopyWithImpl<$Res>
    extends _$BankAccountValidationEventCopyWithImpl<$Res,
        _$ResetBankAccountValidationImpl>
    implements _$$ResetBankAccountValidationImplCopyWith<$Res> {
  __$$ResetBankAccountValidationImplCopyWithImpl(
      _$ResetBankAccountValidationImpl _value,
      $Res Function(_$ResetBankAccountValidationImpl) _then)
      : super(_value, _then);

  /// Create a copy of BankAccountValidationEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetBankAccountValidationImpl implements ResetBankAccountValidation {
  const _$ResetBankAccountValidationImpl();

  @override
  String toString() {
    return 'BankAccountValidationEvent.resetBankAccountValidation()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetBankAccountValidationImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String bankCode, String accountNumber)
        validateBankAccount,
    required TResult Function() resetBankAccountValidation,
    required TResult Function(String message) setBankAccountValidationError,
  }) {
    return resetBankAccountValidation();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String bankCode, String accountNumber)?
        validateBankAccount,
    TResult? Function()? resetBankAccountValidation,
    TResult? Function(String message)? setBankAccountValidationError,
  }) {
    return resetBankAccountValidation?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String bankCode, String accountNumber)?
        validateBankAccount,
    TResult Function()? resetBankAccountValidation,
    TResult Function(String message)? setBankAccountValidationError,
    required TResult orElse(),
  }) {
    if (resetBankAccountValidation != null) {
      return resetBankAccountValidation();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidateBankAccount value) validateBankAccount,
    required TResult Function(ResetBankAccountValidation value)
        resetBankAccountValidation,
    required TResult Function(SetBankAccountValidationError value)
        setBankAccountValidationError,
  }) {
    return resetBankAccountValidation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidateBankAccount value)? validateBankAccount,
    TResult? Function(ResetBankAccountValidation value)?
        resetBankAccountValidation,
    TResult? Function(SetBankAccountValidationError value)?
        setBankAccountValidationError,
  }) {
    return resetBankAccountValidation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidateBankAccount value)? validateBankAccount,
    TResult Function(ResetBankAccountValidation value)?
        resetBankAccountValidation,
    TResult Function(SetBankAccountValidationError value)?
        setBankAccountValidationError,
    required TResult orElse(),
  }) {
    if (resetBankAccountValidation != null) {
      return resetBankAccountValidation(this);
    }
    return orElse();
  }
}

abstract class ResetBankAccountValidation
    implements BankAccountValidationEvent {
  const factory ResetBankAccountValidation() = _$ResetBankAccountValidationImpl;
}

/// @nodoc
abstract class _$$SetBankAccountValidationErrorImplCopyWith<$Res> {
  factory _$$SetBankAccountValidationErrorImplCopyWith(
          _$SetBankAccountValidationErrorImpl value,
          $Res Function(_$SetBankAccountValidationErrorImpl) then) =
      __$$SetBankAccountValidationErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SetBankAccountValidationErrorImplCopyWithImpl<$Res>
    extends _$BankAccountValidationEventCopyWithImpl<$Res,
        _$SetBankAccountValidationErrorImpl>
    implements _$$SetBankAccountValidationErrorImplCopyWith<$Res> {
  __$$SetBankAccountValidationErrorImplCopyWithImpl(
      _$SetBankAccountValidationErrorImpl _value,
      $Res Function(_$SetBankAccountValidationErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of BankAccountValidationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$SetBankAccountValidationErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SetBankAccountValidationErrorImpl
    implements SetBankAccountValidationError {
  const _$SetBankAccountValidationErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'BankAccountValidationEvent.setBankAccountValidationError(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetBankAccountValidationErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of BankAccountValidationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetBankAccountValidationErrorImplCopyWith<
          _$SetBankAccountValidationErrorImpl>
      get copyWith => __$$SetBankAccountValidationErrorImplCopyWithImpl<
          _$SetBankAccountValidationErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String bankCode, String accountNumber)
        validateBankAccount,
    required TResult Function() resetBankAccountValidation,
    required TResult Function(String message) setBankAccountValidationError,
  }) {
    return setBankAccountValidationError(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String bankCode, String accountNumber)?
        validateBankAccount,
    TResult? Function()? resetBankAccountValidation,
    TResult? Function(String message)? setBankAccountValidationError,
  }) {
    return setBankAccountValidationError?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String bankCode, String accountNumber)?
        validateBankAccount,
    TResult Function()? resetBankAccountValidation,
    TResult Function(String message)? setBankAccountValidationError,
    required TResult orElse(),
  }) {
    if (setBankAccountValidationError != null) {
      return setBankAccountValidationError(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidateBankAccount value) validateBankAccount,
    required TResult Function(ResetBankAccountValidation value)
        resetBankAccountValidation,
    required TResult Function(SetBankAccountValidationError value)
        setBankAccountValidationError,
  }) {
    return setBankAccountValidationError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidateBankAccount value)? validateBankAccount,
    TResult? Function(ResetBankAccountValidation value)?
        resetBankAccountValidation,
    TResult? Function(SetBankAccountValidationError value)?
        setBankAccountValidationError,
  }) {
    return setBankAccountValidationError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidateBankAccount value)? validateBankAccount,
    TResult Function(ResetBankAccountValidation value)?
        resetBankAccountValidation,
    TResult Function(SetBankAccountValidationError value)?
        setBankAccountValidationError,
    required TResult orElse(),
  }) {
    if (setBankAccountValidationError != null) {
      return setBankAccountValidationError(this);
    }
    return orElse();
  }
}

abstract class SetBankAccountValidationError
    implements BankAccountValidationEvent {
  const factory SetBankAccountValidationError({required final String message}) =
      _$SetBankAccountValidationErrorImpl;

  String get message;

  /// Create a copy of BankAccountValidationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetBankAccountValidationErrorImplCopyWith<
          _$SetBankAccountValidationErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BankAccountValidationState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;
  BankAccountValidation? get validationResult =>
      throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of BankAccountValidationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BankAccountValidationStateCopyWith<BankAccountValidationState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankAccountValidationStateCopyWith<$Res> {
  factory $BankAccountValidationStateCopyWith(BankAccountValidationState value,
          $Res Function(BankAccountValidationState) then) =
      _$BankAccountValidationStateCopyWithImpl<$Res,
          BankAccountValidationState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isValid,
      BankAccountValidation? validationResult,
      bool hasError,
      String errorMessage});

  $BankAccountValidationCopyWith<$Res>? get validationResult;
}

/// @nodoc
class _$BankAccountValidationStateCopyWithImpl<$Res,
        $Val extends BankAccountValidationState>
    implements $BankAccountValidationStateCopyWith<$Res> {
  _$BankAccountValidationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BankAccountValidationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isValid = null,
    Object? validationResult = freezed,
    Object? hasError = null,
    Object? errorMessage = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      validationResult: freezed == validationResult
          ? _value.validationResult
          : validationResult // ignore: cast_nullable_to_non_nullable
              as BankAccountValidation?,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of BankAccountValidationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BankAccountValidationCopyWith<$Res>? get validationResult {
    if (_value.validationResult == null) {
      return null;
    }

    return $BankAccountValidationCopyWith<$Res>(_value.validationResult!,
        (value) {
      return _then(_value.copyWith(validationResult: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BankAccountValidationStateImplCopyWith<$Res>
    implements $BankAccountValidationStateCopyWith<$Res> {
  factory _$$BankAccountValidationStateImplCopyWith(
          _$BankAccountValidationStateImpl value,
          $Res Function(_$BankAccountValidationStateImpl) then) =
      __$$BankAccountValidationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isValid,
      BankAccountValidation? validationResult,
      bool hasError,
      String errorMessage});

  @override
  $BankAccountValidationCopyWith<$Res>? get validationResult;
}

/// @nodoc
class __$$BankAccountValidationStateImplCopyWithImpl<$Res>
    extends _$BankAccountValidationStateCopyWithImpl<$Res,
        _$BankAccountValidationStateImpl>
    implements _$$BankAccountValidationStateImplCopyWith<$Res> {
  __$$BankAccountValidationStateImplCopyWithImpl(
      _$BankAccountValidationStateImpl _value,
      $Res Function(_$BankAccountValidationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BankAccountValidationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isValid = null,
    Object? validationResult = freezed,
    Object? hasError = null,
    Object? errorMessage = null,
  }) {
    return _then(_$BankAccountValidationStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      validationResult: freezed == validationResult
          ? _value.validationResult
          : validationResult // ignore: cast_nullable_to_non_nullable
              as BankAccountValidation?,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BankAccountValidationStateImpl implements _BankAccountValidationState {
  const _$BankAccountValidationStateImpl(
      {required this.isLoading,
      required this.isValid,
      this.validationResult,
      required this.hasError,
      required this.errorMessage});

  @override
  final bool isLoading;
  @override
  final bool isValid;
  @override
  final BankAccountValidation? validationResult;
  @override
  final bool hasError;
  @override
  final String errorMessage;

  @override
  String toString() {
    return 'BankAccountValidationState(isLoading: $isLoading, isValid: $isValid, validationResult: $validationResult, hasError: $hasError, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BankAccountValidationStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            (identical(other.validationResult, validationResult) ||
                other.validationResult == validationResult) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, isValid,
      validationResult, hasError, errorMessage);

  /// Create a copy of BankAccountValidationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BankAccountValidationStateImplCopyWith<_$BankAccountValidationStateImpl>
      get copyWith => __$$BankAccountValidationStateImplCopyWithImpl<
          _$BankAccountValidationStateImpl>(this, _$identity);
}

abstract class _BankAccountValidationState
    implements BankAccountValidationState {
  const factory _BankAccountValidationState(
      {required final bool isLoading,
      required final bool isValid,
      final BankAccountValidation? validationResult,
      required final bool hasError,
      required final String errorMessage}) = _$BankAccountValidationStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isValid;
  @override
  BankAccountValidation? get validationResult;
  @override
  bool get hasError;
  @override
  String get errorMessage;

  /// Create a copy of BankAccountValidationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BankAccountValidationStateImplCopyWith<_$BankAccountValidationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
