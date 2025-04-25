// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_transactions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PaginatedTransactions _$PaginatedTransactionsFromJson(
    Map<String, dynamic> json) {
  return _PaginatedTransactions.fromJson(json);
}

/// @nodoc
mixin _$PaginatedTransactions {
  List<Transaction> get transactions => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  bool get hasReachedMax => throw _privateConstructorUsedError;

  /// Serializes this PaginatedTransactions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedTransactions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedTransactionsCopyWith<PaginatedTransactions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedTransactionsCopyWith<$Res> {
  factory $PaginatedTransactionsCopyWith(PaginatedTransactions value,
          $Res Function(PaginatedTransactions) then) =
      _$PaginatedTransactionsCopyWithImpl<$Res, PaginatedTransactions>;
  @useResult
  $Res call(
      {List<Transaction> transactions,
      int totalCount,
      int currentPage,
      int pageSize,
      bool hasReachedMax});
}

/// @nodoc
class _$PaginatedTransactionsCopyWithImpl<$Res,
        $Val extends PaginatedTransactions>
    implements $PaginatedTransactionsCopyWith<$Res> {
  _$PaginatedTransactionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedTransactions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactions = null,
    Object? totalCount = null,
    Object? currentPage = null,
    Object? pageSize = null,
    Object? hasReachedMax = null,
  }) {
    return _then(_value.copyWith(
      transactions: null == transactions
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<Transaction>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaginatedTransactionsImplCopyWith<$Res>
    implements $PaginatedTransactionsCopyWith<$Res> {
  factory _$$PaginatedTransactionsImplCopyWith(
          _$PaginatedTransactionsImpl value,
          $Res Function(_$PaginatedTransactionsImpl) then) =
      __$$PaginatedTransactionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Transaction> transactions,
      int totalCount,
      int currentPage,
      int pageSize,
      bool hasReachedMax});
}

/// @nodoc
class __$$PaginatedTransactionsImplCopyWithImpl<$Res>
    extends _$PaginatedTransactionsCopyWithImpl<$Res,
        _$PaginatedTransactionsImpl>
    implements _$$PaginatedTransactionsImplCopyWith<$Res> {
  __$$PaginatedTransactionsImplCopyWithImpl(_$PaginatedTransactionsImpl _value,
      $Res Function(_$PaginatedTransactionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaginatedTransactions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactions = null,
    Object? totalCount = null,
    Object? currentPage = null,
    Object? pageSize = null,
    Object? hasReachedMax = null,
  }) {
    return _then(_$PaginatedTransactionsImpl(
      transactions: null == transactions
          ? _value._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<Transaction>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginatedTransactionsImpl extends _PaginatedTransactions {
  const _$PaginatedTransactionsImpl(
      {required final List<Transaction> transactions,
      required this.totalCount,
      required this.currentPage,
      required this.pageSize,
      this.hasReachedMax = false})
      : _transactions = transactions,
        super._();

  factory _$PaginatedTransactionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginatedTransactionsImplFromJson(json);

  final List<Transaction> _transactions;
  @override
  List<Transaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  final int totalCount;
  @override
  final int currentPage;
  @override
  final int pageSize;
  @override
  @JsonKey()
  final bool hasReachedMax;

  @override
  String toString() {
    return 'PaginatedTransactions(transactions: $transactions, totalCount: $totalCount, currentPage: $currentPage, pageSize: $pageSize, hasReachedMax: $hasReachedMax)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedTransactionsImpl &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.hasReachedMax, hasReachedMax) ||
                other.hasReachedMax == hasReachedMax));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_transactions),
      totalCount,
      currentPage,
      pageSize,
      hasReachedMax);

  /// Create a copy of PaginatedTransactions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedTransactionsImplCopyWith<_$PaginatedTransactionsImpl>
      get copyWith => __$$PaginatedTransactionsImplCopyWithImpl<
          _$PaginatedTransactionsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginatedTransactionsImplToJson(
      this,
    );
  }
}

abstract class _PaginatedTransactions extends PaginatedTransactions {
  const factory _PaginatedTransactions(
      {required final List<Transaction> transactions,
      required final int totalCount,
      required final int currentPage,
      required final int pageSize,
      final bool hasReachedMax}) = _$PaginatedTransactionsImpl;
  const _PaginatedTransactions._() : super._();

  factory _PaginatedTransactions.fromJson(Map<String, dynamic> json) =
      _$PaginatedTransactionsImpl.fromJson;

  @override
  List<Transaction> get transactions;
  @override
  int get totalCount;
  @override
  int get currentPage;
  @override
  int get pageSize;
  @override
  bool get hasReachedMax;

  /// Create a copy of PaginatedTransactions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedTransactionsImplCopyWith<_$PaginatedTransactionsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
