// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_history_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransactionHistoryEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetched,
    required TResult Function() refreshed,
    required TResult Function(TransactionFilter filter) filtered,
    required TResult Function() loadMore,
    required TResult Function(int accountId) accountChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetched,
    TResult? Function()? refreshed,
    TResult? Function(TransactionFilter filter)? filtered,
    TResult? Function()? loadMore,
    TResult? Function(int accountId)? accountChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetched,
    TResult Function()? refreshed,
    TResult Function(TransactionFilter filter)? filtered,
    TResult Function()? loadMore,
    TResult Function(int accountId)? accountChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionHistoryFetched value) fetched,
    required TResult Function(TransactionHistoryRefreshed value) refreshed,
    required TResult Function(TransactionHistoryFiltered value) filtered,
    required TResult Function(TransactionHistoryLoadMore value) loadMore,
    required TResult Function(TransactionHistoryAccountChanged value)
        accountChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionHistoryFetched value)? fetched,
    TResult? Function(TransactionHistoryRefreshed value)? refreshed,
    TResult? Function(TransactionHistoryFiltered value)? filtered,
    TResult? Function(TransactionHistoryLoadMore value)? loadMore,
    TResult? Function(TransactionHistoryAccountChanged value)? accountChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionHistoryFetched value)? fetched,
    TResult Function(TransactionHistoryRefreshed value)? refreshed,
    TResult Function(TransactionHistoryFiltered value)? filtered,
    TResult Function(TransactionHistoryLoadMore value)? loadMore,
    TResult Function(TransactionHistoryAccountChanged value)? accountChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionHistoryEventCopyWith<$Res> {
  factory $TransactionHistoryEventCopyWith(TransactionHistoryEvent value,
          $Res Function(TransactionHistoryEvent) then) =
      _$TransactionHistoryEventCopyWithImpl<$Res, TransactionHistoryEvent>;
}

