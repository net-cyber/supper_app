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
    required TResult Function(String accountNumber) verifyAccount,
    required TResult Function(String amount) amountChanged,
    required TResult Function(String reason) reasonChanged,
    required TResult Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)
        submitTransfer,
    required TResult Function() resetState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function(String accountNumber)? verifyAccount,
    TResult? Function(String amount)? amountChanged,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)?
        submitTransfer,
    TResult? Function()? resetState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function(String accountNumber)? verifyAccount,
    TResult Function(String amount)? amountChanged,
    TResult Function(String reason)? reasonChanged,
    TResult Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)?
        submitTransfer,
    TResult Function()? resetState,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(VerifyAccount value) verifyAccount,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(ResetState value) resetState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(VerifyAccount value)? verifyAccount,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(ResetState value)? resetState,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(VerifyAccount value)? verifyAccount,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(ResetState value)? resetState,
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

class _$AccountNumberChangedImpl implements AccountNumberChanged {
  const _$AccountNumberChangedImpl(this.accountNumber);

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
    required TResult Function(String accountNumber) verifyAccount,
    required TResult Function(String amount) amountChanged,
    required TResult Function(String reason) reasonChanged,
    required TResult Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)
        submitTransfer,
    required TResult Function() resetState,
  }) {
    return accountNumberChanged(accountNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function(String accountNumber)? verifyAccount,
    TResult? Function(String amount)? amountChanged,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)?
        submitTransfer,
    TResult? Function()? resetState,
  }) {
    return accountNumberChanged?.call(accountNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function(String accountNumber)? verifyAccount,
    TResult Function(String amount)? amountChanged,
    TResult Function(String reason)? reasonChanged,
    TResult Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)?
        submitTransfer,
    TResult Function()? resetState,
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
    required TResult Function(VerifyAccount value) verifyAccount,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(ResetState value) resetState,
  }) {
    return accountNumberChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(VerifyAccount value)? verifyAccount,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(ResetState value)? resetState,
  }) {
    return accountNumberChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(VerifyAccount value)? verifyAccount,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(ResetState value)? resetState,
    required TResult orElse(),
  }) {
    if (accountNumberChanged != null) {
      return accountNumberChanged(this);
    }
    return orElse();
  }
}

abstract class AccountNumberChanged implements InternalTransferEvent {
  const factory AccountNumberChanged(final String accountNumber) =
      _$AccountNumberChangedImpl;

  String get accountNumber;

  /// Create a copy of InternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountNumberChangedImplCopyWith<_$AccountNumberChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VerifyAccountImplCopyWith<$Res> {
  factory _$$VerifyAccountImplCopyWith(
          _$VerifyAccountImpl value, $Res Function(_$VerifyAccountImpl) then) =
      __$$VerifyAccountImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String accountNumber});
}

/// @nodoc
class __$$VerifyAccountImplCopyWithImpl<$Res>
    extends _$InternalTransferEventCopyWithImpl<$Res, _$VerifyAccountImpl>
    implements _$$VerifyAccountImplCopyWith<$Res> {
  __$$VerifyAccountImplCopyWithImpl(
      _$VerifyAccountImpl _value, $Res Function(_$VerifyAccountImpl) _then)
      : super(_value, _then);

  /// Create a copy of InternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountNumber = null,
  }) {
    return _then(_$VerifyAccountImpl(
      null == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$VerifyAccountImpl implements VerifyAccount {
  const _$VerifyAccountImpl(this.accountNumber);

  @override
  final String accountNumber;

  @override
  String toString() {
    return 'InternalTransferEvent.verifyAccount(accountNumber: $accountNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyAccountImpl &&
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
  _$$VerifyAccountImplCopyWith<_$VerifyAccountImpl> get copyWith =>
      __$$VerifyAccountImplCopyWithImpl<_$VerifyAccountImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String accountNumber) accountNumberChanged,
    required TResult Function(String accountNumber) verifyAccount,
    required TResult Function(String amount) amountChanged,
    required TResult Function(String reason) reasonChanged,
    required TResult Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)
        submitTransfer,
    required TResult Function() resetState,
  }) {
    return verifyAccount(accountNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function(String accountNumber)? verifyAccount,
    TResult? Function(String amount)? amountChanged,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)?
        submitTransfer,
    TResult? Function()? resetState,
  }) {
    return verifyAccount?.call(accountNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function(String accountNumber)? verifyAccount,
    TResult Function(String amount)? amountChanged,
    TResult Function(String reason)? reasonChanged,
    TResult Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)?
        submitTransfer,
    TResult Function()? resetState,
    required TResult orElse(),
  }) {
    if (verifyAccount != null) {
      return verifyAccount(accountNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(VerifyAccount value) verifyAccount,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(ResetState value) resetState,
  }) {
    return verifyAccount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(VerifyAccount value)? verifyAccount,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(ResetState value)? resetState,
  }) {
    return verifyAccount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(VerifyAccount value)? verifyAccount,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(ResetState value)? resetState,
    required TResult orElse(),
  }) {
    if (verifyAccount != null) {
      return verifyAccount(this);
    }
    return orElse();
  }
}

