// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_institution_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FinancialInstitutionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int pageId, int pageSize) fetchInstitutions,
    required TResult Function(FinancialInstitutionType type) filterByType,
    required TResult Function(String query) searchQueryChanged,
    required TResult Function() loadMoreInstitutions,
    required TResult Function() refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int pageId, int pageSize)? fetchInstitutions,
    TResult? Function(FinancialInstitutionType type)? filterByType,
    TResult? Function(String query)? searchQueryChanged,
    TResult? Function()? loadMoreInstitutions,
    TResult? Function()? refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int pageId, int pageSize)? fetchInstitutions,
    TResult Function(FinancialInstitutionType type)? filterByType,
    TResult Function(String query)? searchQueryChanged,
    TResult Function()? loadMoreInstitutions,
    TResult Function()? refresh,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchInstitutions value) fetchInstitutions,
    required TResult Function(FilterByType value) filterByType,
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
    required TResult Function(LoadMoreInstitutions value) loadMoreInstitutions,
    required TResult Function(RefreshInstitutions value) refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchInstitutions value)? fetchInstitutions,
    TResult? Function(FilterByType value)? filterByType,
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
    TResult? Function(LoadMoreInstitutions value)? loadMoreInstitutions,
    TResult? Function(RefreshInstitutions value)? refresh,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchInstitutions value)? fetchInstitutions,
    TResult Function(FilterByType value)? filterByType,
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    TResult Function(LoadMoreInstitutions value)? loadMoreInstitutions,
    TResult Function(RefreshInstitutions value)? refresh,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinancialInstitutionEventCopyWith<$Res> {
  factory $FinancialInstitutionEventCopyWith(FinancialInstitutionEvent value,
          $Res Function(FinancialInstitutionEvent) then) =
      _$FinancialInstitutionEventCopyWithImpl<$Res, FinancialInstitutionEvent>;
}

/// @nodoc
class _$FinancialInstitutionEventCopyWithImpl<$Res,
        $Val extends FinancialInstitutionEvent>
    implements $FinancialInstitutionEventCopyWith<$Res> {
  _$FinancialInstitutionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FinancialInstitutionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FetchInstitutionsImplCopyWith<$Res> {
  factory _$$FetchInstitutionsImplCopyWith(_$FetchInstitutionsImpl value,
          $Res Function(_$FetchInstitutionsImpl) then) =
      __$$FetchInstitutionsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int pageId, int pageSize});
}

/// @nodoc
class __$$FetchInstitutionsImplCopyWithImpl<$Res>
    extends _$FinancialInstitutionEventCopyWithImpl<$Res,
        _$FetchInstitutionsImpl>
    implements _$$FetchInstitutionsImplCopyWith<$Res> {
  __$$FetchInstitutionsImplCopyWithImpl(_$FetchInstitutionsImpl _value,
      $Res Function(_$FetchInstitutionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of FinancialInstitutionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageId = null,
    Object? pageSize = null,
  }) {
    return _then(_$FetchInstitutionsImpl(
      pageId: null == pageId
          ? _value.pageId
          : pageId // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$FetchInstitutionsImpl implements FetchInstitutions {
  const _$FetchInstitutionsImpl({this.pageId = 1, this.pageSize = 0});

  @override
  @JsonKey()
  final int pageId;
  @override
  @JsonKey()
  final int pageSize;

  @override
  String toString() {
    return 'FinancialInstitutionEvent.fetchInstitutions(pageId: $pageId, pageSize: $pageSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchInstitutionsImpl &&
            (identical(other.pageId, pageId) || other.pageId == pageId) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pageId, pageSize);

  /// Create a copy of FinancialInstitutionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchInstitutionsImplCopyWith<_$FetchInstitutionsImpl> get copyWith =>
      __$$FetchInstitutionsImplCopyWithImpl<_$FetchInstitutionsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int pageId, int pageSize) fetchInstitutions,
    required TResult Function(FinancialInstitutionType type) filterByType,
    required TResult Function(String query) searchQueryChanged,
    required TResult Function() loadMoreInstitutions,
    required TResult Function() refresh,
  }) {
    return fetchInstitutions(pageId, pageSize);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int pageId, int pageSize)? fetchInstitutions,
    TResult? Function(FinancialInstitutionType type)? filterByType,
    TResult? Function(String query)? searchQueryChanged,
    TResult? Function()? loadMoreInstitutions,
    TResult? Function()? refresh,
  }) {
    return fetchInstitutions?.call(pageId, pageSize);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int pageId, int pageSize)? fetchInstitutions,
    TResult Function(FinancialInstitutionType type)? filterByType,
    TResult Function(String query)? searchQueryChanged,
    TResult Function()? loadMoreInstitutions,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (fetchInstitutions != null) {
      return fetchInstitutions(pageId, pageSize);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchInstitutions value) fetchInstitutions,
    required TResult Function(FilterByType value) filterByType,
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
    required TResult Function(LoadMoreInstitutions value) loadMoreInstitutions,
    required TResult Function(RefreshInstitutions value) refresh,
  }) {
    return fetchInstitutions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchInstitutions value)? fetchInstitutions,
    TResult? Function(FilterByType value)? filterByType,
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
    TResult? Function(LoadMoreInstitutions value)? loadMoreInstitutions,
    TResult? Function(RefreshInstitutions value)? refresh,
  }) {
    return fetchInstitutions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchInstitutions value)? fetchInstitutions,
    TResult Function(FilterByType value)? filterByType,
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    TResult Function(LoadMoreInstitutions value)? loadMoreInstitutions,
    TResult Function(RefreshInstitutions value)? refresh,
    required TResult orElse(),
  }) {
    if (fetchInstitutions != null) {
      return fetchInstitutions(this);
    }
    return orElse();
  }
}

