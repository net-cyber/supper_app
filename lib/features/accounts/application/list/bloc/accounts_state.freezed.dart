// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'accounts_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountsState {
  List<Account> get accounts => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;
  bool get hasReachedMax => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;

  /// Create a copy of AccountsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountsStateCopyWith<AccountsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountsStateCopyWith<$Res> {
  factory $AccountsStateCopyWith(
          AccountsState value, $Res Function(AccountsState) then) =
      _$AccountsStateCopyWithImpl<$Res, AccountsState>;
  @useResult
  $Res call(
      {List<Account> accounts,
      bool isLoading,
      bool isLoadingMore,
      bool hasError,
      bool hasReachedMax,
      int currentPage,
      int pageSize});
}

/// @nodoc
class _$AccountsStateCopyWithImpl<$Res, $Val extends AccountsState>
    implements $AccountsStateCopyWith<$Res> {
  _$AccountsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accounts = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasError = null,
    Object? hasReachedMax = null,
    Object? currentPage = null,
    Object? pageSize = null,
  }) {
    return _then(_value.copyWith(
      accounts: null == accounts
          ? _value.accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<Account>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      hasReachedMax: null == hasReachedMax
          ? _value.hasReachedMax
          : hasReachedMax // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountsStateImplCopyWith<$Res>
    implements $AccountsStateCopyWith<$Res> {
  factory _$$AccountsStateImplCopyWith(
          _$AccountsStateImpl value, $Res Function(_$AccountsStateImpl) then) =
      __$$AccountsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Account> accounts,
      bool isLoading,
      bool isLoadingMore,
      bool hasError,
      bool hasReachedMax,
      int currentPage,
      int pageSize});
}

/// @nodoc
class __$$AccountsStateImplCopyWithImpl<$Res>
    extends _$AccountsStateCopyWithImpl<$Res, _$AccountsStateImpl>
    implements _$$AccountsStateImplCopyWith<$Res> {
  __$$AccountsStateImplCopyWithImpl(
      _$AccountsStateImpl _value, $Res Function(_$AccountsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accounts = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasError = null,
    Object? hasReachedMax = null,
    Object? currentPage = null,
    Object? pageSize = null,
  }) {
    return _then(_$AccountsStateImpl(
      accounts: null == accounts
          ? _value._accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<Account>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      hasReachedMax: null == hasReachedMax
          ? _value.hasReachedMax
          : hasReachedMax // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$AccountsStateImpl extends _AccountsState {
  const _$AccountsStateImpl(
      {required final List<Account> accounts,
      this.isLoading = false,
      this.isLoadingMore = false,
      this.hasError = false,
      this.hasReachedMax = false,
      this.currentPage = 1,
      this.pageSize = 10})
      : _accounts = accounts,
        super._();

  final List<Account> _accounts;
  @override
  List<Account> get accounts {
    if (_accounts is EqualUnmodifiableListView) return _accounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accounts);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  @JsonKey()
  final bool hasError;
  @override
  @JsonKey()
  final bool hasReachedMax;
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int pageSize;

  @override
  String toString() {
    return 'AccountsState(accounts: $accounts, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasError: $hasError, hasReachedMax: $hasReachedMax, currentPage: $currentPage, pageSize: $pageSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountsStateImpl &&
            const DeepCollectionEquality().equals(other._accounts, _accounts) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError) &&
            (identical(other.hasReachedMax, hasReachedMax) ||
                other.hasReachedMax == hasReachedMax) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_accounts),
      isLoading,
      isLoadingMore,
      hasError,
      hasReachedMax,
      currentPage,
      pageSize);

  /// Create a copy of AccountsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountsStateImplCopyWith<_$AccountsStateImpl> get copyWith =>
      __$$AccountsStateImplCopyWithImpl<_$AccountsStateImpl>(this, _$identity);
}

abstract class _AccountsState extends AccountsState {
  const factory _AccountsState(
      {required final List<Account> accounts,
      final bool isLoading,
      final bool isLoadingMore,
      final bool hasError,
      final bool hasReachedMax,
      final int currentPage,
      final int pageSize}) = _$AccountsStateImpl;
  const _AccountsState._() : super._();

  @override
  List<Account> get accounts;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  bool get hasError;
  @override
  bool get hasReachedMax;
  @override
  int get currentPage;
  @override
  int get pageSize;

  /// Create a copy of AccountsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountsStateImplCopyWith<_$AccountsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
