// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransactionSummary _$TransactionSummaryFromJson(Map<String, dynamic> json) {
  return _TransactionSummary.fromJson(json);
}

/// @nodoc
mixin _$TransactionSummary {
  double get totalIncoming => throw _privateConstructorUsedError;
  double get totalOutgoing => throw _privateConstructorUsedError;
  int get totalTransactions => throw _privateConstructorUsedError;
  int get successfulTransactions => throw _privateConstructorUsedError;
  int get failedTransactions => throw _privateConstructorUsedError;
  double get averageTransactionAmount => throw _privateConstructorUsedError;
  Map<String, double> get transactionsByType =>
      throw _privateConstructorUsedError;

  /// Serializes this TransactionSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionSummaryCopyWith<TransactionSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionSummaryCopyWith<$Res> {
  factory $TransactionSummaryCopyWith(
          TransactionSummary value, $Res Function(TransactionSummary) then) =
      _$TransactionSummaryCopyWithImpl<$Res, TransactionSummary>;
  @useResult
  $Res call(
      {double totalIncoming,
      double totalOutgoing,
      int totalTransactions,
      int successfulTransactions,
      int failedTransactions,
      double averageTransactionAmount,
      Map<String, double> transactionsByType});
}

/// @nodoc
class _$TransactionSummaryCopyWithImpl<$Res, $Val extends TransactionSummary>
    implements $TransactionSummaryCopyWith<$Res> {
  _$TransactionSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalIncoming = null,
    Object? totalOutgoing = null,
    Object? totalTransactions = null,
    Object? successfulTransactions = null,
    Object? failedTransactions = null,
    Object? averageTransactionAmount = null,
    Object? transactionsByType = null,
  }) {
    return _then(_value.copyWith(
      totalIncoming: null == totalIncoming
          ? _value.totalIncoming
          : totalIncoming // ignore: cast_nullable_to_non_nullable
              as double,
      totalOutgoing: null == totalOutgoing
          ? _value.totalOutgoing
          : totalOutgoing // ignore: cast_nullable_to_non_nullable
              as double,
      totalTransactions: null == totalTransactions
          ? _value.totalTransactions
          : totalTransactions // ignore: cast_nullable_to_non_nullable
              as int,
      successfulTransactions: null == successfulTransactions
          ? _value.successfulTransactions
          : successfulTransactions // ignore: cast_nullable_to_non_nullable
              as int,
      failedTransactions: null == failedTransactions
          ? _value.failedTransactions
          : failedTransactions // ignore: cast_nullable_to_non_nullable
              as int,
      averageTransactionAmount: null == averageTransactionAmount
          ? _value.averageTransactionAmount
          : averageTransactionAmount // ignore: cast_nullable_to_non_nullable
              as double,
      transactionsByType: null == transactionsByType
          ? _value.transactionsByType
          : transactionsByType // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionSummaryImplCopyWith<$Res>
    implements $TransactionSummaryCopyWith<$Res> {
  factory _$$TransactionSummaryImplCopyWith(_$TransactionSummaryImpl value,
          $Res Function(_$TransactionSummaryImpl) then) =
      __$$TransactionSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double totalIncoming,
      double totalOutgoing,
      int totalTransactions,
      int successfulTransactions,
      int failedTransactions,
      double averageTransactionAmount,
      Map<String, double> transactionsByType});
}

/// @nodoc
class __$$TransactionSummaryImplCopyWithImpl<$Res>
    extends _$TransactionSummaryCopyWithImpl<$Res, _$TransactionSummaryImpl>
    implements _$$TransactionSummaryImplCopyWith<$Res> {
  __$$TransactionSummaryImplCopyWithImpl(_$TransactionSummaryImpl _value,
      $Res Function(_$TransactionSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalIncoming = null,
    Object? totalOutgoing = null,
    Object? totalTransactions = null,
    Object? successfulTransactions = null,
    Object? failedTransactions = null,
    Object? averageTransactionAmount = null,
    Object? transactionsByType = null,
  }) {
    return _then(_$TransactionSummaryImpl(
      totalIncoming: null == totalIncoming
          ? _value.totalIncoming
          : totalIncoming // ignore: cast_nullable_to_non_nullable
              as double,
      totalOutgoing: null == totalOutgoing
          ? _value.totalOutgoing
          : totalOutgoing // ignore: cast_nullable_to_non_nullable
              as double,
      totalTransactions: null == totalTransactions
          ? _value.totalTransactions
          : totalTransactions // ignore: cast_nullable_to_non_nullable
              as int,
      successfulTransactions: null == successfulTransactions
          ? _value.successfulTransactions
          : successfulTransactions // ignore: cast_nullable_to_non_nullable
              as int,
      failedTransactions: null == failedTransactions
          ? _value.failedTransactions
          : failedTransactions // ignore: cast_nullable_to_non_nullable
              as int,
      averageTransactionAmount: null == averageTransactionAmount
          ? _value.averageTransactionAmount
          : averageTransactionAmount // ignore: cast_nullable_to_non_nullable
              as double,
      transactionsByType: null == transactionsByType
          ? _value._transactionsByType
          : transactionsByType // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionSummaryImpl extends _TransactionSummary {
  const _$TransactionSummaryImpl(
      {required this.totalIncoming,
      required this.totalOutgoing,
      required this.totalTransactions,
      required this.successfulTransactions,
      required this.failedTransactions,
      required this.averageTransactionAmount,
      required final Map<String, double> transactionsByType})
      : _transactionsByType = transactionsByType,
        super._();

  factory _$TransactionSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionSummaryImplFromJson(json);

  @override
  final double totalIncoming;
  @override
  final double totalOutgoing;
  @override
  final int totalTransactions;
  @override
  final int successfulTransactions;
  @override
  final int failedTransactions;
  @override
  final double averageTransactionAmount;
  final Map<String, double> _transactionsByType;
  @override
  Map<String, double> get transactionsByType {
    if (_transactionsByType is EqualUnmodifiableMapView)
      return _transactionsByType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_transactionsByType);
  }

  @override
  String toString() {
    return 'TransactionSummary(totalIncoming: $totalIncoming, totalOutgoing: $totalOutgoing, totalTransactions: $totalTransactions, successfulTransactions: $successfulTransactions, failedTransactions: $failedTransactions, averageTransactionAmount: $averageTransactionAmount, transactionsByType: $transactionsByType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionSummaryImpl &&
            (identical(other.totalIncoming, totalIncoming) ||
                other.totalIncoming == totalIncoming) &&
            (identical(other.totalOutgoing, totalOutgoing) ||
                other.totalOutgoing == totalOutgoing) &&
            (identical(other.totalTransactions, totalTransactions) ||
                other.totalTransactions == totalTransactions) &&
            (identical(other.successfulTransactions, successfulTransactions) ||
                other.successfulTransactions == successfulTransactions) &&
            (identical(other.failedTransactions, failedTransactions) ||
                other.failedTransactions == failedTransactions) &&
            (identical(
                    other.averageTransactionAmount, averageTransactionAmount) ||
                other.averageTransactionAmount == averageTransactionAmount) &&
            const DeepCollectionEquality()
                .equals(other._transactionsByType, _transactionsByType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalIncoming,
      totalOutgoing,
      totalTransactions,
      successfulTransactions,
      failedTransactions,
      averageTransactionAmount,
      const DeepCollectionEquality().hash(_transactionsByType));

  /// Create a copy of TransactionSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionSummaryImplCopyWith<_$TransactionSummaryImpl> get copyWith =>
      __$$TransactionSummaryImplCopyWithImpl<_$TransactionSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionSummaryImplToJson(
      this,
    );
  }
}

abstract class _TransactionSummary extends TransactionSummary {
  const factory _TransactionSummary(
          {required final double totalIncoming,
          required final double totalOutgoing,
          required final int totalTransactions,
          required final int successfulTransactions,
          required final int failedTransactions,
          required final double averageTransactionAmount,
          required final Map<String, double> transactionsByType}) =
      _$TransactionSummaryImpl;
  const _TransactionSummary._() : super._();

  factory _TransactionSummary.fromJson(Map<String, dynamic> json) =
      _$TransactionSummaryImpl.fromJson;

  @override
  double get totalIncoming;
  @override
  double get totalOutgoing;
  @override
  int get totalTransactions;
  @override
  int get successfulTransactions;
  @override
  int get failedTransactions;
  @override
  double get averageTransactionAmount;
  @override
  Map<String, double> get transactionsByType;

  /// Create a copy of TransactionSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionSummaryImplCopyWith<_$TransactionSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
