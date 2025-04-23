// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_detail_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransactionDetailEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int transactionId, int accountId) fetched,
    required TResult Function(Transaction transaction) setFromCache,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int transactionId, int accountId)? fetched,
    TResult? Function(Transaction transaction)? setFromCache,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int transactionId, int accountId)? fetched,
    TResult Function(Transaction transaction)? setFromCache,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionDetailFetched value) fetched,
    required TResult Function(TransactionDetailSetFromCache value) setFromCache,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionDetailFetched value)? fetched,
    TResult? Function(TransactionDetailSetFromCache value)? setFromCache,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionDetailFetched value)? fetched,
    TResult Function(TransactionDetailSetFromCache value)? setFromCache,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionDetailEventCopyWith<$Res> {
  factory $TransactionDetailEventCopyWith(TransactionDetailEvent value,
          $Res Function(TransactionDetailEvent) then) =
      _$TransactionDetailEventCopyWithImpl<$Res, TransactionDetailEvent>;
}

/// @nodoc
class _$TransactionDetailEventCopyWithImpl<$Res,
        $Val extends TransactionDetailEvent>
    implements $TransactionDetailEventCopyWith<$Res> {
  _$TransactionDetailEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionDetailEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TransactionDetailFetchedImplCopyWith<$Res> {
  factory _$$TransactionDetailFetchedImplCopyWith(
          _$TransactionDetailFetchedImpl value,
          $Res Function(_$TransactionDetailFetchedImpl) then) =
      __$$TransactionDetailFetchedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int transactionId, int accountId});
}

/// @nodoc
class __$$TransactionDetailFetchedImplCopyWithImpl<$Res>
    extends _$TransactionDetailEventCopyWithImpl<$Res,
        _$TransactionDetailFetchedImpl>
    implements _$$TransactionDetailFetchedImplCopyWith<$Res> {
  __$$TransactionDetailFetchedImplCopyWithImpl(
      _$TransactionDetailFetchedImpl _value,
      $Res Function(_$TransactionDetailFetchedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? accountId = null,
  }) {
    return _then(_$TransactionDetailFetchedImpl(
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TransactionDetailFetchedImpl implements TransactionDetailFetched {
  const _$TransactionDetailFetchedImpl(
      {required this.transactionId, this.accountId = 0});

  @override
  final int transactionId;
  @override
  @JsonKey()
  final int accountId;

  @override
  String toString() {
    return 'TransactionDetailEvent.fetched(transactionId: $transactionId, accountId: $accountId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionDetailFetchedImpl &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transactionId, accountId);

  /// Create a copy of TransactionDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionDetailFetchedImplCopyWith<_$TransactionDetailFetchedImpl>
      get copyWith => __$$TransactionDetailFetchedImplCopyWithImpl<
          _$TransactionDetailFetchedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int transactionId, int accountId) fetched,
    required TResult Function(Transaction transaction) setFromCache,
  }) {
    return fetched(transactionId, accountId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int transactionId, int accountId)? fetched,
    TResult? Function(Transaction transaction)? setFromCache,
  }) {
    return fetched?.call(transactionId, accountId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int transactionId, int accountId)? fetched,
    TResult Function(Transaction transaction)? setFromCache,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(transactionId, accountId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionDetailFetched value) fetched,
    required TResult Function(TransactionDetailSetFromCache value) setFromCache,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionDetailFetched value)? fetched,
    TResult? Function(TransactionDetailSetFromCache value)? setFromCache,
  }) {
    return fetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionDetailFetched value)? fetched,
    TResult Function(TransactionDetailSetFromCache value)? setFromCache,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class TransactionDetailFetched implements TransactionDetailEvent {
  const factory TransactionDetailFetched(
      {required final int transactionId,
      final int accountId}) = _$TransactionDetailFetchedImpl;

  int get transactionId;
  int get accountId;

  /// Create a copy of TransactionDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionDetailFetchedImplCopyWith<_$TransactionDetailFetchedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransactionDetailSetFromCacheImplCopyWith<$Res> {
  factory _$$TransactionDetailSetFromCacheImplCopyWith(
          _$TransactionDetailSetFromCacheImpl value,
          $Res Function(_$TransactionDetailSetFromCacheImpl) then) =
      __$$TransactionDetailSetFromCacheImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Transaction transaction});

  $TransactionCopyWith<$Res> get transaction;
}

/// @nodoc
class __$$TransactionDetailSetFromCacheImplCopyWithImpl<$Res>
    extends _$TransactionDetailEventCopyWithImpl<$Res,
        _$TransactionDetailSetFromCacheImpl>
    implements _$$TransactionDetailSetFromCacheImplCopyWith<$Res> {
  __$$TransactionDetailSetFromCacheImplCopyWithImpl(
      _$TransactionDetailSetFromCacheImpl _value,
      $Res Function(_$TransactionDetailSetFromCacheImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
  }) {
    return _then(_$TransactionDetailSetFromCacheImpl(
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as Transaction,
    ));
  }

  /// Create a copy of TransactionDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionCopyWith<$Res> get transaction {
    return $TransactionCopyWith<$Res>(_value.transaction, (value) {
      return _then(_value.copyWith(transaction: value));
    });
  }
}

/// @nodoc