abstract class VerifyAccount implements InternalTransferEvent {
  const factory VerifyAccount(final String accountNumber) = _$VerifyAccountImpl;

  String get accountNumber;

  /// Create a copy of InternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VerifyAccountImplCopyWith<_$VerifyAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
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

class _$AmountChangedImpl implements AmountChanged {
  const _$AmountChangedImpl(this.amount);

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
    required TResult Function(String accountNumber) verifyAccount,
    required TResult Function(String amount) amountChanged,
    required TResult Function(String reason) reasonChanged,
    required TResult Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)
        submitTransfer,
    required TResult Function() resetState,
  }) {
    return amountChanged(amount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function(String accountNumber)? verifyAccount,
    TResult? Function(String amount)? amountChanged,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)?
        submitTransfer,
    TResult? Function()? resetState,
  }) {
    return amountChanged?.call(amount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function(String accountNumber)? verifyAccount,
    TResult Function(String amount)? amountChanged,
    TResult Function(String reason)? reasonChanged,
    TResult Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)?
        submitTransfer,
    TResult Function()? resetState,
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
    required TResult Function(VerifyAccount value) verifyAccount,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(ResetState value) resetState,
  }) {
    return amountChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(VerifyAccount value)? verifyAccount,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(ResetState value)? resetState,
  }) {
    return amountChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(VerifyAccount value)? verifyAccount,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(ResetState value)? resetState,
    required TResult orElse(),
  }) {
    if (amountChanged != null) {
      return amountChanged(this);
    }
    return orElse();
  }
}

abstract class AmountChanged implements InternalTransferEvent {
  const factory AmountChanged(final String amount) = _$AmountChangedImpl;

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

class _$ReasonChangedImpl implements ReasonChanged {
  const _$ReasonChangedImpl(this.reason);

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
    required TResult Function(String accountNumber) verifyAccount,
    required TResult Function(String amount) amountChanged,
    required TResult Function(String reason) reasonChanged,
    required TResult Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)
        submitTransfer,
    required TResult Function() resetState,
  }) {
    return reasonChanged(reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function(String accountNumber)? verifyAccount,
    TResult? Function(String amount)? amountChanged,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)?
        submitTransfer,
    TResult? Function()? resetState,
  }) {
    return reasonChanged?.call(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function(String accountNumber)? verifyAccount,
    TResult Function(String amount)? amountChanged,
    TResult Function(String reason)? reasonChanged,
    TResult Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)?
        submitTransfer,
    TResult Function()? resetState,
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
    required TResult Function(VerifyAccount value) verifyAccount,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(ResetState value) resetState,
  }) {
    return reasonChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(VerifyAccount value)? verifyAccount,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(ResetState value)? resetState,
  }) {
    return reasonChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(VerifyAccount value)? verifyAccount,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(ResetState value)? resetState,
    required TResult orElse(),
  }) {
    if (reasonChanged != null) {
      return reasonChanged(this);
    }
    return orElse();
  }
}

abstract class ReasonChanged implements InternalTransferEvent {
  const factory ReasonChanged(final String reason) = _$ReasonChangedImpl;

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
  @useResult
  $Res call(
      {AccountNumber fromAccountNumber,
      AccountNumber toAccountNumber,
      Amount amount,
      String? reason});
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
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromAccountNumber = null,
    Object? toAccountNumber = null,
    Object? amount = null,
    Object? reason = freezed,
  }) {
    return _then(_$SubmitTransferImpl(
      fromAccountNumber: null == fromAccountNumber
          ? _value.fromAccountNumber
          : fromAccountNumber // ignore: cast_nullable_to_non_nullable
              as AccountNumber,
      toAccountNumber: null == toAccountNumber
          ? _value.toAccountNumber
          : toAccountNumber // ignore: cast_nullable_to_non_nullable
              as AccountNumber,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as Amount,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SubmitTransferImpl implements SubmitTransfer {
  const _$SubmitTransferImpl(
      {required this.fromAccountNumber,
      required this.toAccountNumber,
      required this.amount,
      this.reason});

  @override
  final AccountNumber fromAccountNumber;
  @override
  final AccountNumber toAccountNumber;
  @override
  final Amount amount;
  @override
  final String? reason;

  @override
  String toString() {
    return 'InternalTransferEvent.submitTransfer(fromAccountNumber: $fromAccountNumber, toAccountNumber: $toAccountNumber, amount: $amount, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmitTransferImpl &&
            (identical(other.fromAccountNumber, fromAccountNumber) ||
                other.fromAccountNumber == fromAccountNumber) &&
            (identical(other.toAccountNumber, toAccountNumber) ||
                other.toAccountNumber == toAccountNumber) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, fromAccountNumber, toAccountNumber, amount, reason);

  /// Create a copy of InternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmitTransferImplCopyWith<_$SubmitTransferImpl> get copyWith =>
      __$$SubmitTransferImplCopyWithImpl<_$SubmitTransferImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String accountNumber) accountNumberChanged,
    required TResult Function(String accountNumber) verifyAccount,
    required TResult Function(String amount) amountChanged,
    required TResult Function(String reason) reasonChanged,
    required TResult Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)
        submitTransfer,
    required TResult Function() resetState,
  }) {
    return submitTransfer(fromAccountNumber, toAccountNumber, amount, reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function(String accountNumber)? verifyAccount,
    TResult? Function(String amount)? amountChanged,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)?
        submitTransfer,
    TResult? Function()? resetState,
  }) {
    return submitTransfer?.call(
        fromAccountNumber, toAccountNumber, amount, reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function(String accountNumber)? verifyAccount,
    TResult Function(String amount)? amountChanged,
    TResult Function(String reason)? reasonChanged,
    TResult Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)?
        submitTransfer,
    TResult Function()? resetState,
    required TResult orElse(),
  }) {
    if (submitTransfer != null) {
      return submitTransfer(fromAccountNumber, toAccountNumber, amount, reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(VerifyAccount value) verifyAccount,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(ResetState value) resetState,
  }) {
    return submitTransfer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(VerifyAccount value)? verifyAccount,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(ResetState value)? resetState,
  }) {
    return submitTransfer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(VerifyAccount value)? verifyAccount,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(ResetState value)? resetState,
    required TResult orElse(),
  }) {
    if (submitTransfer != null) {
      return submitTransfer(this);
    }
    return orElse();
  }
}