abstract class FetchInstitutions implements FinancialInstitutionEvent {
  const factory FetchInstitutions({final int pageId, final int pageSize}) =
      _$FetchInstitutionsImpl;

  int get pageId;
  int get pageSize;

  /// Create a copy of FinancialInstitutionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FetchInstitutionsImplCopyWith<_$FetchInstitutionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FilterByTypeImplCopyWith<$Res> {
  factory _$$FilterByTypeImplCopyWith(
          _$FilterByTypeImpl value, $Res Function(_$FilterByTypeImpl) then) =
      __$$FilterByTypeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({FinancialInstitutionType type});
}

/// @nodoc
class __$$FilterByTypeImplCopyWithImpl<$Res>
    extends _$FinancialInstitutionEventCopyWithImpl<$Res, _$FilterByTypeImpl>
    implements _$$FilterByTypeImplCopyWith<$Res> {
  __$$FilterByTypeImplCopyWithImpl(
      _$FilterByTypeImpl _value, $Res Function(_$FilterByTypeImpl) _then)
      : super(_value, _then);

  /// Create a copy of FinancialInstitutionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
  }) {
    return _then(_$FilterByTypeImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FinancialInstitutionType,
    ));
  }
}

/// @nodoc

class _$FilterByTypeImpl implements FilterByType {
  const _$FilterByTypeImpl({required this.type});

  @override
  final FinancialInstitutionType type;

  @override
  String toString() {
    return 'FinancialInstitutionEvent.filterByType(type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterByTypeImpl &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type);

  /// Create a copy of FinancialInstitutionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterByTypeImplCopyWith<_$FilterByTypeImpl> get copyWith =>
      __$$FilterByTypeImplCopyWithImpl<_$FilterByTypeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int pageId, int pageSize) fetchInstitutions,
    required TResult Function(FinancialInstitutionType type) filterByType,
    required TResult Function(String query) searchQueryChanged,
    required TResult Function() loadMoreInstitutions,
    required TResult Function() refresh,
  }) {
    return filterByType(type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int pageId, int pageSize)? fetchInstitutions,
    TResult? Function(FinancialInstitutionType type)? filterByType,
    TResult? Function(String query)? searchQueryChanged,
    TResult? Function()? loadMoreInstitutions,
    TResult? Function()? refresh,
  }) {
    return filterByType?.call(type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int pageId, int pageSize)? fetchInstitutions,
    TResult Function(FinancialInstitutionType type)? filterByType,
    TResult Function(String query)? searchQueryChanged,
    TResult Function()? loadMoreInstitutions,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (filterByType != null) {
      return filterByType(type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchInstitutions value) fetchInstitutions,
    required TResult Function(FilterByType value) filterByType,
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
    required TResult Function(LoadMoreInstitutions value) loadMoreInstitutions,
    required TResult Function(RefreshInstitutions value) refresh,
  }) {
    return filterByType(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchInstitutions value)? fetchInstitutions,
    TResult? Function(FilterByType value)? filterByType,
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
    TResult? Function(LoadMoreInstitutions value)? loadMoreInstitutions,
    TResult? Function(RefreshInstitutions value)? refresh,
  }) {
    return filterByType?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchInstitutions value)? fetchInstitutions,
    TResult Function(FilterByType value)? filterByType,
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    TResult Function(LoadMoreInstitutions value)? loadMoreInstitutions,
    TResult Function(RefreshInstitutions value)? refresh,
    required TResult orElse(),
  }) {
    if (filterByType != null) {
      return filterByType(this);
    }
    return orElse();
  }
}

