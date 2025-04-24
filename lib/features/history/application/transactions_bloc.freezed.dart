// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transactions_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransactionsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetched,
    required TResult Function() refreshed,
    required TResult Function(TransactionFilter filter) filtered,
    required TResult Function() loadMore,
    required TResult Function(int accountId) accountChanged,
    required TResult Function(int transactionId, int accountId) detailFetched,
    required TResult Function(Transaction transaction) detailSetFromCache,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetched,
    TResult? Function()? refreshed,
    TResult? Function(TransactionFilter filter)? filtered,
    TResult? Function()? loadMore,
    TResult? Function(int accountId)? accountChanged,
    TResult? Function(int transactionId, int accountId)? detailFetched,
    TResult? Function(Transaction transaction)? detailSetFromCache,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetched,
    TResult Function()? refreshed,
    TResult Function(TransactionFilter filter)? filtered,
    TResult Function()? loadMore,
    TResult Function(int accountId)? accountChanged,
    TResult Function(int transactionId, int accountId)? detailFetched,
    TResult Function(Transaction transaction)? detailSetFromCache,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionsFetched value) fetched,
    required TResult Function(TransactionsRefreshed value) refreshed,
    required TResult Function(TransactionsFiltered value) filtered,
    required TResult Function(TransactionsLoadMore value) loadMore,
    required TResult Function(TransactionsAccountChanged value) accountChanged,
    required TResult Function(TransactionDetailFetched value) detailFetched,
    required TResult Function(TransactionDetailSetFromCache value)
        detailSetFromCache,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionsFetched value)? fetched,
    TResult? Function(TransactionsRefreshed value)? refreshed,
    TResult? Function(TransactionsFiltered value)? filtered,
    TResult? Function(TransactionsLoadMore value)? loadMore,
    TResult? Function(TransactionsAccountChanged value)? accountChanged,
    TResult? Function(TransactionDetailFetched value)? detailFetched,
    TResult? Function(TransactionDetailSetFromCache value)? detailSetFromCache,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionsFetched value)? fetched,
    TResult Function(TransactionsRefreshed value)? refreshed,
    TResult Function(TransactionsFiltered value)? filtered,
    TResult Function(TransactionsLoadMore value)? loadMore,
    TResult Function(TransactionsAccountChanged value)? accountChanged,
    TResult Function(TransactionDetailFetched value)? detailFetched,
    TResult Function(TransactionDetailSetFromCache value)? detailSetFromCache,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionsEventCopyWith<$Res> {
  factory $TransactionsEventCopyWith(
          TransactionsEvent value, $Res Function(TransactionsEvent) then) =
      _$TransactionsEventCopyWithImpl<$Res, TransactionsEvent>;
}

