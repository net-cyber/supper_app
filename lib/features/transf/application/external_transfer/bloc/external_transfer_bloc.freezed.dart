// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'external_transfer_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ExternalTransferEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int fromAccountId,
            String toBankCode,
            String toAccountNumber,
            double amount,
            String currency,
            String? description)
        transferDetailsChanged,
    required TResult Function() createTransferSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int fromAccountId,
            String toBankCode,
            String toAccountNumber,
            double amount,
            String currency,
            String? description)?
        transferDetailsChanged,
    TResult? Function()? createTransferSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int fromAccountId,
            String toBankCode,
            String toAccountNumber,
            double amount,
            String currency,
            String? description)?
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
abstract class $ExternalTransferEventCopyWith<$Res> {
  factory $ExternalTransferEventCopyWith(ExternalTransferEvent value,
          $Res Function(ExternalTransferEvent) then) =
      _$ExternalTransferEventCopyWithImpl<$Res, ExternalTransferEvent>;
}

/// @nodoc
class _$ExternalTransferEventCopyWithImpl<$Res,
        $Val extends ExternalTransferEvent>
    implements $ExternalTransferEventCopyWith<$Res> {
  _$ExternalTransferEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExternalTransferEvent
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
      {int fromAccountId,
      String toBankCode,
      String toAccountNumber,
      double amount,
      String currency,
      String? description});
}