abstract class FilterByType implements FinancialInstitutionEvent {
  const factory FilterByType({required final FinancialInstitutionType type}) =
      _$FilterByTypeImpl;

  FinancialInstitutionType get type;

  /// Create a copy of FinancialInstitutionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterByTypeImplCopyWith<_$FilterByTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchQueryChangedImplCopyWith<$Res> {
  factory _$$SearchQueryChangedImplCopyWith(_$SearchQueryChangedImpl value,
          $Res Function(_$SearchQueryChangedImpl) then) =
      __$$SearchQueryChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchQueryChangedImplCopyWithImpl<$Res>
    extends _$FinancialInstitutionEventCopyWithImpl<$Res,
        _$SearchQueryChangedImpl>
    implements _$$SearchQueryChangedImplCopyWith<$Res> {
  __$$SearchQueryChangedImplCopyWithImpl(_$SearchQueryChangedImpl _value,
      $Res Function(_$SearchQueryChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of FinancialInstitutionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_$SearchQueryChangedImpl(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchQueryChangedImpl implements SearchQueryChanged {
  const _$SearchQueryChangedImpl({required this.query});

  @override
  final String query;

  @override
  String toString() {
    return 'FinancialInstitutionEvent.searchQueryChanged(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchQueryChangedImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of FinancialInstitutionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchQueryChangedImplCopyWith<_$SearchQueryChangedImpl> get copyWith =>
      __$$SearchQueryChangedImplCopyWithImpl<_$SearchQueryChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int pageId, int pageSize) fetchInstitutions,
    required TResult Function(FinancialInstitutionType type) filterByType,
    required TResult Function(String query) searchQueryChanged,
    required TResult Function() loadMoreInstitutions,
    required TResult Function() refresh,
  }) {
    return searchQueryChanged(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int pageId, int pageSize)? fetchInstitutions,
    TResult? Function(FinancialInstitutionType type)? filterByType,
    TResult? Function(String query)? searchQueryChanged,
    TResult? Function()? loadMoreInstitutions,
    TResult? Function()? refresh,
  }) {
    return searchQueryChanged?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int pageId, int pageSize)? fetchInstitutions,
    TResult Function(FinancialInstitutionType type)? filterByType,
    TResult Function(String query)? searchQueryChanged,
    TResult Function()? loadMoreInstitutions,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (searchQueryChanged != null) {
      return searchQueryChanged(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchInstitutions value) fetchInstitutions,
    required TResult Function(FilterByType value) filterByType,
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
    required TResult Function(LoadMoreInstitutions value) loadMoreInstitutions,
    required TResult Function(RefreshInstitutions value) refresh,
  }) {
    return searchQueryChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchInstitutions value)? fetchInstitutions,
    TResult? Function(FilterByType value)? filterByType,
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
    TResult? Function(LoadMoreInstitutions value)? loadMoreInstitutions,
    TResult? Function(RefreshInstitutions value)? refresh,
  }) {
    return searchQueryChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchInstitutions value)? fetchInstitutions,
    TResult Function(FilterByType value)? filterByType,
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    TResult Function(LoadMoreInstitutions value)? loadMoreInstitutions,
    TResult Function(RefreshInstitutions value)? refresh,
    required TResult orElse(),
  }) {
    if (searchQueryChanged != null) {
      return searchQueryChanged(this);
    }
    return orElse();
  }
}

abstract class SearchQueryChanged implements FinancialInstitutionEvent {
  const factory SearchQueryChanged({required final String query}) =
      _$SearchQueryChangedImpl;

  String get query;

