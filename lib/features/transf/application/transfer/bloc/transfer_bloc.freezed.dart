// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransferEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int fromAccountId, int toAccountId, double amount, String currency)
        transferDetailsChanged,
    required TResult Function() createTransferSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int fromAccountId, int toAccountId, double amount, String currency)?
        transferDetailsChanged,
    TResult? Function()? createTransferSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int fromAccountId, int toAccountId, double amount, String currency)?
        transferDetailsChanged,
    TResult Function()? createTransferSubmitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransferDetailsChanged value)
        transferDetailsChanged,
    required TResult Function(CreateTransferSubmitted value)
        createTransferSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransferDetailsChanged value)? transferDetailsChanged,
    TResult? Function(CreateTransferSubmitted value)? createTransferSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransferDetailsChanged value)? transferDetailsChanged,
    TResult Function(CreateTransferSubmitted value)? createTransferSubmitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferEventCopyWith<$Res> {
  factory $TransferEventCopyWith(
          TransferEvent value, $Res Function(TransferEvent) then) =
      _$TransferEventCopyWithImpl<$Res, TransferEvent>;
}

/// @nodoc
class _$TransferEventCopyWithImpl<$Res, $Val extends TransferEvent>
    implements $TransferEventCopyWith<$Res> {
  _$TransferEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransferEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TransferDetailsChangedImplCopyWith<$Res> {
  factory _$$TransferDetailsChangedImplCopyWith(
          _$TransferDetailsChangedImpl value,
          $Res Function(_$TransferDetailsChangedImpl) then) =
      __$$TransferDetailsChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {int fromAccountId, int toAccountId, double amount, String currency});
}

/// @nodoc
class __$$TransferDetailsChangedImplCopyWithImpl<$Res>
    extends _$TransferEventCopyWithImpl<$Res, _$TransferDetailsChangedImpl>
    implements _$$TransferDetailsChangedImplCopyWith<$Res> {
  __$$TransferDetailsChangedImplCopyWithImpl(
      _$TransferDetailsChangedImpl _value,
      $Res Function(_$TransferDetailsChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromAccountId = null,
    Object? toAccountId = null,
    Object? amount = null,
    Object? currency = null,
  }) {
    return _then(_$TransferDetailsChangedImpl(
      fromAccountId: null == fromAccountId
          ? _value.fromAccountId
          : fromAccountId // ignore: cast_nullable_to_non_nullable
              as int,
      toAccountId: null == toAccountId
          ? _value.toAccountId
          : toAccountId // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TransferDetailsChangedImpl implements TransferDetailsChanged {
  const _$TransferDetailsChangedImpl(
      {required this.fromAccountId,
      required this.toAccountId,
      required this.amount,
      required this.currency});

  @override
  final int fromAccountId;
  @override
  final int toAccountId;
  @override
  final double amount;
  @override
  final String currency;

  @override
  String toString() {
    return 'TransferEvent.transferDetailsChanged(fromAccountId: $fromAccountId, toAccountId: $toAccountId, amount: $amount, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferDetailsChangedImpl &&
            (identical(other.fromAccountId, fromAccountId) ||
                other.fromAccountId == fromAccountId) &&
            (identical(other.toAccountId, toAccountId) ||
                other.toAccountId == toAccountId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, fromAccountId, toAccountId, amount, currency);

  /// Create a copy of TransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferDetailsChangedImplCopyWith<_$TransferDetailsChangedImpl>
      get copyWith => __$$TransferDetailsChangedImplCopyWithImpl<
          _$TransferDetailsChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int fromAccountId, int toAccountId, double amount, String currency)
        transferDetailsChanged,
    required TResult Function() createTransferSubmitted,
  }) {
    return transferDetailsChanged(fromAccountId, toAccountId, amount, currency);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int fromAccountId, int toAccountId, double amount, String currency)?
        transferDetailsChanged,
    TResult? Function()? createTransferSubmitted,
  }) {
    return transferDetailsChanged?.call(
        fromAccountId, toAccountId, amount, currency);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int fromAccountId, int toAccountId, double amount, String currency)?
        transferDetailsChanged,
    TResult Function()? createTransferSubmitted,
    required TResult orElse(),
  }) {
    if (transferDetailsChanged != null) {
      return transferDetailsChanged(
          fromAccountId, toAccountId, amount, currency);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransferDetailsChanged value)
        transferDetailsChanged,
    required TResult Function(CreateTransferSubmitted value)
        createTransferSubmitted,
  }) {
    return transferDetailsChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransferDetailsChanged value)? transferDetailsChanged,
    TResult? Function(CreateTransferSubmitted value)? createTransferSubmitted,
  }) {
    return transferDetailsChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransferDetailsChanged value)? transferDetailsChanged,
    TResult Function(CreateTransferSubmitted value)? createTransferSubmitted,
    required TResult orElse(),
  }) {
    if (transferDetailsChanged != null) {
      return transferDetailsChanged(this);
    }
    return orElse();
  }
}