/// @nodoc
class _$TransactionHistoryEventCopyWithImpl<$Res,
        $Val extends TransactionHistoryEvent>
    implements $TransactionHistoryEventCopyWith<$Res> {
  _$TransactionHistoryEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionHistoryEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TransactionHistoryFetchedImplCopyWith<$Res> {
  factory _$$TransactionHistoryFetchedImplCopyWith(
          _$TransactionHistoryFetchedImpl value,
          $Res Function(_$TransactionHistoryFetchedImpl) then) =
      __$$TransactionHistoryFetchedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransactionHistoryFetchedImplCopyWithImpl<$Res>
    extends _$TransactionHistoryEventCopyWithImpl<$Res,
        _$TransactionHistoryFetchedImpl>
    implements _$$TransactionHistoryFetchedImplCopyWith<$Res> {
  __$$TransactionHistoryFetchedImplCopyWithImpl(
      _$TransactionHistoryFetchedImpl _value,
      $Res Function(_$TransactionHistoryFetchedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionHistoryEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TransactionHistoryFetchedImpl implements TransactionHistoryFetched {
  const _$TransactionHistoryFetchedImpl();

  @override
  String toString() {
    return 'TransactionHistoryEvent.fetched()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionHistoryFetchedImpl);
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
    required TResult Function(TransactionHistoryFetched value) fetched,
    required TResult Function(TransactionHistoryRefreshed value) refreshed,
    required TResult Function(TransactionHistoryFiltered value) filtered,
    required TResult Function(TransactionHistoryLoadMore value) loadMore,
    required TResult Function(TransactionHistoryAccountChanged value)
        accountChanged,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionHistoryFetched value)? fetched,
    TResult? Function(TransactionHistoryRefreshed value)? refreshed,
    TResult? Function(TransactionHistoryFiltered value)? filtered,
    TResult? Function(TransactionHistoryLoadMore value)? loadMore,
    TResult? Function(TransactionHistoryAccountChanged value)? accountChanged,
  }) {
    return fetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionHistoryFetched value)? fetched,
    TResult Function(TransactionHistoryRefreshed value)? refreshed,
    TResult Function(TransactionHistoryFiltered value)? filtered,
    TResult Function(TransactionHistoryLoadMore value)? loadMore,
    TResult Function(TransactionHistoryAccountChanged value)? accountChanged,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class TransactionHistoryFetched implements TransactionHistoryEvent {
  const factory TransactionHistoryFetched() = _$TransactionHistoryFetchedImpl;
}

/// @nodoc
abstract class _$$TransactionHistoryRefreshedImplCopyWith<$Res> {
  factory _$$TransactionHistoryRefreshedImplCopyWith(
          _$TransactionHistoryRefreshedImpl value,
          $Res Function(_$TransactionHistoryRefreshedImpl) then) =
      __$$TransactionHistoryRefreshedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransactionHistoryRefreshedImplCopyWithImpl<$Res>
    extends _$TransactionHistoryEventCopyWithImpl<$Res,
        _$TransactionHistoryRefreshedImpl>
    implements _$$TransactionHistoryRefreshedImplCopyWith<$Res> {
  __$$TransactionHistoryRefreshedImplCopyWithImpl(
      _$TransactionHistoryRefreshedImpl _value,
      $Res Function(_$TransactionHistoryRefreshedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionHistoryEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TransactionHistoryRefreshedImpl implements TransactionHistoryRefreshed {
  const _$TransactionHistoryRefreshedImpl();

  @override
  String toString() {
    return 'TransactionHistoryEvent.refreshed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionHistoryRefreshedImpl);
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
    required TResult Function(TransactionHistoryFetched value) fetched,
    required TResult Function(TransactionHistoryRefreshed value) refreshed,
    required TResult Function(TransactionHistoryFiltered value) filtered,
    required TResult Function(TransactionHistoryLoadMore value) loadMore,
    required TResult Function(TransactionHistoryAccountChanged value)
        accountChanged,
  }) {
    return refreshed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionHistoryFetched value)? fetched,
    TResult? Function(TransactionHistoryRefreshed value)? refreshed,
    TResult? Function(TransactionHistoryFiltered value)? filtered,
    TResult? Function(TransactionHistoryLoadMore value)? loadMore,
    TResult? Function(TransactionHistoryAccountChanged value)? accountChanged,
  }) {
    return refreshed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionHistoryFetched value)? fetched,
    TResult Function(TransactionHistoryRefreshed value)? refreshed,
    TResult Function(TransactionHistoryFiltered value)? filtered,
    TResult Function(TransactionHistoryLoadMore value)? loadMore,
    TResult Function(TransactionHistoryAccountChanged value)? accountChanged,
    required TResult orElse(),
  }) {
    if (refreshed != null) {
      return refreshed(this);
    }
    return orElse();
  }
}

abstract class TransactionHistoryRefreshed implements TransactionHistoryEvent {
  const factory TransactionHistoryRefreshed() =
      _$TransactionHistoryRefreshedImpl;
}

/// @nodoc
abstract class _$$TransactionHistoryFilteredImplCopyWith<$Res> {
  factory _$$TransactionHistoryFilteredImplCopyWith(
          _$TransactionHistoryFilteredImpl value,
          $Res Function(_$TransactionHistoryFilteredImpl) then) =
      __$$TransactionHistoryFilteredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TransactionFilter filter});

  $TransactionFilterCopyWith<$Res> get filter;
}

/// @nodoc
class __$$TransactionHistoryFilteredImplCopyWithImpl<$Res>
    extends _$TransactionHistoryEventCopyWithImpl<$Res,
        _$TransactionHistoryFilteredImpl>
    implements _$$TransactionHistoryFilteredImplCopyWith<$Res> {
  __$$TransactionHistoryFilteredImplCopyWithImpl(
      _$TransactionHistoryFilteredImpl _value,
      $Res Function(_$TransactionHistoryFilteredImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionHistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filter = null,
  }) {
    return _then(_$TransactionHistoryFilteredImpl(
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as TransactionFilter,
    ));
  }

  /// Create a copy of TransactionHistoryEvent
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

class _$TransactionHistoryFilteredImpl implements TransactionHistoryFiltered {
  const _$TransactionHistoryFilteredImpl({required this.filter});

  @override
  final TransactionFilter filter;

  @override
  String toString() {
    return 'TransactionHistoryEvent.filtered(filter: $filter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionHistoryFilteredImpl &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filter);

  /// Create a copy of TransactionHistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionHistoryFilteredImplCopyWith<_$TransactionHistoryFilteredImpl>
      get copyWith => __$$TransactionHistoryFilteredImplCopyWithImpl<
          _$TransactionHistoryFilteredImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetched,
    required TResult Function() refreshed,
    required TResult Function(TransactionFilter filter) filtered,
    required TResult Function() loadMore,
    required TResult Function(int accountId) accountChanged,
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
    required TResult Function(TransactionHistoryFetched value) fetched,
    required TResult Function(TransactionHistoryRefreshed value) refreshed,
    required TResult Function(TransactionHistoryFiltered value) filtered,
    required TResult Function(TransactionHistoryLoadMore value) loadMore,
    required TResult Function(TransactionHistoryAccountChanged value)
        accountChanged,
  }) {
    return filtered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionHistoryFetched value)? fetched,
    TResult? Function(TransactionHistoryRefreshed value)? refreshed,
    TResult? Function(TransactionHistoryFiltered value)? filtered,
    TResult? Function(TransactionHistoryLoadMore value)? loadMore,
    TResult? Function(TransactionHistoryAccountChanged value)? accountChanged,
  }) {
    return filtered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionHistoryFetched value)? fetched,
    TResult Function(TransactionHistoryRefreshed value)? refreshed,
    TResult Function(TransactionHistoryFiltered value)? filtered,
    TResult Function(TransactionHistoryLoadMore value)? loadMore,
    TResult Function(TransactionHistoryAccountChanged value)? accountChanged,
    required TResult orElse(),
  }) {
    if (filtered != null) {
      return filtered(this);
    }
    return orElse();
  }
}