  /// Create a copy of FinancialInstitutionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchQueryChangedImplCopyWith<_$SearchQueryChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadMoreInstitutionsImplCopyWith<$Res> {
  factory _$$LoadMoreInstitutionsImplCopyWith(_$LoadMoreInstitutionsImpl value,
          $Res Function(_$LoadMoreInstitutionsImpl) then) =
      __$$LoadMoreInstitutionsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMoreInstitutionsImplCopyWithImpl<$Res>
    extends _$FinancialInstitutionEventCopyWithImpl<$Res,
        _$LoadMoreInstitutionsImpl>
    implements _$$LoadMoreInstitutionsImplCopyWith<$Res> {
  __$$LoadMoreInstitutionsImplCopyWithImpl(_$LoadMoreInstitutionsImpl _value,
      $Res Function(_$LoadMoreInstitutionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of FinancialInstitutionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMoreInstitutionsImpl implements LoadMoreInstitutions {
  const _$LoadMoreInstitutionsImpl();

  @override
  String toString() {
    return 'FinancialInstitutionEvent.loadMoreInstitutions()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadMoreInstitutionsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int pageId, int pageSize) fetchInstitutions,
    required TResult Function(FinancialInstitutionType type) filterByType,
    required TResult Function(String query) searchQueryChanged,
    required TResult Function() loadMoreInstitutions,
    required TResult Function() refresh,
  }) {
    return loadMoreInstitutions();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int pageId, int pageSize)? fetchInstitutions,
    TResult? Function(FinancialInstitutionType type)? filterByType,
    TResult? Function(String query)? searchQueryChanged,
    TResult? Function()? loadMoreInstitutions,
    TResult? Function()? refresh,
  }) {
    return loadMoreInstitutions?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int pageId, int pageSize)? fetchInstitutions,
    TResult Function(FinancialInstitutionType type)? filterByType,
    TResult Function(String query)? searchQueryChanged,
    TResult Function()? loadMoreInstitutions,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (loadMoreInstitutions != null) {
      return loadMoreInstitutions();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchInstitutions value) fetchInstitutions,
    required TResult Function(FilterByType value) filterByType,
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
    required TResult Function(LoadMoreInstitutions value) loadMoreInstitutions,
    required TResult Function(RefreshInstitutions value) refresh,
  }) {
    return loadMoreInstitutions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchInstitutions value)? fetchInstitutions,
    TResult? Function(FilterByType value)? filterByType,
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
    TResult? Function(LoadMoreInstitutions value)? loadMoreInstitutions,
    TResult? Function(RefreshInstitutions value)? refresh,
  }) {
    return loadMoreInstitutions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchInstitutions value)? fetchInstitutions,
    TResult Function(FilterByType value)? filterByType,
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    TResult Function(LoadMoreInstitutions value)? loadMoreInstitutions,
    TResult Function(RefreshInstitutions value)? refresh,
    required TResult orElse(),
  }) {
    if (loadMoreInstitutions != null) {
      return loadMoreInstitutions(this);
    }
    return orElse();
  }
}

abstract class LoadMoreInstitutions implements FinancialInstitutionEvent {
  const factory LoadMoreInstitutions() = _$LoadMoreInstitutionsImpl;
}

