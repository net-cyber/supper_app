// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'internal_transfer_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InternalTransferEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String accountNumber) accountNumberChanged,
    required TResult Function() validateAccount,
    required TResult Function(String amount) amountChanged,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() submitTransfer,
    required TResult Function() reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function()? validateAccount,
    TResult? Function(String amount)? amountChanged,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? submitTransfer,
    TResult? Function()? reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function()? validateAccount,
    TResult Function(String amount)? amountChanged,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? submitTransfer,
    TResult Function()? reset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(ValidateAccount value) validateAccount,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(Reset value) reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(ValidateAccount value)? validateAccount,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(Reset value)? reset,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(ValidateAccount value)? validateAccount,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InternalTransferEventCopyWith<$Res> {
  factory $InternalTransferEventCopyWith(InternalTransferEvent value,
          $Res Function(InternalTransferEvent) then) =
      _$InternalTransferEventCopyWithImpl<$Res, InternalTransferEvent>;
}

/// @nodoc
class _$InternalTransferEventCopyWithImpl<$Res,
        $Val extends InternalTransferEvent>
    implements $InternalTransferEventCopyWith<$Res> {
  _$InternalTransferEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AccountNumberChangedImplCopyWith<$Res> {
  factory _$$AccountNumberChangedImplCopyWith(_$AccountNumberChangedImpl value,
          $Res Function(_$AccountNumberChangedImpl) then) =
      __$$AccountNumberChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String accountNumber});
}

/// @nodoc
class __$$AccountNumberChangedImplCopyWithImpl<$Res>
    extends _$InternalTransferEventCopyWithImpl<$Res,
        _$AccountNumberChangedImpl>
    implements _$$AccountNumberChangedImplCopyWith<$Res> {
  __$$AccountNumberChangedImplCopyWithImpl(_$AccountNumberChangedImpl _value,
      $Res Function(_$AccountNumberChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of InternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountNumber = null,
  }) {
    return _then(_$AccountNumberChangedImpl(
      null == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AccountNumberChangedImpl extends AccountNumberChanged {
  const _$AccountNumberChangedImpl(this.accountNumber) : super._();

  @override
  final String accountNumber;

  @override
  String toString() {
    return 'InternalTransferEvent.accountNumberChanged(accountNumber: $accountNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountNumberChangedImpl &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accountNumber);

  /// Create a copy of InternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountNumberChangedImplCopyWith<_$AccountNumberChangedImpl>
      get copyWith =>
          __$$AccountNumberChangedImplCopyWithImpl<_$AccountNumberChangedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String accountNumber) accountNumberChanged,
    required TResult Function() validateAccount,
    required TResult Function(String amount) amountChanged,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() submitTransfer,
    required TResult Function() reset,
  }) {
    return accountNumberChanged(accountNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function()? validateAccount,
    TResult? Function(String amount)? amountChanged,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? submitTransfer,
    TResult? Function()? reset,
  }) {
    return accountNumberChanged?.call(accountNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function()? validateAccount,
    TResult Function(String amount)? amountChanged,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? submitTransfer,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (accountNumberChanged != null) {
      return accountNumberChanged(accountNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(ValidateAccount value) validateAccount,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(Reset value) reset,
  }) {
    return accountNumberChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(ValidateAccount value)? validateAccount,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(Reset value)? reset,
  }) {
    return accountNumberChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(ValidateAccount value)? validateAccount,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (accountNumberChanged != null) {
      return accountNumberChanged(this);
    }
    return orElse();
  }
}

abstract class AccountNumberChanged extends InternalTransferEvent {
  const factory AccountNumberChanged(final String accountNumber) =
      _$AccountNumberChangedImpl;
  const AccountNumberChanged._() : super._();

  String get accountNumber;

  /// Create a copy of InternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountNumberChangedImplCopyWith<_$AccountNumberChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidateAccountImplCopyWith<$Res> {
  factory _$$ValidateAccountImplCopyWith(_$ValidateAccountImpl value,
          $Res Function(_$ValidateAccountImpl) then) =
      __$$ValidateAccountImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ValidateAccountImplCopyWithImpl<$Res>
    extends _$InternalTransferEventCopyWithImpl<$Res, _$ValidateAccountImpl>
    implements _$$ValidateAccountImplCopyWith<$Res> {
  __$$ValidateAccountImplCopyWithImpl(
      _$ValidateAccountImpl _value, $Res Function(_$ValidateAccountImpl) _then)
      : super(_value, _then);

  /// Create a copy of InternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ValidateAccountImpl extends ValidateAccount {
  const _$ValidateAccountImpl() : super._();

  @override
  String toString() {
    return 'InternalTransferEvent.validateAccount()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ValidateAccountImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String accountNumber) accountNumberChanged,
    required TResult Function() validateAccount,
    required TResult Function(String amount) amountChanged,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() submitTransfer,
    required TResult Function() reset,
  }) {
    return validateAccount();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function()? validateAccount,
    TResult? Function(String amount)? amountChanged,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? submitTransfer,
    TResult? Function()? reset,
  }) {
    return validateAccount?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function()? validateAccount,
    TResult Function(String amount)? amountChanged,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? submitTransfer,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (validateAccount != null) {
      return validateAccount();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(ValidateAccount value) validateAccount,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(Reset value) reset,
  }) {
    return validateAccount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(ValidateAccount value)? validateAccount,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(Reset value)? reset,
  }) {
    return validateAccount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(ValidateAccount value)? validateAccount,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (validateAccount != null) {
      return validateAccount(this);
    }
    return orElse();
  }
}

abstract class ValidateAccount extends InternalTransferEvent {
  const factory ValidateAccount() = _$ValidateAccountImpl;
  const ValidateAccount._() : super._();
}

/// @nodoc
abstract class _$$AmountChangedImplCopyWith<$Res> {
  factory _$$AmountChangedImplCopyWith(
          _$AmountChangedImpl value, $Res Function(_$AmountChangedImpl) then) =
      __$$AmountChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String amount});
}