/// @nodoc
class _$TransactionsEventCopyWithImpl<$Res, $Val extends TransactionsEvent>
    implements $TransactionsEventCopyWith<$Res> {
  _$TransactionsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TransactionsFetchedImplCopyWith<$Res> {
  factory _$$TransactionsFetchedImplCopyWith(_$TransactionsFetchedImpl value,
          $Res Function(_$TransactionsFetchedImpl) then) =
      __$$TransactionsFetchedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransactionsFetchedImplCopyWithImpl<$Res>
    extends _$TransactionsEventCopyWithImpl<$Res, _$TransactionsFetchedImpl>
    implements _$$TransactionsFetchedImplCopyWith<$Res> {
  __$$TransactionsFetchedImplCopyWithImpl(_$TransactionsFetchedImpl _value,
      $Res Function(_$TransactionsFetchedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TransactionsFetchedImpl implements TransactionsFetched {
  const _$TransactionsFetchedImpl();

  @override
  String toString() {
    return 'TransactionsEvent.fetched()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionsFetchedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetched,
    required TResult Function() refreshed,
    required TResult Function(TransactionFilter filter) filtered,
    required TResult Function() loadMore,
    required TResult Function(int accountId) accountChanged,
    required TResult Function(int transactionId, int accountId) detailFetched,
    required TResult Function(Transaction transaction) detailSetFromCache,
  }) {
    return fetched();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetched,
    TResult? Function()? refreshed,
    TResult? Function(TransactionFilter filter)? filtered,
    TResult? Function()? loadMore,
    TResult? Function(int accountId)? accountChanged,
    TResult? Function(int transactionId, int accountId)? detailFetched,
    TResult? Function(Transaction transaction)? detailSetFromCache,
  }) {
    return fetched?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetched,
    TResult Function()? refreshed,
    TResult Function(TransactionFilter filter)? filtered,
    TResult Function()? loadMore,
    TResult Function(int accountId)? accountChanged,
    TResult Function(int transactionId, int accountId)? detailFetched,
    TResult Function(Transaction transaction)? detailSetFromCache,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionsFetched value) fetched,
    required TResult Function(TransactionsRefreshed value) refreshed,
    required TResult Function(TransactionsFiltered value) filtered,
    required TResult Function(TransactionsLoadMore value) loadMore,
    required TResult Function(TransactionsAccountChanged value) accountChanged,
    required TResult Function(TransactionDetailFetched value) detailFetched,
    required TResult Function(TransactionDetailSetFromCache value)
        detailSetFromCache,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionsFetched value)? fetched,
    TResult? Function(TransactionsRefreshed value)? refreshed,
    TResult? Function(TransactionsFiltered value)? filtered,
    TResult? Function(TransactionsLoadMore value)? loadMore,
    TResult? Function(TransactionsAccountChanged value)? accountChanged,
    TResult? Function(TransactionDetailFetched value)? detailFetched,
    TResult? Function(TransactionDetailSetFromCache value)? detailSetFromCache,
  }) {
    return fetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionsFetched value)? fetched,
    TResult Function(TransactionsRefreshed value)? refreshed,
    TResult Function(TransactionsFiltered value)? filtered,
    TResult Function(TransactionsLoadMore value)? loadMore,
    TResult Function(TransactionsAccountChanged value)? accountChanged,
    TResult Function(TransactionDetailFetched value)? detailFetched,
    TResult Function(TransactionDetailSetFromCache value)? detailSetFromCache,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class TransactionsFetched implements TransactionsEvent {
  const factory TransactionsFetched() = _$TransactionsFetchedImpl;
}

/// @nodoc
abstract class _$$TransactionsRefreshedImplCopyWith<$Res> {
  factory _$$TransactionsRefreshedImplCopyWith(
          _$TransactionsRefreshedImpl value,
          $Res Function(_$TransactionsRefreshedImpl) then) =
      __$$TransactionsRefreshedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransactionsRefreshedImplCopyWithImpl<$Res>
    extends _$TransactionsEventCopyWithImpl<$Res, _$TransactionsRefreshedImpl>
    implements _$$TransactionsRefreshedImplCopyWith<$Res> {
  __$$TransactionsRefreshedImplCopyWithImpl(_$TransactionsRefreshedImpl _value,
      $Res Function(_$TransactionsRefreshedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TransactionsRefreshedImpl implements TransactionsRefreshed {
  const _$TransactionsRefreshedImpl();

  @override
  String toString() {
    return 'TransactionsEvent.refreshed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionsRefreshedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetched,
    required TResult Function() refreshed,
    required TResult Function(TransactionFilter filter) filtered,
    required TResult Function() loadMore,
    required TResult Function(int accountId) accountChanged,
    required TResult Function(int transactionId, int accountId) detailFetched,
    required TResult Function(Transaction transaction) detailSetFromCache,
  }) {
    return refreshed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetched,
    TResult? Function()? refreshed,
    TResult? Function(TransactionFilter filter)? filtered,
    TResult? Function()? loadMore,
    TResult? Function(int accountId)? accountChanged,
    TResult? Function(int transactionId, int accountId)? detailFetched,
    TResult? Function(Transaction transaction)? detailSetFromCache,
  }) {
    return refreshed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetched,
    TResult Function()? refreshed,
    TResult Function(TransactionFilter filter)? filtered,
    TResult Function()? loadMore,
    TResult Function(int accountId)? accountChanged,
    TResult Function(int transactionId, int accountId)? detailFetched,
    TResult Function(Transaction transaction)? detailSetFromCache,
    required TResult orElse(),
  }) {
    if (refreshed != null) {
      return refreshed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionsFetched value) fetched,
    required TResult Function(TransactionsRefreshed value) refreshed,
    required TResult Function(TransactionsFiltered value) filtered,
    required TResult Function(TransactionsLoadMore value) loadMore,
    required TResult Function(TransactionsAccountChanged value) accountChanged,
    required TResult Function(TransactionDetailFetched value) detailFetched,
    required TResult Function(TransactionDetailSetFromCache value)
        detailSetFromCache,
  }) {
    return refreshed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionsFetched value)? fetched,
    TResult? Function(TransactionsRefreshed value)? refreshed,
    TResult? Function(TransactionsFiltered value)? filtered,
    TResult? Function(TransactionsLoadMore value)? loadMore,
    TResult? Function(TransactionsAccountChanged value)? accountChanged,
    TResult? Function(TransactionDetailFetched value)? detailFetched,
    TResult? Function(TransactionDetailSetFromCache value)? detailSetFromCache,
  }) {
    return refreshed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionsFetched value)? fetched,
    TResult Function(TransactionsRefreshed value)? refreshed,
    TResult Function(TransactionsFiltered value)? filtered,
    TResult Function(TransactionsLoadMore value)? loadMore,
    TResult Function(TransactionsAccountChanged value)? accountChanged,
    TResult Function(TransactionDetailFetched value)? detailFetched,
    TResult Function(TransactionDetailSetFromCache value)? detailSetFromCache,
    required TResult orElse(),
  }) {
    if (refreshed != null) {
      return refreshed(this);
    }
    return orElse();
  }
}

abstract class TransactionsRefreshed implements TransactionsEvent {
  const factory TransactionsRefreshed() = _$TransactionsRefreshedImpl;
}

/// @nodoc
abstract class _$$TransactionsFilteredImplCopyWith<$Res> {
  factory _$$TransactionsFilteredImplCopyWith(_$TransactionsFilteredImpl value,
          $Res Function(_$TransactionsFilteredImpl) then) =
      __$$TransactionsFilteredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TransactionFilter filter});

  $TransactionFilterCopyWith<$Res> get filter;
}