/// @nodoc
abstract class _$$RefreshInstitutionsImplCopyWith<$Res> {
  factory _$$RefreshInstitutionsImplCopyWith(_$RefreshInstitutionsImpl value,
          $Res Function(_$RefreshInstitutionsImpl) then) =
      __$$RefreshInstitutionsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshInstitutionsImplCopyWithImpl<$Res>
    extends _$FinancialInstitutionEventCopyWithImpl<$Res,
        _$RefreshInstitutionsImpl>
    implements _$$RefreshInstitutionsImplCopyWith<$Res> {
  __$$RefreshInstitutionsImplCopyWithImpl(_$RefreshInstitutionsImpl _value,
      $Res Function(_$RefreshInstitutionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of FinancialInstitutionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshInstitutionsImpl implements RefreshInstitutions {
  const _$RefreshInstitutionsImpl();

  @override
  String toString() {
    return 'FinancialInstitutionEvent.refresh()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshInstitutionsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int pageId, int pageSize) fetchInstitutions,
    required TResult Function(FinancialInstitutionType type) filterByType,
    required TResult Function(String query) searchQueryChanged,
    required TResult Function() loadMoreInstitutions,
    required TResult Function() refresh,
  }) {
    return refresh();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int pageId, int pageSize)? fetchInstitutions,
    TResult? Function(FinancialInstitutionType type)? filterByType,
    TResult? Function(String query)? searchQueryChanged,
    TResult? Function()? loadMoreInstitutions,
    TResult? Function()? refresh,
  }) {
    return refresh?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int pageId, int pageSize)? fetchInstitutions,
    TResult Function(FinancialInstitutionType type)? filterByType,
    TResult Function(String query)? searchQueryChanged,
    TResult Function()? loadMoreInstitutions,
    TResult Function()? refresh,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchInstitutions value) fetchInstitutions,
    required TResult Function(FilterByType value) filterByType,
    required TResult Function(SearchQueryChanged value) searchQueryChanged,
    required TResult Function(LoadMoreInstitutions value) loadMoreInstitutions,
    required TResult Function(RefreshInstitutions value) refresh,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchInstitutions value)? fetchInstitutions,
    TResult? Function(FilterByType value)? filterByType,
    TResult? Function(SearchQueryChanged value)? searchQueryChanged,
    TResult? Function(LoadMoreInstitutions value)? loadMoreInstitutions,
    TResult? Function(RefreshInstitutions value)? refresh,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchInstitutions value)? fetchInstitutions,
    TResult Function(FilterByType value)? filterByType,
    TResult Function(SearchQueryChanged value)? searchQueryChanged,
    TResult Function(LoadMoreInstitutions value)? loadMoreInstitutions,
    TResult Function(RefreshInstitutions value)? refresh,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class RefreshInstitutions implements FinancialInstitutionEvent {
  const factory RefreshInstitutions() = _$RefreshInstitutionsImpl;
}

/// @nodoc
mixin _$FinancialInstitutionState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<FinancialInstitution> get institutions =>
      throw _privateConstructorUsedError;
  List<FinancialInstitution> get filteredInstitutions =>
      throw _privateConstructorUsedError;
  FinancialInstitutionType get type => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  bool get hasMorePages => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;

  /// Create a copy of FinancialInstitutionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FinancialInstitutionStateCopyWith<FinancialInstitutionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinancialInstitutionStateCopyWith<$Res> {
  factory $FinancialInstitutionStateCopyWith(FinancialInstitutionState value,
          $Res Function(FinancialInstitutionState) then) =
      _$FinancialInstitutionStateCopyWithImpl<$Res, FinancialInstitutionState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<FinancialInstitution> institutions,
      List<FinancialInstitution> filteredInstitutions,
      FinancialInstitutionType type,
      String searchQuery,
      int currentPage,
      int totalPages,
      bool hasMorePages,
      String errorMessage,
      bool hasError});
}

/// @nodoc
class _$FinancialInstitutionStateCopyWithImpl<$Res,
        $Val extends FinancialInstitutionState>
    implements $FinancialInstitutionStateCopyWith<$Res> {
  _$FinancialInstitutionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FinancialInstitutionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? institutions = null,
    Object? filteredInstitutions = null,
    Object? type = null,
    Object? searchQuery = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? hasMorePages = null,
    Object? errorMessage = null,
    Object? hasError = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      institutions: null == institutions
          ? _value.institutions
          : institutions // ignore: cast_nullable_to_non_nullable
              as List<FinancialInstitution>,
      filteredInstitutions: null == filteredInstitutions
          ? _value.filteredInstitutions
          : filteredInstitutions // ignore: cast_nullable_to_non_nullable
              as List<FinancialInstitution>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FinancialInstitutionType,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      hasMorePages: null == hasMorePages
          ? _value.hasMorePages
          : hasMorePages // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FinancialInstitutionStateImplCopyWith<$Res>
    implements $FinancialInstitutionStateCopyWith<$Res> {
  factory _$$FinancialInstitutionStateImplCopyWith(
          _$FinancialInstitutionStateImpl value,
          $Res Function(_$FinancialInstitutionStateImpl) then) =
      __$$FinancialInstitutionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<FinancialInstitution> institutions,
      List<FinancialInstitution> filteredInstitutions,
      FinancialInstitutionType type,
      String searchQuery,
      int currentPage,
      int totalPages,
      bool hasMorePages,
      String errorMessage,
      bool hasError});
}