/// @nodoc
class __$$AmountChangedImplCopyWithImpl<$Res>
    extends _$InternalTransferEventCopyWithImpl<$Res, _$AmountChangedImpl>
    implements _$$AmountChangedImplCopyWith<$Res> {
  __$$AmountChangedImplCopyWithImpl(
      _$AmountChangedImpl _value, $Res Function(_$AmountChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of InternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
  }) {
    return _then(_$AmountChangedImpl(
      null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AmountChangedImpl extends AmountChanged {
  const _$AmountChangedImpl(this.amount) : super._();

  @override
  final String amount;

  @override
  String toString() {
    return 'InternalTransferEvent.amountChanged(amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmountChangedImpl &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount);

  /// Create a copy of InternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AmountChangedImplCopyWith<_$AmountChangedImpl> get copyWith =>
      __$$AmountChangedImplCopyWithImpl<_$AmountChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String accountNumber) accountNumberChanged,
    required TResult Function() validateAccount,
    required TResult Function(String amount) amountChanged,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() submitTransfer,
    required TResult Function() reset,
  }) {
    return amountChanged(amount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function()? validateAccount,
    TResult? Function(String amount)? amountChanged,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? submitTransfer,
    TResult? Function()? reset,
  }) {
    return amountChanged?.call(amount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function()? validateAccount,
    TResult Function(String amount)? amountChanged,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? submitTransfer,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (amountChanged != null) {
      return amountChanged(amount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(ValidateAccount value) validateAccount,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(Reset value) reset,
  }) {
    return amountChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(ValidateAccount value)? validateAccount,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(Reset value)? reset,
  }) {
    return amountChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(ValidateAccount value)? validateAccount,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (amountChanged != null) {
      return amountChanged(this);
    }
    return orElse();
  }
}

abstract class AmountChanged extends InternalTransferEvent {
  const factory AmountChanged(final String amount) = _$AmountChangedImpl;
  const AmountChanged._() : super._();

  String get amount;

  /// Create a copy of InternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AmountChangedImplCopyWith<_$AmountChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReasonChangedImplCopyWith<$Res> {
  factory _$$ReasonChangedImplCopyWith(
          _$ReasonChangedImpl value, $Res Function(_$ReasonChangedImpl) then) =
      __$$ReasonChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String reason});
}

/// @nodoc
class __$$ReasonChangedImplCopyWithImpl<$Res>
    extends _$InternalTransferEventCopyWithImpl<$Res, _$ReasonChangedImpl>
    implements _$$ReasonChangedImplCopyWith<$Res> {
  __$$ReasonChangedImplCopyWithImpl(
      _$ReasonChangedImpl _value, $Res Function(_$ReasonChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of InternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
  }) {
    return _then(_$ReasonChangedImpl(
      null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ReasonChangedImpl extends ReasonChanged {
  const _$ReasonChangedImpl(this.reason) : super._();

  @override
  final String reason;

  @override
  String toString() {
    return 'InternalTransferEvent.reasonChanged(reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReasonChangedImpl &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reason);

  /// Create a copy of InternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReasonChangedImplCopyWith<_$ReasonChangedImpl> get copyWith =>
      __$$ReasonChangedImplCopyWithImpl<_$ReasonChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String accountNumber) accountNumberChanged,
    required TResult Function() validateAccount,
    required TResult Function(String amount) amountChanged,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() submitTransfer,
    required TResult Function() reset,
  }) {
    return reasonChanged(reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function()? validateAccount,
    TResult? Function(String amount)? amountChanged,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? submitTransfer,
    TResult? Function()? reset,
  }) {
    return reasonChanged?.call(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function()? validateAccount,
    TResult Function(String amount)? amountChanged,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? submitTransfer,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (reasonChanged != null) {
      return reasonChanged(reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(ValidateAccount value) validateAccount,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(Reset value) reset,
  }) {
    return reasonChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(ValidateAccount value)? validateAccount,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(Reset value)? reset,
  }) {
    return reasonChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(ValidateAccount value)? validateAccount,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (reasonChanged != null) {
      return reasonChanged(this);
    }
    return orElse();
  }
}

abstract class ReasonChanged extends InternalTransferEvent {
  const factory ReasonChanged(final String reason) = _$ReasonChangedImpl;
  const ReasonChanged._() : super._();

  String get reason;

  /// Create a copy of InternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReasonChangedImplCopyWith<_$ReasonChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmitTransferImplCopyWith<$Res> {
  factory _$$SubmitTransferImplCopyWith(_$SubmitTransferImpl value,
          $Res Function(_$SubmitTransferImpl) then) =
      __$$SubmitTransferImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmitTransferImplCopyWithImpl<$Res>
    extends _$InternalTransferEventCopyWithImpl<$Res, _$SubmitTransferImpl>
    implements _$$SubmitTransferImplCopyWith<$Res> {
  __$$SubmitTransferImplCopyWithImpl(
      _$SubmitTransferImpl _value, $Res Function(_$SubmitTransferImpl) _then)
      : super(_value, _then);

  /// Create a copy of InternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SubmitTransferImpl extends SubmitTransfer {
  const _$SubmitTransferImpl() : super._();

  @override
  String toString() {
    return 'InternalTransferEvent.submitTransfer()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SubmitTransferImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String accountNumber) accountNumberChanged,
    required TResult Function() validateAccount,
    required TResult Function(String amount) amountChanged,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() submitTransfer,
    required TResult Function() reset,
  }) {
    return submitTransfer();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function()? validateAccount,
    TResult? Function(String amount)? amountChanged,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? submitTransfer,
    TResult? Function()? reset,
  }) {
    return submitTransfer?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function()? validateAccount,
    TResult Function(String amount)? amountChanged,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? submitTransfer,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (submitTransfer != null) {
      return submitTransfer();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(ValidateAccount value) validateAccount,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(Reset value) reset,
  }) {
    return submitTransfer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(ValidateAccount value)? validateAccount,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(Reset value)? reset,
  }) {
    return submitTransfer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(ValidateAccount value)? validateAccount,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (submitTransfer != null) {
      return submitTransfer(this);
    }
    return orElse();
  }
}

abstract class SubmitTransfer extends InternalTransferEvent {
  const factory SubmitTransfer() = _$SubmitTransferImpl;
  const SubmitTransfer._() : super._();
}

/// @nodoc
abstract class _$$ResetImplCopyWith<$Res> {
  factory _$$ResetImplCopyWith(
          _$ResetImpl value, $Res Function(_$ResetImpl) then) =
      __$$ResetImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetImplCopyWithImpl<$Res>
    extends _$InternalTransferEventCopyWithImpl<$Res, _$ResetImpl>
    implements _$$ResetImplCopyWith<$Res> {
  __$$ResetImplCopyWithImpl(
      _$ResetImpl _value, $Res Function(_$ResetImpl) _then)
      : super(_value, _then);

  /// Create a copy of InternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetImpl extends Reset {
  const _$ResetImpl() : super._();

  @override
  String toString() {
    return 'InternalTransferEvent.reset()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String accountNumber) accountNumberChanged,
    required TResult Function() validateAccount,
    required TResult Function(String amount) amountChanged,
    required TResult Function(String reason) reasonChanged,
    required TResult Function() submitTransfer,
    required TResult Function() reset,
  }) {
    return reset();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function()? validateAccount,
    TResult? Function(String amount)? amountChanged,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function()? submitTransfer,
    TResult? Function()? reset,
  }) {
    return reset?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function()? validateAccount,
    TResult Function(String amount)? amountChanged,
    TResult Function(String reason)? reasonChanged,
    TResult Function()? submitTransfer,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(ValidateAccount value) validateAccount,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(Reset value) reset,
  }) {
    return reset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(ValidateAccount value)? validateAccount,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(Reset value)? reset,
  }) {
    return reset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(ValidateAccount value)? validateAccount,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(Reset value)? reset,
    required TResult orElse(),
  }) {
    if (reset != null) {
      return reset(this);
    }
    return orElse();
  }
}

abstract class Reset extends InternalTransferEvent {
  const factory Reset() = _$ResetImpl;
  const Reset._() : super._();
}