/// @nodoc
class __$$TransactionsFilteredImplCopyWithImpl<$Res>
    extends _$TransactionsEventCopyWithImpl<$Res, _$TransactionsFilteredImpl>
    implements _$$TransactionsFilteredImplCopyWith<$Res> {
  __$$TransactionsFilteredImplCopyWithImpl(_$TransactionsFilteredImpl _value,
      $Res Function(_$TransactionsFilteredImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filter = null,
  }) {
    return _then(_$TransactionsFilteredImpl(
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as TransactionFilter,
    ));
  }

  /// Create a copy of TransactionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionFilterCopyWith<$Res> get filter {
    return $TransactionFilterCopyWith<$Res>(_value.filter, (value) {
      return _then(_value.copyWith(filter: value));
    });
  }
}

/// @nodoc

class _$TransactionsFilteredImpl implements TransactionsFiltered {
  const _$TransactionsFilteredImpl({required this.filter});

  @override
  final TransactionFilter filter;

  @override
  String toString() {
    return 'TransactionsEvent.filtered(filter: $filter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionsFilteredImpl &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filter);

  /// Create a copy of TransactionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionsFilteredImplCopyWith<_$TransactionsFilteredImpl>
      get copyWith =>
          __$$TransactionsFilteredImplCopyWithImpl<_$TransactionsFilteredImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetched,
    required TResult Function() refreshed,
    required TResult Function(TransactionFilter filter) filtered,
    required TResult Function() loadMore,
    required TResult Function(int accountId) accountChanged,
    required TResult Function(int transactionId, int accountId) detailFetched,
    required TResult Function(Transaction transaction) detailSetFromCache,
  }) {
    return filtered(filter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetched,
    TResult? Function()? refreshed,
    TResult? Function(TransactionFilter filter)? filtered,
    TResult? Function()? loadMore,
    TResult? Function(int accountId)? accountChanged,
    TResult? Function(int transactionId, int accountId)? detailFetched,
    TResult? Function(Transaction transaction)? detailSetFromCache,
  }) {
    return filtered?.call(filter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetched,
    TResult Function()? refreshed,
    TResult Function(TransactionFilter filter)? filtered,
    TResult Function()? loadMore,
    TResult Function(int accountId)? accountChanged,
    TResult Function(int transactionId, int accountId)? detailFetched,
    TResult Function(Transaction transaction)? detailSetFromCache,
    required TResult orElse(),
  }) {
    if (filtered != null) {
      return filtered(filter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionsFetched value) fetched,
    required TResult Function(TransactionsRefreshed value) refreshed,
    required TResult Function(TransactionsFiltered value) filtered,
    required TResult Function(TransactionsLoadMore value) loadMore,
    required TResult Function(TransactionsAccountChanged value) accountChanged,
    required TResult Function(TransactionDetailFetched value) detailFetched,
    required TResult Function(TransactionDetailSetFromCache value)
        detailSetFromCache,
  }) {
    return filtered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionsFetched value)? fetched,
    TResult? Function(TransactionsRefreshed value)? refreshed,
    TResult? Function(TransactionsFiltered value)? filtered,
    TResult? Function(TransactionsLoadMore value)? loadMore,
    TResult? Function(TransactionsAccountChanged value)? accountChanged,
    TResult? Function(TransactionDetailFetched value)? detailFetched,
    TResult? Function(TransactionDetailSetFromCache value)? detailSetFromCache,
  }) {
    return filtered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionsFetched value)? fetched,
    TResult Function(TransactionsRefreshed value)? refreshed,
    TResult Function(TransactionsFiltered value)? filtered,
    TResult Function(TransactionsLoadMore value)? loadMore,
    TResult Function(TransactionsAccountChanged value)? accountChanged,
    TResult Function(TransactionDetailFetched value)? detailFetched,
    TResult Function(TransactionDetailSetFromCache value)? detailSetFromCache,
    required TResult orElse(),
  }) {
    if (filtered != null) {
      return filtered(this);
    }
    return orElse();
  }
}

abstract class TransactionsFiltered implements TransactionsEvent {
  const factory TransactionsFiltered(
      {required final TransactionFilter filter}) = _$TransactionsFilteredImpl;

  TransactionFilter get filter;