abstract class TransactionHistoryFiltered implements TransactionHistoryEvent {
  const factory TransactionHistoryFiltered(
          {required final TransactionFilter filter}) =
      _$TransactionHistoryFilteredImpl;

  TransactionFilter get filter;

  /// Create a copy of TransactionHistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionHistoryFilteredImplCopyWith<_$TransactionHistoryFilteredImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransactionHistoryLoadMoreImplCopyWith<$Res> {
  factory _$$TransactionHistoryLoadMoreImplCopyWith(
          _$TransactionHistoryLoadMoreImpl value,
          $Res Function(_$TransactionHistoryLoadMoreImpl) then) =
      __$$TransactionHistoryLoadMoreImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransactionHistoryLoadMoreImplCopyWithImpl<$Res>
    extends _$TransactionHistoryEventCopyWithImpl<$Res,
        _$TransactionHistoryLoadMoreImpl>
    implements _$$TransactionHistoryLoadMoreImplCopyWith<$Res> {
  __$$TransactionHistoryLoadMoreImplCopyWithImpl(
      _$TransactionHistoryLoadMoreImpl _value,
      $Res Function(_$TransactionHistoryLoadMoreImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionHistoryEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TransactionHistoryLoadMoreImpl implements TransactionHistoryLoadMore {
  const _$TransactionHistoryLoadMoreImpl();

  @override
  String toString() {
    return 'TransactionHistoryEvent.loadMore()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionHistoryLoadMoreImpl);
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
    required TResult Function(TransactionHistoryFetched value) fetched,
    required TResult Function(TransactionHistoryRefreshed value) refreshed,
    required TResult Function(TransactionHistoryFiltered value) filtered,
    required TResult Function(TransactionHistoryLoadMore value) loadMore,
    required TResult Function(TransactionHistoryAccountChanged value)
        accountChanged,
  }) {
    return loadMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionHistoryFetched value)? fetched,
    TResult? Function(TransactionHistoryRefreshed value)? refreshed,
    TResult? Function(TransactionHistoryFiltered value)? filtered,
    TResult? Function(TransactionHistoryLoadMore value)? loadMore,
    TResult? Function(TransactionHistoryAccountChanged value)? accountChanged,
  }) {
    return loadMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionHistoryFetched value)? fetched,
    TResult Function(TransactionHistoryRefreshed value)? refreshed,
    TResult Function(TransactionHistoryFiltered value)? filtered,
    TResult Function(TransactionHistoryLoadMore value)? loadMore,
    TResult Function(TransactionHistoryAccountChanged value)? accountChanged,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore(this);
    }
    return orElse();
  }
}

abstract class TransactionHistoryLoadMore implements TransactionHistoryEvent {
  const factory TransactionHistoryLoadMore() = _$TransactionHistoryLoadMoreImpl;
}

/// @nodoc
abstract class _$$TransactionHistoryAccountChangedImplCopyWith<$Res> {
  factory _$$TransactionHistoryAccountChangedImplCopyWith(
          _$TransactionHistoryAccountChangedImpl value,
          $Res Function(_$TransactionHistoryAccountChangedImpl) then) =
      __$$TransactionHistoryAccountChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int accountId});
}