class _$TransactionDetailSetFromCacheImpl
    implements TransactionDetailSetFromCache {
  const _$TransactionDetailSetFromCacheImpl({required this.transaction});

  @override
  final Transaction transaction;

  @override
  String toString() {
    return 'TransactionDetailEvent.setFromCache(transaction: $transaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionDetailSetFromCacheImpl &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction);

  /// Create a copy of TransactionDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionDetailSetFromCacheImplCopyWith<
          _$TransactionDetailSetFromCacheImpl>
      get copyWith => __$$TransactionDetailSetFromCacheImplCopyWithImpl<
          _$TransactionDetailSetFromCacheImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int transactionId, int accountId) fetched,
    required TResult Function(Transaction transaction) setFromCache,
  }) {
    return setFromCache(transaction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int transactionId, int accountId)? fetched,
    TResult? Function(Transaction transaction)? setFromCache,
  }) {
    return setFromCache?.call(transaction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int transactionId, int accountId)? fetched,
    TResult Function(Transaction transaction)? setFromCache,
    required TResult orElse(),
  }) {
    if (setFromCache != null) {
      return setFromCache(transaction);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionDetailFetched value) fetched,
    required TResult Function(TransactionDetailSetFromCache value) setFromCache,
  }) {
    return setFromCache(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionDetailFetched value)? fetched,
    TResult? Function(TransactionDetailSetFromCache value)? setFromCache,
  }) {
    return setFromCache?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionDetailFetched value)? fetched,
    TResult Function(TransactionDetailSetFromCache value)? setFromCache,
    required TResult orElse(),
  }) {
    if (setFromCache != null) {
      return setFromCache(this);
    }
    return orElse();
  }
}

abstract class TransactionDetailSetFromCache implements TransactionDetailEvent {
  const factory TransactionDetailSetFromCache(
          {required final Transaction transaction}) =
      _$TransactionDetailSetFromCacheImpl;

  Transaction get transaction;

  /// Create a copy of TransactionDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionDetailSetFromCacheImplCopyWith<
          _$TransactionDetailSetFromCacheImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransactionDetailState {
  TransactionDetailStatus get status => throw _privateConstructorUsedError;
  Transaction? get transaction => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of TransactionDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionDetailStateCopyWith<TransactionDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionDetailStateCopyWith<$Res> {
  factory $TransactionDetailStateCopyWith(TransactionDetailState value,
          $Res Function(TransactionDetailState) then) =
      _$TransactionDetailStateCopyWithImpl<$Res, TransactionDetailState>;
  @useResult
  $Res call(
      {TransactionDetailStatus status,
      Transaction? transaction,
      String errorMessage});

  $TransactionCopyWith<$Res>? get transaction;
}

/// @nodoc
class _$TransactionDetailStateCopyWithImpl<$Res,
        $Val extends TransactionDetailState>
    implements $TransactionDetailStateCopyWith<$Res> {
  _$TransactionDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? transaction = freezed,
    Object? errorMessage = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransactionDetailStatus,
      transaction: freezed == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of TransactionDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionCopyWith<$Res>? get transaction {
    if (_value.transaction == null) {
      return null;
    }

    return $TransactionCopyWith<$Res>(_value.transaction!, (value) {
      return _then(_value.copyWith(transaction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransactionDetailStateImplCopyWith<$Res>
    implements $TransactionDetailStateCopyWith<$Res> {
  factory _$$TransactionDetailStateImplCopyWith(
          _$TransactionDetailStateImpl value,
          $Res Function(_$TransactionDetailStateImpl) then) =
      __$$TransactionDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TransactionDetailStatus status,
      Transaction? transaction,
      String errorMessage});

  @override
  $TransactionCopyWith<$Res>? get transaction;
}

/// @nodoc
class __$$TransactionDetailStateImplCopyWithImpl<$Res>
    extends _$TransactionDetailStateCopyWithImpl<$Res,
        _$TransactionDetailStateImpl>
    implements _$$TransactionDetailStateImplCopyWith<$Res> {
  __$$TransactionDetailStateImplCopyWithImpl(
      _$TransactionDetailStateImpl _value,
      $Res Function(_$TransactionDetailStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? transaction = freezed,
    Object? errorMessage = null,
  }) {
    return _then(_$TransactionDetailStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransactionDetailStatus,
      transaction: freezed == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as Transaction?,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TransactionDetailStateImpl implements _TransactionDetailState {
  const _$TransactionDetailStateImpl(
      {this.status = TransactionDetailStatus.initial,
      this.transaction,
      this.errorMessage = ''});

  @override
  @JsonKey()
  final TransactionDetailStatus status;
  @override
  final Transaction? transaction;
  @override
  @JsonKey()
  final String errorMessage;

  @override
  String toString() {
    return 'TransactionDetailState(status: $status, transaction: $transaction, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionDetailStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, transaction, errorMessage);

  /// Create a copy of TransactionDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionDetailStateImplCopyWith<_$TransactionDetailStateImpl>
      get copyWith => __$$TransactionDetailStateImplCopyWithImpl<
          _$TransactionDetailStateImpl>(this, _$identity);
}

abstract class _TransactionDetailState implements TransactionDetailState {
  const factory _TransactionDetailState(
      {final TransactionDetailStatus status,
      final Transaction? transaction,
      final String errorMessage}) = _$TransactionDetailStateImpl;

  @override
  TransactionDetailStatus get status;
  @override
  Transaction? get transaction;
  @override
  String get errorMessage;

  /// Create a copy of TransactionDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionDetailStateImplCopyWith<_$TransactionDetailStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