  /// Create a copy of TransactionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionsFilteredImplCopyWith<_$TransactionsFilteredImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransactionsLoadMoreImplCopyWith<$Res> {
  factory _$$TransactionsLoadMoreImplCopyWith(_$TransactionsLoadMoreImpl value,
          $Res Function(_$TransactionsLoadMoreImpl) then) =
      __$$TransactionsLoadMoreImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransactionsLoadMoreImplCopyWithImpl<$Res>
    extends _$TransactionsEventCopyWithImpl<$Res, _$TransactionsLoadMoreImpl>
    implements _$$TransactionsLoadMoreImplCopyWith<$Res> {
  __$$TransactionsLoadMoreImplCopyWithImpl(_$TransactionsLoadMoreImpl _value,
      $Res Function(_$TransactionsLoadMoreImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TransactionsLoadMoreImpl implements TransactionsLoadMore {
  const _$TransactionsLoadMoreImpl();

  @override
  String toString() {
    return 'TransactionsEvent.loadMore()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionsLoadMoreImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetched,
    required TResult Function() refreshed,
    required TResult Function(TransactionFilter filter) filtered,
    required TResult Function() loadMore,
    required TResult Function(int accountId) accountChanged,
    required TResult Function(int transactionId, int accountId) detailFetched,
    required TResult Function(Transaction transaction) detailSetFromCache,
  }) {
    return loadMore();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetched,
    TResult? Function()? refreshed,
    TResult? Function(TransactionFilter filter)? filtered,
    TResult? Function()? loadMore,
    TResult? Function(int accountId)? accountChanged,
    TResult? Function(int transactionId, int accountId)? detailFetched,
    TResult? Function(Transaction transaction)? detailSetFromCache,
  }) {
    return loadMore?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetched,
    TResult Function()? refreshed,
    TResult Function(TransactionFilter filter)? filtered,
    TResult Function()? loadMore,
    TResult Function(int accountId)? accountChanged,
    TResult Function(int transactionId, int accountId)? detailFetched,
    TResult Function(Transaction transaction)? detailSetFromCache,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionsFetched value) fetched,
    required TResult Function(TransactionsRefreshed value) refreshed,
    required TResult Function(TransactionsFiltered value) filtered,
    required TResult Function(TransactionsLoadMore value) loadMore,
    required TResult Function(TransactionsAccountChanged value) accountChanged,
    required TResult Function(TransactionDetailFetched value) detailFetched,
    required TResult Function(TransactionDetailSetFromCache value)
        detailSetFromCache,
  }) {
    return loadMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionsFetched value)? fetched,
    TResult? Function(TransactionsRefreshed value)? refreshed,
    TResult? Function(TransactionsFiltered value)? filtered,
    TResult? Function(TransactionsLoadMore value)? loadMore,
    TResult? Function(TransactionsAccountChanged value)? accountChanged,
    TResult? Function(TransactionDetailFetched value)? detailFetched,
    TResult? Function(TransactionDetailSetFromCache value)? detailSetFromCache,
  }) {
    return loadMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionsFetched value)? fetched,
    TResult Function(TransactionsRefreshed value)? refreshed,
    TResult Function(TransactionsFiltered value)? filtered,
    TResult Function(TransactionsLoadMore value)? loadMore,
    TResult Function(TransactionsAccountChanged value)? accountChanged,
    TResult Function(TransactionDetailFetched value)? detailFetched,
    TResult Function(TransactionDetailSetFromCache value)? detailSetFromCache,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore(this);
    }
    return orElse();
  }
}

abstract class TransactionsLoadMore implements TransactionsEvent {
  const factory TransactionsLoadMore() = _$TransactionsLoadMoreImpl;
}

/// @nodoc
abstract class _$$TransactionsAccountChangedImplCopyWith<$Res> {
  factory _$$TransactionsAccountChangedImplCopyWith(
          _$TransactionsAccountChangedImpl value,
          $Res Function(_$TransactionsAccountChangedImpl) then) =
      __$$TransactionsAccountChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int accountId});
}

/// @nodoc
class __$$TransactionsAccountChangedImplCopyWithImpl<$Res>
    extends _$TransactionsEventCopyWithImpl<$Res,
        _$TransactionsAccountChangedImpl>
    implements _$$TransactionsAccountChangedImplCopyWith<$Res> {
  __$$TransactionsAccountChangedImplCopyWithImpl(
      _$TransactionsAccountChangedImpl _value,
      $Res Function(_$TransactionsAccountChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
  }) {
    return _then(_$TransactionsAccountChangedImpl(
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TransactionsAccountChangedImpl implements TransactionsAccountChanged {
  const _$TransactionsAccountChangedImpl({required this.accountId});

  @override
  final int accountId;

  @override
  String toString() {
    return 'TransactionsEvent.accountChanged(accountId: $accountId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionsAccountChangedImpl &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accountId);

  /// Create a copy of TransactionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionsAccountChangedImplCopyWith<_$TransactionsAccountChangedImpl>
      get copyWith => __$$TransactionsAccountChangedImplCopyWithImpl<
          _$TransactionsAccountChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetched,
    required TResult Function() refreshed,
    required TResult Function(TransactionFilter filter) filtered,
    required TResult Function() loadMore,
    required TResult Function(int accountId) accountChanged,
    required TResult Function(int transactionId, int accountId) detailFetched,
    required TResult Function(Transaction transaction) detailSetFromCache,
  }) {
    return accountChanged(accountId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetched,
    TResult? Function()? refreshed,
    TResult? Function(TransactionFilter filter)? filtered,
    TResult? Function()? loadMore,
    TResult? Function(int accountId)? accountChanged,
    TResult? Function(int transactionId, int accountId)? detailFetched,
    TResult? Function(Transaction transaction)? detailSetFromCache,
  }) {
    return accountChanged?.call(accountId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetched,
    TResult Function()? refreshed,
    TResult Function(TransactionFilter filter)? filtered,
    TResult Function()? loadMore,
    TResult Function(int accountId)? accountChanged,
    TResult Function(int transactionId, int accountId)? detailFetched,
    TResult Function(Transaction transaction)? detailSetFromCache,
    required TResult orElse(),
  }) {
    if (accountChanged != null) {
      return accountChanged(accountId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionsFetched value) fetched,
    required TResult Function(TransactionsRefreshed value) refreshed,
    required TResult Function(TransactionsFiltered value) filtered,
    required TResult Function(TransactionsLoadMore value) loadMore,
    required TResult Function(TransactionsAccountChanged value) accountChanged,
    required TResult Function(TransactionDetailFetched value) detailFetched,
    required TResult Function(TransactionDetailSetFromCache value)
        detailSetFromCache,
  }) {
    return accountChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionsFetched value)? fetched,
    TResult? Function(TransactionsRefreshed value)? refreshed,
    TResult? Function(TransactionsFiltered value)? filtered,
    TResult? Function(TransactionsLoadMore value)? loadMore,
    TResult? Function(TransactionsAccountChanged value)? accountChanged,
    TResult? Function(TransactionDetailFetched value)? detailFetched,
    TResult? Function(TransactionDetailSetFromCache value)? detailSetFromCache,
  }) {
    return accountChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionsFetched value)? fetched,
    TResult Function(TransactionsRefreshed value)? refreshed,
    TResult Function(TransactionsFiltered value)? filtered,
    TResult Function(TransactionsLoadMore value)? loadMore,
    TResult Function(TransactionsAccountChanged value)? accountChanged,
    TResult Function(TransactionDetailFetched value)? detailFetched,
    TResult Function(TransactionDetailSetFromCache value)? detailSetFromCache,
    required TResult orElse(),
  }) {
    if (accountChanged != null) {
      return accountChanged(this);
    }
    return orElse();
  }
}