/// @nodoc
class __$$TransactionHistoryAccountChangedImplCopyWithImpl<$Res>
    extends _$TransactionHistoryEventCopyWithImpl<$Res,
        _$TransactionHistoryAccountChangedImpl>
    implements _$$TransactionHistoryAccountChangedImplCopyWith<$Res> {
  __$$TransactionHistoryAccountChangedImplCopyWithImpl(
      _$TransactionHistoryAccountChangedImpl _value,
      $Res Function(_$TransactionHistoryAccountChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionHistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
  }) {
    return _then(_$TransactionHistoryAccountChangedImpl(
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TransactionHistoryAccountChangedImpl
    implements TransactionHistoryAccountChanged {
  const _$TransactionHistoryAccountChangedImpl({required this.accountId});

  @override
  final int accountId;

  @override
  String toString() {
    return 'TransactionHistoryEvent.accountChanged(accountId: $accountId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionHistoryAccountChangedImpl &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accountId);

  /// Create a copy of TransactionHistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionHistoryAccountChangedImplCopyWith<
          _$TransactionHistoryAccountChangedImpl>
      get copyWith => __$$TransactionHistoryAccountChangedImplCopyWithImpl<
          _$TransactionHistoryAccountChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetched,
    required TResult Function() refreshed,
    required TResult Function(TransactionFilter filter) filtered,
    required TResult Function() loadMore,
    required TResult Function(int accountId) accountChanged,
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
    required TResult Function(TransactionHistoryFetched value) fetched,
    required TResult Function(TransactionHistoryRefreshed value) refreshed,
    required TResult Function(TransactionHistoryFiltered value) filtered,
    required TResult Function(TransactionHistoryLoadMore value) loadMore,
    required TResult Function(TransactionHistoryAccountChanged value)
        accountChanged,
  }) {
    return accountChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionHistoryFetched value)? fetched,
    TResult? Function(TransactionHistoryRefreshed value)? refreshed,
    TResult? Function(TransactionHistoryFiltered value)? filtered,
    TResult? Function(TransactionHistoryLoadMore value)? loadMore,
    TResult? Function(TransactionHistoryAccountChanged value)? accountChanged,
  }) {
    return accountChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionHistoryFetched value)? fetched,
    TResult Function(TransactionHistoryRefreshed value)? refreshed,
    TResult Function(TransactionHistoryFiltered value)? filtered,
    TResult Function(TransactionHistoryLoadMore value)? loadMore,
    TResult Function(TransactionHistoryAccountChanged value)? accountChanged,
    required TResult orElse(),
  }) {
    if (accountChanged != null) {
      return accountChanged(this);
    }
    return orElse();
  }
}

abstract class TransactionHistoryAccountChanged
    implements TransactionHistoryEvent {
  const factory TransactionHistoryAccountChanged(
      {required final int accountId}) = _$TransactionHistoryAccountChangedImpl;

  int get accountId;

  /// Create a copy of TransactionHistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionHistoryAccountChangedImplCopyWith<
          _$TransactionHistoryAccountChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransactionHistoryState {
  TransactionHistoryStatus get status => throw _privateConstructorUsedError;
  PaginatedTransactions? get paginatedTransactions =>
      throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  bool get hasReachedMax => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  int get selectedAccountId => throw _privateConstructorUsedError;
  TransactionFilter? get filter => throw _privateConstructorUsedError;

  /// Create a copy of TransactionHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionHistoryStateCopyWith<TransactionHistoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionHistoryStateCopyWith<$Res> {
  factory $TransactionHistoryStateCopyWith(TransactionHistoryState value,
          $Res Function(TransactionHistoryState) then) =
      _$TransactionHistoryStateCopyWithImpl<$Res, TransactionHistoryState>;
  @useResult
  $Res call(
      {TransactionHistoryStatus status,
      PaginatedTransactions? paginatedTransactions,
      int currentPage,
      int pageSize,
      bool hasReachedMax,
      String errorMessage,
      int selectedAccountId,
      TransactionFilter? filter});

  $PaginatedTransactionsCopyWith<$Res>? get paginatedTransactions;
  $TransactionFilterCopyWith<$Res>? get filter;
}

/// @nodoc
class _$TransactionHistoryStateCopyWithImpl<$Res,
        $Val extends TransactionHistoryState>
    implements $TransactionHistoryStateCopyWith<$Res> {
  _$TransactionHistoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? paginatedTransactions = freezed,
    Object? currentPage = null,
    Object? pageSize = null,
    Object? hasReachedMax = null,
    Object? errorMessage = null,
    Object? selectedAccountId = null,
    Object? filter = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransactionHistoryStatus,
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
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      selectedAccountId: null == selectedAccountId
          ? _value.selectedAccountId
          : selectedAccountId // ignore: cast_nullable_to_non_nullable
              as int,
      filter: freezed == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as TransactionFilter?,
    ) as $Val);
  }

  /// Create a copy of TransactionHistoryState
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

  /// Create a copy of TransactionHistoryState
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
}