abstract class TransferDetailsChanged implements TransferEvent {
  const factory TransferDetailsChanged(
      {required final int fromAccountId,
      required final int toAccountId,
      required final double amount,
      required final String currency}) = _$TransferDetailsChangedImpl;

  int get fromAccountId;
  int get toAccountId;
  double get amount;
  String get currency;

  /// Create a copy of TransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferDetailsChangedImplCopyWith<_$TransferDetailsChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateTransferSubmittedImplCopyWith<$Res> {
  factory _$$CreateTransferSubmittedImplCopyWith(
          _$CreateTransferSubmittedImpl value,
          $Res Function(_$CreateTransferSubmittedImpl) then) =
      __$$CreateTransferSubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreateTransferSubmittedImplCopyWithImpl<$Res>
    extends _$TransferEventCopyWithImpl<$Res, _$CreateTransferSubmittedImpl>
    implements _$$CreateTransferSubmittedImplCopyWith<$Res> {
  __$$CreateTransferSubmittedImplCopyWithImpl(
      _$CreateTransferSubmittedImpl _value,
      $Res Function(_$CreateTransferSubmittedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransferEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CreateTransferSubmittedImpl implements CreateTransferSubmitted {
  const _$CreateTransferSubmittedImpl();

  @override
  String toString() {
    return 'TransferEvent.createTransferSubmitted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTransferSubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int fromAccountId, int toAccountId, double amount, String currency)
        transferDetailsChanged,
    required TResult Function() createTransferSubmitted,
  }) {
    return createTransferSubmitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int fromAccountId, int toAccountId, double amount, String currency)?
        transferDetailsChanged,
    TResult? Function()? createTransferSubmitted,
  }) {
    return createTransferSubmitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int fromAccountId, int toAccountId, double amount, String currency)?
        transferDetailsChanged,
    TResult Function()? createTransferSubmitted,
    required TResult orElse(),
  }) {
    if (createTransferSubmitted != null) {
      return createTransferSubmitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransferDetailsChanged value)
        transferDetailsChanged,
    required TResult Function(CreateTransferSubmitted value)
        createTransferSubmitted,
  }) {
    return createTransferSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransferDetailsChanged value)? transferDetailsChanged,
    TResult? Function(CreateTransferSubmitted value)? createTransferSubmitted,
  }) {
    return createTransferSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransferDetailsChanged value)? transferDetailsChanged,
    TResult Function(CreateTransferSubmitted value)? createTransferSubmitted,
    required TResult orElse(),
  }) {
    if (createTransferSubmitted != null) {
      return createTransferSubmitted(this);
    }
    return orElse();
  }
}

abstract class CreateTransferSubmitted implements TransferEvent {
  const factory CreateTransferSubmitted() = _$CreateTransferSubmittedImpl;
}