/// @nodoc
class __$$TransferDetailsChangedImplCopyWithImpl<$Res>
    extends _$ExternalTransferEventCopyWithImpl<$Res,
        _$TransferDetailsChangedImpl>
    implements _$$TransferDetailsChangedImplCopyWith<$Res> {
  __$$TransferDetailsChangedImplCopyWithImpl(
      _$TransferDetailsChangedImpl _value,
      $Res Function(_$TransferDetailsChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromAccountId = null,
    Object? toBankCode = null,
    Object? toAccountNumber = null,
    Object? amount = null,
    Object? currency = null,
    Object? description = freezed,
  }) {
    return _then(_$TransferDetailsChangedImpl(
      fromAccountId: null == fromAccountId
          ? _value.fromAccountId
          : fromAccountId // ignore: cast_nullable_to_non_nullable
              as int,
      toBankCode: null == toBankCode
          ? _value.toBankCode
          : toBankCode // ignore: cast_nullable_to_non_nullable
              as String,
      toAccountNumber: null == toAccountNumber
          ? _value.toAccountNumber
          : toAccountNumber // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TransferDetailsChangedImpl implements TransferDetailsChanged {
  const _$TransferDetailsChangedImpl(
      {required this.fromAccountId,
      required this.toBankCode,
      required this.toAccountNumber,
      required this.amount,
      required this.currency,
      this.description});

  @override
  final int fromAccountId;
  @override
  final String toBankCode;
  @override
  final String toAccountNumber;
  @override
  final double amount;
  @override
  final String currency;
  @override
  final String? description;

  @override
  String toString() {
    return 'ExternalTransferEvent.transferDetailsChanged(fromAccountId: $fromAccountId, toBankCode: $toBankCode, toAccountNumber: $toAccountNumber, amount: $amount, currency: $currency, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferDetailsChangedImpl &&
            (identical(other.fromAccountId, fromAccountId) ||
                other.fromAccountId == fromAccountId) &&
            (identical(other.toBankCode, toBankCode) ||
                other.toBankCode == toBankCode) &&
            (identical(other.toAccountNumber, toAccountNumber) ||
                other.toAccountNumber == toAccountNumber) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fromAccountId, toBankCode,
      toAccountNumber, amount, currency, description);

  /// Create a copy of ExternalTransferEvent
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
            int fromAccountId,
            String toBankCode,
            String toAccountNumber,
            double amount,
            String currency,
            String? description)
        transferDetailsChanged,
    required TResult Function() createTransferSubmitted,
  }) {
    return transferDetailsChanged(fromAccountId, toBankCode, toAccountNumber,
        amount, currency, description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int fromAccountId,
            String toBankCode,
            String toAccountNumber,
            double amount,
            String currency,
            String? description)?
        transferDetailsChanged,
    TResult? Function()? createTransferSubmitted,
  }) {
    return transferDetailsChanged?.call(fromAccountId, toBankCode,
        toAccountNumber, amount, currency, description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int fromAccountId,
            String toBankCode,
            String toAccountNumber,
            double amount,
            String currency,
            String? description)?
        transferDetailsChanged,
    TResult Function()? createTransferSubmitted,
    required TResult orElse(),
  }) {
    if (transferDetailsChanged != null) {
      return transferDetailsChanged(fromAccountId, toBankCode, toAccountNumber,
          amount, currency, description);
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

abstract class TransferDetailsChanged implements ExternalTransferEvent {
  const factory TransferDetailsChanged(
      {required final int fromAccountId,
      required final String toBankCode,
      required final String toAccountNumber,
      required final double amount,
      required final String currency,
      final String? description}) = _$TransferDetailsChangedImpl;

  int get fromAccountId;
  String get toBankCode;
  String get toAccountNumber;
  double get amount;
  String get currency;
  String? get description;

  /// Create a copy of ExternalTransferEvent
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
    extends _$ExternalTransferEventCopyWithImpl<$Res,
        _$CreateTransferSubmittedImpl>
    implements _$$CreateTransferSubmittedImplCopyWith<$Res> {
  __$$CreateTransferSubmittedImplCopyWithImpl(
      _$CreateTransferSubmittedImpl _value,
      $Res Function(_$CreateTransferSubmittedImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExternalTransferEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CreateTransferSubmittedImpl implements CreateTransferSubmitted {
  const _$CreateTransferSubmittedImpl();

  @override
  String toString() {
    return 'ExternalTransferEvent.createTransferSubmitted()';
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
            int fromAccountId,
            String toBankCode,
            String toAccountNumber,
            double amount,
            String currency,
            String? description)
        transferDetailsChanged,
    required TResult Function() createTransferSubmitted,
  }) {
    return createTransferSubmitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int fromAccountId,
            String toBankCode,
            String toAccountNumber,
            double amount,
            String currency,
            String? description)?
        transferDetailsChanged,
    TResult? Function()? createTransferSubmitted,
  }) {
    return createTransferSubmitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int fromAccountId,
            String toBankCode,
            String toAccountNumber,
            double amount,
            String currency,
            String? description)?
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

abstract class CreateTransferSubmitted implements ExternalTransferEvent {
  const factory CreateTransferSubmitted() = _$CreateTransferSubmittedImpl;
}

/// @nodoc
mixin _$ExternalTransferState {
  int get fromAccountId => throw _privateConstructorUsedError;
  String get toBankCode => throw _privateConstructorUsedError;
  String get toAccountNumber => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isTransferring => throw _privateConstructorUsedError;
  bool get transferError => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  bool get isTransferred => throw _privateConstructorUsedError;
  ExternalTransfer? get transferResponse => throw _privateConstructorUsedError;

  /// Create a copy of ExternalTransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExternalTransferStateCopyWith<ExternalTransferState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExternalTransferStateCopyWith<$Res> {
  factory $ExternalTransferStateCopyWith(ExternalTransferState value,
          $Res Function(ExternalTransferState) then) =
      _$ExternalTransferStateCopyWithImpl<$Res, ExternalTransferState>;
  @useResult
  $Res call(
      {int fromAccountId,
      String toBankCode,
      String toAccountNumber,
      double amount,
      String currency,
      String? description,
      bool isTransferring,
      bool transferError,
      String errorMessage,
      bool isTransferred,
      ExternalTransfer? transferResponse});

  $ExternalTransferCopyWith<$Res>? get transferResponse;
}

/// @nodoc
class _$ExternalTransferStateCopyWithImpl<$Res,
        $Val extends ExternalTransferState>
    implements $ExternalTransferStateCopyWith<$Res> {
  _$ExternalTransferStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExternalTransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromAccountId = null,
    Object? toBankCode = null,
    Object? toAccountNumber = null,
    Object? amount = null,
    Object? currency = null,
    Object? description = freezed,
    Object? isTransferring = null,
    Object? transferError = null,
    Object? errorMessage = null,
    Object? isTransferred = null,
    Object? transferResponse = freezed,
  }) {
    return _then(_value.copyWith(
      fromAccountId: null == fromAccountId
          ? _value.fromAccountId
          : fromAccountId // ignore: cast_nullable_to_non_nullable
              as int,
      toBankCode: null == toBankCode
          ? _value.toBankCode
          : toBankCode // ignore: cast_nullable_to_non_nullable
              as String,
      toAccountNumber: null == toAccountNumber
          ? _value.toAccountNumber
          : toAccountNumber // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isTransferring: null == isTransferring
          ? _value.isTransferring
          : isTransferring // ignore: cast_nullable_to_non_nullable
              as bool,
      transferError: null == transferError
          ? _value.transferError
          : transferError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isTransferred: null == isTransferred
          ? _value.isTransferred
          : isTransferred // ignore: cast_nullable_to_non_nullable
              as bool,
      transferResponse: freezed == transferResponse
          ? _value.transferResponse
          : transferResponse // ignore: cast_nullable_to_non_nullable
              as ExternalTransfer?,
    ) as $Val);
  }

  /// Create a copy of ExternalTransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExternalTransferCopyWith<$Res>? get transferResponse {
    if (_value.transferResponse == null) {
      return null;
    }

    return $ExternalTransferCopyWith<$Res>(_value.transferResponse!, (value) {
      return _then(_value.copyWith(transferResponse: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExternalTransferStateImplCopyWith<$Res>
    implements $ExternalTransferStateCopyWith<$Res> {
  factory _$$ExternalTransferStateImplCopyWith(
          _$ExternalTransferStateImpl value,
          $Res Function(_$ExternalTransferStateImpl) then) =
      __$$ExternalTransferStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int fromAccountId,
      String toBankCode,
      String toAccountNumber,
      double amount,
      String currency,
      String? description,
      bool isTransferring,
      bool transferError,
      String errorMessage,
      bool isTransferred,
      ExternalTransfer? transferResponse});

  @override
  $ExternalTransferCopyWith<$Res>? get transferResponse;
}

/// @nodoc
class __$$ExternalTransferStateImplCopyWithImpl<$Res>
    extends _$ExternalTransferStateCopyWithImpl<$Res,
        _$ExternalTransferStateImpl>
    implements _$$ExternalTransferStateImplCopyWith<$Res> {
  __$$ExternalTransferStateImplCopyWithImpl(_$ExternalTransferStateImpl _value,
      $Res Function(_$ExternalTransferStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExternalTransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fromAccountId = null,
    Object? toBankCode = null,
    Object? toAccountNumber = null,
    Object? amount = null,
    Object? currency = null,
    Object? description = freezed,
    Object? isTransferring = null,
    Object? transferError = null,
    Object? errorMessage = null,
    Object? isTransferred = null,
    Object? transferResponse = freezed,
  }) {
    return _then(_$ExternalTransferStateImpl(
      fromAccountId: null == fromAccountId
          ? _value.fromAccountId
          : fromAccountId // ignore: cast_nullable_to_non_nullable
              as int,
      toBankCode: null == toBankCode
          ? _value.toBankCode
          : toBankCode // ignore: cast_nullable_to_non_nullable
              as String,
      toAccountNumber: null == toAccountNumber
          ? _value.toAccountNumber
          : toAccountNumber // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isTransferring: null == isTransferring
          ? _value.isTransferring
          : isTransferring // ignore: cast_nullable_to_non_nullable
              as bool,
      transferError: null == transferError
          ? _value.transferError
          : transferError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isTransferred: null == isTransferred
          ? _value.isTransferred
          : isTransferred // ignore: cast_nullable_to_non_nullable
              as bool,
      transferResponse: freezed == transferResponse
          ? _value.transferResponse
          : transferResponse // ignore: cast_nullable_to_non_nullable
              as ExternalTransfer?,
    ));
  }
}

/// @nodoc

class _$ExternalTransferStateImpl implements _ExternalTransferState {
  const _$ExternalTransferStateImpl(
      {this.fromAccountId = 0,
      this.toBankCode = '',
      this.toAccountNumber = '',
      this.amount = 0.0,
      this.currency = 'ETB',
      this.description,
      this.isTransferring = false,
      this.transferError = false,
      this.errorMessage = '',
      this.isTransferred = false,
      this.transferResponse});

  @override
  @JsonKey()
  final int fromAccountId;
  @override
  @JsonKey()
  final String toBankCode;
  @override
  @JsonKey()
  final String toAccountNumber;
  @override
  @JsonKey()
  final double amount;
  @override
  @JsonKey()
  final String currency;
  @override
  final String? description;
  @override
  @JsonKey()
  final bool isTransferring;
  @override
  @JsonKey()
  final bool transferError;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  @JsonKey()
  final bool isTransferred;
  @override
  final ExternalTransfer? transferResponse;

  @override
  String toString() {
    return 'ExternalTransferState(fromAccountId: $fromAccountId, toBankCode: $toBankCode, toAccountNumber: $toAccountNumber, amount: $amount, currency: $currency, description: $description, isTransferring: $isTransferring, transferError: $transferError, errorMessage: $errorMessage, isTransferred: $isTransferred, transferResponse: $transferResponse)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExternalTransferStateImpl &&
            (identical(other.fromAccountId, fromAccountId) ||
                other.fromAccountId == fromAccountId) &&
            (identical(other.toBankCode, toBankCode) ||
                other.toBankCode == toBankCode) &&
            (identical(other.toAccountNumber, toAccountNumber) ||
                other.toAccountNumber == toAccountNumber) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isTransferring, isTransferring) ||
                other.isTransferring == isTransferring) &&
            (identical(other.transferError, transferError) ||
                other.transferError == transferError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isTransferred, isTransferred) ||
                other.isTransferred == isTransferred) &&
            (identical(other.transferResponse, transferResponse) ||
                other.transferResponse == transferResponse));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      fromAccountId,
      toBankCode,
      toAccountNumber,
      amount,
      currency,
      description,
      isTransferring,
      transferError,
      errorMessage,
      isTransferred,
      transferResponse);

  /// Create a copy of ExternalTransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExternalTransferStateImplCopyWith<_$ExternalTransferStateImpl>
      get copyWith => __$$ExternalTransferStateImplCopyWithImpl<
          _$ExternalTransferStateImpl>(this, _$identity);
}

abstract class _ExternalTransferState implements ExternalTransferState {
  const factory _ExternalTransferState(
      {final int fromAccountId,
      final String toBankCode,
      final String toAccountNumber,
      final double amount,
      final String currency,
      final String? description,
      final bool isTransferring,
      final bool transferError,
      final String errorMessage,
      final bool isTransferred,
      final ExternalTransfer? transferResponse}) = _$ExternalTransferStateImpl;

  @override
  int get fromAccountId;
  @override
  String get toBankCode;
  @override
  String get toAccountNumber;
  @override
  double get amount;
  @override
  String get currency;
  @override
  String? get description;
  @override
  bool get isTransferring;
  @override
  bool get transferError;
  @override
  String get errorMessage;
  @override
  bool get isTransferred;
  @override
  ExternalTransfer? get transferResponse;

  /// Create a copy of ExternalTransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExternalTransferStateImplCopyWith<_$ExternalTransferStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