abstract class TransactionsAccountChanged implements TransactionsEvent {
  const factory TransactionsAccountChanged({required final int accountId}) =
      _$TransactionsAccountChangedImpl;

  int get accountId;

  /// Create a copy of TransactionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionsAccountChangedImplCopyWith<_$TransactionsAccountChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
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
    extends _$TransactionsEventCopyWithImpl<$Res,
        _$TransactionDetailFetchedImpl>
    implements _$$TransactionDetailFetchedImplCopyWith<$Res> {
  __$$TransactionDetailFetchedImplCopyWithImpl(
      _$TransactionDetailFetchedImpl _value,
      $Res Function(_$TransactionDetailFetchedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionsEvent
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
    return 'TransactionsEvent.detailFetched(transactionId: $transactionId, accountId: $accountId)';
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

  /// Create a copy of TransactionsEvent
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
    required TResult Function() fetched,
    required TResult Function() refreshed,
    required TResult Function(TransactionFilter filter) filtered,
    required TResult Function() loadMore,
    required TResult Function(int accountId) accountChanged,
    required TResult Function(int transactionId, int accountId) detailFetched,
    required TResult Function(Transaction transaction) detailSetFromCache,
  }) {
    return detailFetched(transactionId, accountId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetched,
    TResult? Function()? refreshed,
    TResult? Function(TransactionFilter filter)? filtered,
    TResult? Function()? loadMore,
    TResult? Function(int accountId)? accountChanged,
    TResult? Function(int transactionId, int accountId)? detailFetched,
    TResult? Function(Transaction transaction)? detailSetFromCache,
  }) {
    return detailFetched?.call(transactionId, accountId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetched,
    TResult Function()? refreshed,
    TResult Function(TransactionFilter filter)? filtered,
    TResult Function()? loadMore,
    TResult Function(int accountId)? accountChanged,
    TResult Function(int transactionId, int accountId)? detailFetched,
    TResult Function(Transaction transaction)? detailSetFromCache,
    required TResult orElse(),
  }) {
    if (detailFetched != null) {
      return detailFetched(transactionId, accountId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionsFetched value) fetched,
    required TResult Function(TransactionsRefreshed value) refreshed,
    required TResult Function(TransactionsFiltered value) filtered,
    required TResult Function(TransactionsLoadMore value) loadMore,
    required TResult Function(TransactionsAccountChanged value) accountChanged,
    required TResult Function(TransactionDetailFetched value) detailFetched,
    required TResult Function(TransactionDetailSetFromCache value)
        detailSetFromCache,
  }) {
    return detailFetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionsFetched value)? fetched,
    TResult? Function(TransactionsRefreshed value)? refreshed,
    TResult? Function(TransactionsFiltered value)? filtered,
    TResult? Function(TransactionsLoadMore value)? loadMore,
    TResult? Function(TransactionsAccountChanged value)? accountChanged,
    TResult? Function(TransactionDetailFetched value)? detailFetched,
    TResult? Function(TransactionDetailSetFromCache value)? detailSetFromCache,
  }) {
    return detailFetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionsFetched value)? fetched,
    TResult Function(TransactionsRefreshed value)? refreshed,
    TResult Function(TransactionsFiltered value)? filtered,
    TResult Function(TransactionsLoadMore value)? loadMore,
    TResult Function(TransactionsAccountChanged value)? accountChanged,
    TResult Function(TransactionDetailFetched value)? detailFetched,
    TResult Function(TransactionDetailSetFromCache value)? detailSetFromCache,
    required TResult orElse(),
  }) {
    if (detailFetched != null) {
      return detailFetched(this);
    }
    return orElse();
  }
}