/// @nodoc
class __$$FinancialInstitutionStateImplCopyWithImpl<$Res>
    extends _$FinancialInstitutionStateCopyWithImpl<$Res,
        _$FinancialInstitutionStateImpl>
    implements _$$FinancialInstitutionStateImplCopyWith<$Res> {
  __$$FinancialInstitutionStateImplCopyWithImpl(
      _$FinancialInstitutionStateImpl _value,
      $Res Function(_$FinancialInstitutionStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of FinancialInstitutionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? institutions = null,
    Object? filteredInstitutions = null,
    Object? type = null,
    Object? searchQuery = null,
    Object? currentPage = null,
    Object? totalPages = null,
    Object? hasMorePages = null,
    Object? errorMessage = null,
    Object? hasError = null,
  }) {
    return _then(_$FinancialInstitutionStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      institutions: null == institutions
          ? _value._institutions
          : institutions // ignore: cast_nullable_to_non_nullable
              as List<FinancialInstitution>,
      filteredInstitutions: null == filteredInstitutions
          ? _value._filteredInstitutions
          : filteredInstitutions // ignore: cast_nullable_to_non_nullable
              as List<FinancialInstitution>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FinancialInstitutionType,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      hasMorePages: null == hasMorePages
          ? _value.hasMorePages
          : hasMorePages // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$FinancialInstitutionStateImpl implements _FinancialInstitutionState {
  const _$FinancialInstitutionStateImpl(
      {required this.isLoading,
      required final List<FinancialInstitution> institutions,
      required final List<FinancialInstitution> filteredInstitutions,
      required this.type,
      required this.searchQuery,
      required this.currentPage,
      required this.totalPages,
      required this.hasMorePages,
      required this.errorMessage,
      required this.hasError})
      : _institutions = institutions,
        _filteredInstitutions = filteredInstitutions;

  @override
  final bool isLoading;
  final List<FinancialInstitution> _institutions;
  @override
  List<FinancialInstitution> get institutions {
    if (_institutions is EqualUnmodifiableListView) return _institutions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_institutions);
  }

  final List<FinancialInstitution> _filteredInstitutions;
  @override
  List<FinancialInstitution> get filteredInstitutions {
    if (_filteredInstitutions is EqualUnmodifiableListView)
      return _filteredInstitutions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredInstitutions);
  }

  @override
  final FinancialInstitutionType type;
  @override
  final String searchQuery;
  @override
  final int currentPage;
  @override
  final int totalPages;
  @override
  final bool hasMorePages;
  @override
  final String errorMessage;
  @override
  final bool hasError;

  @override
  String toString() {
    return 'FinancialInstitutionState(isLoading: $isLoading, institutions: $institutions, filteredInstitutions: $filteredInstitutions, type: $type, searchQuery: $searchQuery, currentPage: $currentPage, totalPages: $totalPages, hasMorePages: $hasMorePages, errorMessage: $errorMessage, hasError: $hasError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialInstitutionStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._institutions, _institutions) &&
            const DeepCollectionEquality()
                .equals(other._filteredInstitutions, _filteredInstitutions) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.hasMorePages, hasMorePages) ||
                other.hasMorePages == hasMorePages) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_institutions),
      const DeepCollectionEquality().hash(_filteredInstitutions),
      type,
      searchQuery,
      currentPage,
      totalPages,
      hasMorePages,
      errorMessage,
      hasError);

  /// Create a copy of FinancialInstitutionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FinancialInstitutionStateImplCopyWith<_$FinancialInstitutionStateImpl>
      get copyWith => __$$FinancialInstitutionStateImplCopyWithImpl<
          _$FinancialInstitutionStateImpl>(this, _$identity);
}

abstract class _FinancialInstitutionState implements FinancialInstitutionState {
  const factory _FinancialInstitutionState(
      {required final bool isLoading,
      required final List<FinancialInstitution> institutions,
      required final List<FinancialInstitution> filteredInstitutions,
      required final FinancialInstitutionType type,
      required final String searchQuery,
      required final int currentPage,
      required final int totalPages,
      required final bool hasMorePages,
      required final String errorMessage,
      required final bool hasError}) = _$FinancialInstitutionStateImpl;

  @override
  bool get isLoading;
  @override
  List<FinancialInstitution> get institutions;
  @override
  List<FinancialInstitution> get filteredInstitutions;
  @override
  FinancialInstitutionType get type;
  @override
  String get searchQuery;
  @override
  int get currentPage;
  @override
  int get totalPages;
  @override
  bool get hasMorePages;
  @override
  String get errorMessage;
  @override
  bool get hasError;

  /// Create a copy of FinancialInstitutionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FinancialInstitutionStateImplCopyWith<_$FinancialInstitutionStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