abstract class SubmitTransfer implements InternalTransferEvent {
  const factory SubmitTransfer(
      {required final AccountNumber fromAccountNumber,
      required final AccountNumber toAccountNumber,
      required final Amount amount,
      final String? reason}) = _$SubmitTransferImpl;

  AccountNumber get fromAccountNumber;
  AccountNumber get toAccountNumber;
  Amount get amount;
  String? get reason;

  /// Create a copy of InternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmitTransferImplCopyWith<_$SubmitTransferImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResetStateImplCopyWith<$Res> {
  factory _$$ResetStateImplCopyWith(
          _$ResetStateImpl value, $Res Function(_$ResetStateImpl) then) =
      __$$ResetStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResetStateImplCopyWithImpl<$Res>
    extends _$InternalTransferEventCopyWithImpl<$Res, _$ResetStateImpl>
    implements _$$ResetStateImplCopyWith<$Res> {
  __$$ResetStateImplCopyWithImpl(
      _$ResetStateImpl _value, $Res Function(_$ResetStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of InternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ResetStateImpl implements ResetState {
  const _$ResetStateImpl();

  @override
  String toString() {
    return 'InternalTransferEvent.resetState()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResetStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String accountNumber) accountNumberChanged,
    required TResult Function(String accountNumber) verifyAccount,
    required TResult Function(String amount) amountChanged,
    required TResult Function(String reason) reasonChanged,
    required TResult Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)
        submitTransfer,
    required TResult Function() resetState,
  }) {
    return resetState();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String accountNumber)? accountNumberChanged,
    TResult? Function(String accountNumber)? verifyAccount,
    TResult? Function(String amount)? amountChanged,
    TResult? Function(String reason)? reasonChanged,
    TResult? Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)?
        submitTransfer,
    TResult? Function()? resetState,
  }) {
    return resetState?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String accountNumber)? accountNumberChanged,
    TResult Function(String accountNumber)? verifyAccount,
    TResult Function(String amount)? amountChanged,
    TResult Function(String reason)? reasonChanged,
    TResult Function(AccountNumber fromAccountNumber,
            AccountNumber toAccountNumber, Amount amount, String? reason)?
        submitTransfer,
    TResult Function()? resetState,
    required TResult orElse(),
  }) {
    if (resetState != null) {
      return resetState();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AccountNumberChanged value) accountNumberChanged,
    required TResult Function(VerifyAccount value) verifyAccount,
    required TResult Function(AmountChanged value) amountChanged,
    required TResult Function(ReasonChanged value) reasonChanged,
    required TResult Function(SubmitTransfer value) submitTransfer,
    required TResult Function(ResetState value) resetState,
  }) {
    return resetState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AccountNumberChanged value)? accountNumberChanged,
    TResult? Function(VerifyAccount value)? verifyAccount,
    TResult? Function(AmountChanged value)? amountChanged,
    TResult? Function(ReasonChanged value)? reasonChanged,
    TResult? Function(SubmitTransfer value)? submitTransfer,
    TResult? Function(ResetState value)? resetState,
  }) {
    return resetState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AccountNumberChanged value)? accountNumberChanged,
    TResult Function(VerifyAccount value)? verifyAccount,
    TResult Function(AmountChanged value)? amountChanged,
    TResult Function(ReasonChanged value)? reasonChanged,
    TResult Function(SubmitTransfer value)? submitTransfer,
    TResult Function(ResetState value)? resetState,
    required TResult orElse(),
  }) {
    if (resetState != null) {
      return resetState(this);
    }
    return orElse();
  }
}

abstract class ResetState implements InternalTransferEvent {
  const factory ResetState() = _$ResetStateImpl;
}