abstract class TransactionDetailFetched implements TransactionsEvent {
  const factory TransactionDetailFetched(
      {required final int transactionId,
      final int accountId}) = _$TransactionDetailFetchedImpl;

  int get transactionId;
  int get accountId;

  /// Create a copy of TransactionsEvent
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
    extends _$TransactionsEventCopyWithImpl<$Res,
        _$TransactionDetailSetFromCacheImpl>
    implements _$$TransactionDetailSetFromCacheImplCopyWith<$Res> {
  __$$TransactionDetailSetFromCacheImplCopyWithImpl(
      _$TransactionDetailSetFromCacheImpl _value,
      $Res Function(_$TransactionDetailSetFromCacheImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionsEvent
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

  /// Create a copy of TransactionsEvent
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
    return 'TransactionsEvent.detailSetFromCache(transaction: $transaction)';
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

  /// Create a copy of TransactionsEvent
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
    required TResult Function() fetched,
    required TResult Function() refreshed,
    required TResult Function(TransactionFilter filter) filtered,
    required TResult Function() loadMore,
    required TResult Function(int accountId) accountChanged,
    required TResult Function(int transactionId, int accountId) detailFetched,
    required TResult Function(Transaction transaction) detailSetFromCache,
  }) {
    return detailSetFromCache(transaction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetched,
    TResult? Function()? refreshed,
    TResult? Function(TransactionFilter filter)? filtered,
    TResult? Function()? loadMore,
    TResult? Function(int accountId)? accountChanged,
    TResult? Function(int transactionId, int accountId)? detailFetched,
    TResult? Function(Transaction transaction)? detailSetFromCache,
  }) {
    return detailSetFromCache?.call(transaction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetched,
    TResult Function()? refreshed,
    TResult Function(TransactionFilter filter)? filtered,
    TResult Function()? loadMore,
    TResult Function(int accountId)? accountChanged,
    TResult Function(int transactionId, int accountId)? detailFetched,
    TResult Function(Transaction transaction)? detailSetFromCache,
    required TResult orElse(),
  }) {
    if (detailSetFromCache != null) {
      return detailSetFromCache(transaction);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionsFetched value) fetched,
    required TResult Function(TransactionsRefreshed value) refreshed,
    required TResult Function(TransactionsFiltered value) filtered,
    required TResult Function(TransactionsLoadMore value) loadMore,
    required TResult Function(TransactionsAccountChanged value) accountChanged,
    required TResult Function(TransactionDetailFetched value) detailFetched,
    required TResult Function(TransactionDetailSetFromCache value)
        detailSetFromCache,
  }) {
    return detailSetFromCache(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionsFetched value)? fetched,
    TResult? Function(TransactionsRefreshed value)? refreshed,
    TResult? Function(TransactionsFiltered value)? filtered,
    TResult? Function(TransactionsLoadMore value)? loadMore,
    TResult? Function(TransactionsAccountChanged value)? accountChanged,
    TResult? Function(TransactionDetailFetched value)? detailFetched,
    TResult? Function(TransactionDetailSetFromCache value)? detailSetFromCache,
  }) {
    return detailSetFromCache?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionsFetched value)? fetched,
    TResult Function(TransactionsRefreshed value)? refreshed,
    TResult Function(TransactionsFiltered value)? filtered,
    TResult Function(TransactionsLoadMore value)? loadMore,
    TResult Function(TransactionsAccountChanged value)? accountChanged,
    TResult Function(TransactionDetailFetched value)? detailFetched,
    TResult Function(TransactionDetailSetFromCache value)? detailSetFromCache,
    required TResult orElse(),
  }) {
    if (detailSetFromCache != null) {
      return detailSetFromCache(this);
    }
    return orElse();
  }
}

abstract class TransactionDetailSetFromCache implements TransactionsEvent {
  const factory TransactionDetailSetFromCache(
          {required final Transaction transaction}) =
      _$TransactionDetailSetFromCacheImpl;

  Transaction get transaction;