/// @nodoc
abstract class _$$TransactionHistoryStateImplCopyWith<$Res>
    implements $TransactionHistoryStateCopyWith<$Res> {
  factory _$$TransactionHistoryStateImplCopyWith(
          _$TransactionHistoryStateImpl value,
          $Res Function(_$TransactionHistoryStateImpl) then) =
      __$$TransactionHistoryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TransactionHistoryStatus status,
      PaginatedTransactions? paginatedTransactions,
      int currentPage,
      int pageSize,
      bool hasReachedMax,
      String errorMessage,
      int selectedAccountId,
      TransactionFilter? filter});

  @override
  $PaginatedTransactionsCopyWith<$Res>? get paginatedTransactions;
  @override
  $TransactionFilterCopyWith<$Res>? get filter;
}

/// @nodoc
class __$$TransactionHistoryStateImplCopyWithImpl<$Res>
    extends _$TransactionHistoryStateCopyWithImpl<$Res,
        _$TransactionHistoryStateImpl>
    implements _$$TransactionHistoryStateImplCopyWith<$Res> {
  __$$TransactionHistoryStateImplCopyWithImpl(
      _$TransactionHistoryStateImpl _value,
      $Res Function(_$TransactionHistoryStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? paginatedTransactions = freezed,
    Object? currentPage = null,
    Object? pageSize = null,
    Object? hasReachedMax = null,
    Object? errorMessage = null,
    Object? selectedAccountId = null,
    Object? filter = freezed,
  }) {
    return _then(_$TransactionHistoryStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransactionHistoryStatus,
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
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      selectedAccountId: null == selectedAccountId
          ? _value.selectedAccountId
          : selectedAccountId // ignore: cast_nullable_to_non_nullable
              as int,
      filter: freezed == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as TransactionFilter?,
    ));
  }
}

/// @nodoc

class _$TransactionHistoryStateImpl implements _TransactionHistoryState {
  const _$TransactionHistoryStateImpl(
      {this.status = TransactionHistoryStatus.initial,
      this.paginatedTransactions,
      this.currentPage = 1,
      this.pageSize = 10,
      this.hasReachedMax = false,
      this.errorMessage = '',
      this.selectedAccountId = 0,
      this.filter});

  @override
  @JsonKey()
  final TransactionHistoryStatus status;
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
  @JsonKey()
  final String errorMessage;
  @override
  @JsonKey()
  final int selectedAccountId;
  @override
  final TransactionFilter? filter;

  @override
  String toString() {
    return 'TransactionHistoryState(status: $status, paginatedTransactions: $paginatedTransactions, currentPage: $currentPage, pageSize: $pageSize, hasReachedMax: $hasReachedMax, errorMessage: $errorMessage, selectedAccountId: $selectedAccountId, filter: $filter)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionHistoryStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paginatedTransactions, paginatedTransactions) ||
                other.paginatedTransactions == paginatedTransactions) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.hasReachedMax, hasReachedMax) ||
                other.hasReachedMax == hasReachedMax) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.selectedAccountId, selectedAccountId) ||
                other.selectedAccountId == selectedAccountId) &&
            (identical(other.filter, filter) || other.filter == filter));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      paginatedTransactions,
      currentPage,
      pageSize,
      hasReachedMax,
      errorMessage,
      selectedAccountId,
      filter);

  /// Create a copy of TransactionHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionHistoryStateImplCopyWith<_$TransactionHistoryStateImpl>
      get copyWith => __$$TransactionHistoryStateImplCopyWithImpl<
          _$TransactionHistoryStateImpl>(this, _$identity);
}

abstract class _TransactionHistoryState implements TransactionHistoryState {
  const factory _TransactionHistoryState(
      {final TransactionHistoryStatus status,
      final PaginatedTransactions? paginatedTransactions,
      final int currentPage,
      final int pageSize,
      final bool hasReachedMax,
      final String errorMessage,
      final int selectedAccountId,
      final TransactionFilter? filter}) = _$TransactionHistoryStateImpl;

  @override
  TransactionHistoryStatus get status;
  @override
  PaginatedTransactions? get paginatedTransactions;
  @override
  int get currentPage;
  @override
  int get pageSize;
  @override
  bool get hasReachedMax;
  @override
  String get errorMessage;
  @override
  int get selectedAccountId;
  @override
  TransactionFilter? get filter;

  /// Create a copy of TransactionHistoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionHistoryStateImplCopyWith<_$TransactionHistoryStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