/// @nodoc
mixin _$TransferState {
  int get fromAccountId => throw _privateConstructorUsedError;
  int get toAccountId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  bool get isTransferring => throw _privateConstructorUsedError;
  bool get isTransferred => throw _privateConstructorUsedError;
  bool get transferError => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  String? get transferId => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get transactionRef => throw _privateConstructorUsedError;
  String? get timestamp => throw _privateConstructorUsedError;
  TransferResponse? get transferResponse => throw _privateConstructorUsedError;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransferStateCopyWith<TransferState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferStateCopyWith<$Res> {
  factory $TransferStateCopyWith(
          TransferState value, $Res Function(TransferState) then) =
      _$TransferStateCopyWithImpl<$Res, TransferState>;
  @useResult
  $Res call(
      {int fromAccountId,
      int toAccountId,
      double amount,
      String currency,
      bool isTransferring,
      bool isTransferred,
      bool transferError,
      String errorMessage,
      String? transferId,
      String? status,
      String? transactionRef,
      String? timestamp,
      TransferResponse? transferResponse});

  $TransferResponseCopyWith<$Res>? get transferResponse;
}

/// @nodoc
class _$TransferStateCopyWithImpl<$Res, $Val extends TransferState>
    implements $TransferStateCopyWith<$Res> {
  _$TransferStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromAccountId = null,
    Object? toAccountId = null,
    Object? amount = null,
    Object? currency = null,
    Object? isTransferring = null,
    Object? isTransferred = null,
    Object? transferError = null,
    Object? errorMessage = null,
    Object? transferId = freezed,
    Object? status = freezed,
    Object? transactionRef = freezed,
    Object? timestamp = freezed,
    Object? transferResponse = freezed,
  }) {
    return _then(_value.copyWith(
      fromAccountId: null == fromAccountId
          ? _value.fromAccountId
          : fromAccountId // ignore: cast_nullable_to_non_nullable
              as int,
      toAccountId: null == toAccountId
          ? _value.toAccountId
          : toAccountId // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      isTransferring: null == isTransferring
          ? _value.isTransferring
          : isTransferring // ignore: cast_nullable_to_non_nullable
              as bool,
      isTransferred: null == isTransferred
          ? _value.isTransferred
          : isTransferred // ignore: cast_nullable_to_non_nullable
              as bool,
      transferError: null == transferError
          ? _value.transferError
          : transferError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      transferId: freezed == transferId
          ? _value.transferId
          : transferId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionRef: freezed == transactionRef
          ? _value.transactionRef
          : transactionRef // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
      transferResponse: freezed == transferResponse
          ? _value.transferResponse
          : transferResponse // ignore: cast_nullable_to_non_nullable
              as TransferResponse?,
    ) as $Val);
  }

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransferResponseCopyWith<$Res>? get transferResponse {
    if (_value.transferResponse == null) {
      return null;
    }

    return $TransferResponseCopyWith<$Res>(_value.transferResponse!, (value) {
      return _then(_value.copyWith(transferResponse: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransferStateImplCopyWith<$Res>
    implements $TransferStateCopyWith<$Res> {
  factory _$$TransferStateImplCopyWith(
          _$TransferStateImpl value, $Res Function(_$TransferStateImpl) then) =
      __$$TransferStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int fromAccountId,
      int toAccountId,
      double amount,
      String currency,
      bool isTransferring,
      bool isTransferred,
      bool transferError,
      String errorMessage,
      String? transferId,
      String? status,
      String? transactionRef,
      String? timestamp,
      TransferResponse? transferResponse});

  @override
  $TransferResponseCopyWith<$Res>? get transferResponse;
}

/// @nodoc
class __$$TransferStateImplCopyWithImpl<$Res>
    extends _$TransferStateCopyWithImpl<$Res, _$TransferStateImpl>
    implements _$$TransferStateImplCopyWith<$Res> {
  __$$TransferStateImplCopyWithImpl(
      _$TransferStateImpl _value, $Res Function(_$TransferStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromAccountId = null,
    Object? toAccountId = null,
    Object? amount = null,
    Object? currency = null,
    Object? isTransferring = null,
    Object? isTransferred = null,
    Object? transferError = null,
    Object? errorMessage = null,
    Object? transferId = freezed,
    Object? status = freezed,
    Object? transactionRef = freezed,
    Object? timestamp = freezed,
    Object? transferResponse = freezed,
  }) {
    return _then(_$TransferStateImpl(
      fromAccountId: null == fromAccountId
          ? _value.fromAccountId
          : fromAccountId // ignore: cast_nullable_to_non_nullable
              as int,
      toAccountId: null == toAccountId
          ? _value.toAccountId
          : toAccountId // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      isTransferring: null == isTransferring
          ? _value.isTransferring
          : isTransferring // ignore: cast_nullable_to_non_nullable
              as bool,
      isTransferred: null == isTransferred
          ? _value.isTransferred
          : isTransferred // ignore: cast_nullable_to_non_nullable
              as bool,
      transferError: null == transferError
          ? _value.transferError
          : transferError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      transferId: freezed == transferId
          ? _value.transferId
          : transferId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionRef: freezed == transactionRef
          ? _value.transactionRef
          : transactionRef // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
      transferResponse: freezed == transferResponse
          ? _value.transferResponse
          : transferResponse // ignore: cast_nullable_to_non_nullable
              as TransferResponse?,
    ));
  }
}

/// @nodoc

class _$TransferStateImpl implements _TransferState {
  const _$TransferStateImpl(
      {required this.fromAccountId,
      required this.toAccountId,
      required this.amount,
      required this.currency,
      required this.isTransferring,
      required this.isTransferred,
      required this.transferError,
      required this.errorMessage,
      this.transferId,
      this.status,
      this.transactionRef,
      this.timestamp,
      this.transferResponse});

  @override
  final int fromAccountId;
  @override
  final int toAccountId;
  @override
  final double amount;
  @override
  final String currency;
  @override
  final bool isTransferring;
  @override
  final bool isTransferred;
  @override
  final bool transferError;
  @override
  final String errorMessage;
  @override
  final String? transferId;
  @override
  final String? status;
  @override
  final String? transactionRef;
  @override
  final String? timestamp;
  @override
  final TransferResponse? transferResponse;

  @override
  String toString() {
    return 'TransferState(fromAccountId: $fromAccountId, toAccountId: $toAccountId, amount: $amount, currency: $currency, isTransferring: $isTransferring, isTransferred: $isTransferred, transferError: $transferError, errorMessage: $errorMessage, transferId: $transferId, status: $status, transactionRef: $transactionRef, timestamp: $timestamp, transferResponse: $transferResponse)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferStateImpl &&
            (identical(other.fromAccountId, fromAccountId) ||
                other.fromAccountId == fromAccountId) &&
            (identical(other.toAccountId, toAccountId) ||
                other.toAccountId == toAccountId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.isTransferring, isTransferring) ||
                other.isTransferring == isTransferring) &&
            (identical(other.isTransferred, isTransferred) ||
                other.isTransferred == isTransferred) &&
            (identical(other.transferError, transferError) ||
                other.transferError == transferError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.transferId, transferId) ||
                other.transferId == transferId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.transactionRef, transactionRef) ||
                other.transactionRef == transactionRef) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.transferResponse, transferResponse) ||
                other.transferResponse == transferResponse));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      fromAccountId,
      toAccountId,
      amount,
      currency,
      isTransferring,
      isTransferred,
      transferError,
      errorMessage,
      transferId,
      status,
      transactionRef,
      timestamp,
      transferResponse);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferStateImplCopyWith<_$TransferStateImpl> get copyWith =>
      __$$TransferStateImplCopyWithImpl<_$TransferStateImpl>(this, _$identity);
}

abstract class _TransferState implements TransferState {
  const factory _TransferState(
      {required final int fromAccountId,
      required final int toAccountId,
      required final double amount,
      required final String currency,
      required final bool isTransferring,
      required final bool isTransferred,
      required final bool transferError,
      required final String errorMessage,
      final String? transferId,
      final String? status,
      final String? transactionRef,
      final String? timestamp,
      final TransferResponse? transferResponse}) = _$TransferStateImpl;

  @override
  int get fromAccountId;
  @override
  int get toAccountId;
  @override
  double get amount;
  @override
  String get currency;
  @override
  bool get isTransferring;
  @override
  bool get isTransferred;
  @override
  bool get transferError;
  @override
  String get errorMessage;
  @override
  String? get transferId;
  @override
  String? get status;
  @override
  String? get transactionRef;
  @override
  String? get timestamp;
  @override
  TransferResponse? get transferResponse;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferStateImplCopyWith<_$TransferStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