  /// Create a copy of TransactionsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionDetailSetFromCacheImplCopyWith<
          _$TransactionDetailSetFromCacheImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransactionsState {
// List status
  TransactionsListStatus get listStatus => throw _privateConstructorUsedError;
  String get listErrorMessage =>
      throw _privateConstructorUsedError; // Detail status
  TransactionsDetailStatus get detailStatus =>
      throw _privateConstructorUsedError;
  String get detailErrorMessage =>
      throw _privateConstructorUsedError; // Common data
  int get accountId => throw _privateConstructorUsedError; // List data
  PaginatedTransactions? get paginatedTransactions =>
      throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  bool get hasReachedMax => throw _privateConstructorUsedError;
  TransactionFilter? get filter =>
      throw _privateConstructorUsedError; // Detail data
  Transaction? get selectedTransaction => throw _privateConstructorUsedError;

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionsStateCopyWith<TransactionsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionsStateCopyWith<$Res> {
  factory $TransactionsStateCopyWith(
          TransactionsState value, $Res Function(TransactionsState) then) =
      _$TransactionsStateCopyWithImpl<$Res, TransactionsState>;
  @useResult
  $Res call(
      {TransactionsListStatus listStatus,
      String listErrorMessage,
      TransactionsDetailStatus detailStatus,
      String detailErrorMessage,
      int accountId,
      PaginatedTransactions? paginatedTransactions,
      int currentPage,
      int pageSize,
      bool hasReachedMax,
      TransactionFilter? filter,
      Transaction? selectedTransaction});

  $PaginatedTransactionsCopyWith<$Res>? get paginatedTransactions;
  $TransactionFilterCopyWith<$Res>? get filter;
  $TransactionCopyWith<$Res>? get selectedTransaction;
}

/// @nodoc
class _$TransactionsStateCopyWithImpl<$Res, $Val extends TransactionsState>
    implements $TransactionsStateCopyWith<$Res> {
  _$TransactionsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listStatus = null,
    Object? listErrorMessage = null,
    Object? detailStatus = null,
    Object? detailErrorMessage = null,
    Object? accountId = null,
    Object? paginatedTransactions = freezed,
    Object? currentPage = null,
    Object? pageSize = null,
    Object? hasReachedMax = null,
    Object? filter = freezed,
    Object? selectedTransaction = freezed,
  }) {
    return _then(_value.copyWith(
      listStatus: null == listStatus
          ? _value.listStatus
          : listStatus // ignore: cast_nullable_to_non_nullable
              as TransactionsListStatus,
      listErrorMessage: null == listErrorMessage
          ? _value.listErrorMessage
          : listErrorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      detailStatus: null == detailStatus
          ? _value.detailStatus
          : detailStatus // ignore: cast_nullable_to_non_nullable
              as TransactionsDetailStatus,
      detailErrorMessage: null == detailErrorMessage
          ? _value.detailErrorMessage
          : detailErrorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      paginatedTransactions: freezed == paginatedTransactions
          ? _value.paginatedTransactions
          : paginatedTransactions // ignore: cast_nullable_to_non_nullable
              as PaginatedTransactions?,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      hasReachedMax: null == hasReachedMax
          ? _value.hasReachedMax
          : hasReachedMax // ignore: cast_nullable_to_non_nullable
              as bool,
      filter: freezed == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as TransactionFilter?,
      selectedTransaction: freezed == selectedTransaction
          ? _value.selectedTransaction
          : selectedTransaction // ignore: cast_nullable_to_non_nullable
              as Transaction?,
    ) as $Val);
  }

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginatedTransactionsCopyWith<$Res>? get paginatedTransactions {
    if (_value.paginatedTransactions == null) {
      return null;
    }

    return $PaginatedTransactionsCopyWith<$Res>(_value.paginatedTransactions!,
        (value) {
      return _then(_value.copyWith(paginatedTransactions: value) as $Val);
    });
  }

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionFilterCopyWith<$Res>? get filter {
    if (_value.filter == null) {
      return null;
    }

    return $TransactionFilterCopyWith<$Res>(_value.filter!, (value) {
      return _then(_value.copyWith(filter: value) as $Val);
    });
  }

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionCopyWith<$Res>? get selectedTransaction {
    if (_value.selectedTransaction == null) {
      return null;
    }

    return $TransactionCopyWith<$Res>(_value.selectedTransaction!, (value) {
      return _then(_value.copyWith(selectedTransaction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransactionsStateImplCopyWith<$Res>
    implements $TransactionsStateCopyWith<$Res> {
  factory _$$TransactionsStateImplCopyWith(_$TransactionsStateImpl value,
          $Res Function(_$TransactionsStateImpl) then) =
      __$$TransactionsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TransactionsListStatus listStatus,
      String listErrorMessage,
      TransactionsDetailStatus detailStatus,
      String detailErrorMessage,
      int accountId,
      PaginatedTransactions? paginatedTransactions,
      int currentPage,
      int pageSize,
      bool hasReachedMax,
      TransactionFilter? filter,
      Transaction? selectedTransaction});

  @override
  $PaginatedTransactionsCopyWith<$Res>? get paginatedTransactions;
  @override
  $TransactionFilterCopyWith<$Res>? get filter;
  @override
  $TransactionCopyWith<$Res>? get selectedTransaction;
}

/// @nodoc
class __$$TransactionsStateImplCopyWithImpl<$Res>
    extends _$TransactionsStateCopyWithImpl<$Res, _$TransactionsStateImpl>
    implements _$$TransactionsStateImplCopyWith<$Res> {
  __$$TransactionsStateImplCopyWithImpl(_$TransactionsStateImpl _value,
      $Res Function(_$TransactionsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listStatus = null,
    Object? listErrorMessage = null,
    Object? detailStatus = null,
    Object? detailErrorMessage = null,
    Object? accountId = null,
    Object? paginatedTransactions = freezed,
    Object? currentPage = null,
    Object? pageSize = null,
    Object? hasReachedMax = null,
    Object? filter = freezed,
    Object? selectedTransaction = freezed,
  }) {
    return _then(_$TransactionsStateImpl(
      listStatus: null == listStatus
          ? _value.listStatus
          : listStatus // ignore: cast_nullable_to_non_nullable
              as TransactionsListStatus,
      listErrorMessage: null == listErrorMessage
          ? _value.listErrorMessage
          : listErrorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      detailStatus: null == detailStatus
          ? _value.detailStatus
          : detailStatus // ignore: cast_nullable_to_non_nullable
              as TransactionsDetailStatus,
      detailErrorMessage: null == detailErrorMessage
          ? _value.detailErrorMessage
          : detailErrorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      paginatedTransactions: freezed == paginatedTransactions
          ? _value.paginatedTransactions
          : paginatedTransactions // ignore: cast_nullable_to_non_nullable
              as PaginatedTransactions?,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      hasReachedMax: null == hasReachedMax
          ? _value.hasReachedMax
          : hasReachedMax // ignore: cast_nullable_to_non_nullable
              as bool,
      filter: freezed == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as TransactionFilter?,
      selectedTransaction: freezed == selectedTransaction
          ? _value.selectedTransaction
          : selectedTransaction // ignore: cast_nullable_to_non_nullable
              as Transaction?,
    ));
  }
}

/// @nodoc

class _$TransactionsStateImpl implements _TransactionsState {
  const _$TransactionsStateImpl(
      {this.listStatus = TransactionsListStatus.initial,
      this.listErrorMessage = '',
      this.detailStatus = TransactionsDetailStatus.initial,
      this.detailErrorMessage = '',
      this.accountId = 0,
      this.paginatedTransactions,
      this.currentPage = 1,
      this.pageSize = 5,
      this.hasReachedMax = false,
      this.filter,
      this.selectedTransaction});

// List status
  @override
  @JsonKey()
  final TransactionsListStatus listStatus;
  @override
  @JsonKey()
  final String listErrorMessage;
// Detail status
  @override
  @JsonKey()
  final TransactionsDetailStatus detailStatus;
  @override
  @JsonKey()
  final String detailErrorMessage;
// Common data
  @override
  @JsonKey()
  final int accountId;
// List data
  @override
  final PaginatedTransactions? paginatedTransactions;
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int pageSize;
  @override
  @JsonKey()
  final bool hasReachedMax;
  @override
  final TransactionFilter? filter;
// Detail data
  @override
  final Transaction? selectedTransaction;

  @override
  String toString() {
    return 'TransactionsState(listStatus: $listStatus, listErrorMessage: $listErrorMessage, detailStatus: $detailStatus, detailErrorMessage: $detailErrorMessage, accountId: $accountId, paginatedTransactions: $paginatedTransactions, currentPage: $currentPage, pageSize: $pageSize, hasReachedMax: $hasReachedMax, filter: $filter, selectedTransaction: $selectedTransaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionsStateImpl &&
            (identical(other.listStatus, listStatus) ||
                other.listStatus == listStatus) &&
            (identical(other.listErrorMessage, listErrorMessage) ||
                other.listErrorMessage == listErrorMessage) &&
            (identical(other.detailStatus, detailStatus) ||
                other.detailStatus == detailStatus) &&
            (identical(other.detailErrorMessage, detailErrorMessage) ||
                other.detailErrorMessage == detailErrorMessage) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.paginatedTransactions, paginatedTransactions) ||
                other.paginatedTransactions == paginatedTransactions) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.hasReachedMax, hasReachedMax) ||
                other.hasReachedMax == hasReachedMax) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.selectedTransaction, selectedTransaction) ||
                other.selectedTransaction == selectedTransaction));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      listStatus,
      listErrorMessage,
      detailStatus,
      detailErrorMessage,
      accountId,
      paginatedTransactions,
      currentPage,
      pageSize,
      hasReachedMax,
      filter,
      selectedTransaction);

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionsStateImplCopyWith<_$TransactionsStateImpl> get copyWith =>
      __$$TransactionsStateImplCopyWithImpl<_$TransactionsStateImpl>(
          this, _$identity);
}

abstract class _TransactionsState implements TransactionsState {
  const factory _TransactionsState(
      {final TransactionsListStatus listStatus,
      final String listErrorMessage,
      final TransactionsDetailStatus detailStatus,
      final String detailErrorMessage,
      final int accountId,
      final PaginatedTransactions? paginatedTransactions,
      final int currentPage,
      final int pageSize,
      final bool hasReachedMax,
      final TransactionFilter? filter,
      final Transaction? selectedTransaction}) = _$TransactionsStateImpl;

// List status
  @override
  TransactionsListStatus get listStatus;
  @override
  String get listErrorMessage; // Detail status
  @override
  TransactionsDetailStatus get detailStatus;
  @override
  String get detailErrorMessage; // Common data
  @override
  int get accountId; // List data
  @override
  PaginatedTransactions? get paginatedTransactions;
  @override
  int get currentPage;
  @override
  int get pageSize;
  @override
  bool get hasReachedMax;
  @override
  TransactionFilter? get filter; // Detail data
  @override
  Transaction? get selectedTransaction;

  /// Create a copy of TransactionsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionsStateImplCopyWith<_$TransactionsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
