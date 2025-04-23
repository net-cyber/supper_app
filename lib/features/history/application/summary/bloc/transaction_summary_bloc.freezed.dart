// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_summary_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransactionSummaryEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetched,
    required TResult Function(DateTime? startDate, DateTime? endDate)
        dateRangeChanged,
    required TResult Function(int accountId) accountChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetched,
    TResult? Function(DateTime? startDate, DateTime? endDate)? dateRangeChanged,
    TResult? Function(int accountId)? accountChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetched,
    TResult Function(DateTime? startDate, DateTime? endDate)? dateRangeChanged,
    TResult Function(int accountId)? accountChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionSummaryFetched value) fetched,
    required TResult Function(TransactionSummaryDateRangeChanged value)
        dateRangeChanged,
    required TResult Function(TransactionSummaryAccountChanged value)
        accountChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionSummaryFetched value)? fetched,
    TResult? Function(TransactionSummaryDateRangeChanged value)?
        dateRangeChanged,
    TResult? Function(TransactionSummaryAccountChanged value)? accountChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionSummaryFetched value)? fetched,
    TResult Function(TransactionSummaryDateRangeChanged value)?
        dateRangeChanged,
    TResult Function(TransactionSummaryAccountChanged value)? accountChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionSummaryEventCopyWith<$Res> {
  factory $TransactionSummaryEventCopyWith(TransactionSummaryEvent value,
          $Res Function(TransactionSummaryEvent) then) =
      _$TransactionSummaryEventCopyWithImpl<$Res, TransactionSummaryEvent>;
}

/// @nodoc
class _$TransactionSummaryEventCopyWithImpl<$Res,
        $Val extends TransactionSummaryEvent>
    implements $TransactionSummaryEventCopyWith<$Res> {
  _$TransactionSummaryEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionSummaryEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TransactionSummaryFetchedImplCopyWith<$Res> {
  factory _$$TransactionSummaryFetchedImplCopyWith(
          _$TransactionSummaryFetchedImpl value,
          $Res Function(_$TransactionSummaryFetchedImpl) then) =
      __$$TransactionSummaryFetchedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransactionSummaryFetchedImplCopyWithImpl<$Res>
    extends _$TransactionSummaryEventCopyWithImpl<$Res,
        _$TransactionSummaryFetchedImpl>
    implements _$$TransactionSummaryFetchedImplCopyWith<$Res> {
  __$$TransactionSummaryFetchedImplCopyWithImpl(
      _$TransactionSummaryFetchedImpl _value,
      $Res Function(_$TransactionSummaryFetchedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionSummaryEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TransactionSummaryFetchedImpl implements TransactionSummaryFetched {
  const _$TransactionSummaryFetchedImpl();

  @override
  String toString() {
    return 'TransactionSummaryEvent.fetched()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionSummaryFetchedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetched,
    required TResult Function(DateTime? startDate, DateTime? endDate)
        dateRangeChanged,
    required TResult Function(int accountId) accountChanged,
  }) {
    return fetched();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetched,
    TResult? Function(DateTime? startDate, DateTime? endDate)? dateRangeChanged,
    TResult? Function(int accountId)? accountChanged,
  }) {
    return fetched?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetched,
    TResult Function(DateTime? startDate, DateTime? endDate)? dateRangeChanged,
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
    required TResult Function(TransactionSummaryFetched value) fetched,
    required TResult Function(TransactionSummaryDateRangeChanged value)
        dateRangeChanged,
    required TResult Function(TransactionSummaryAccountChanged value)
        accountChanged,
  }) {
    return fetched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionSummaryFetched value)? fetched,
    TResult? Function(TransactionSummaryDateRangeChanged value)?
        dateRangeChanged,
    TResult? Function(TransactionSummaryAccountChanged value)? accountChanged,
  }) {
    return fetched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionSummaryFetched value)? fetched,
    TResult Function(TransactionSummaryDateRangeChanged value)?
        dateRangeChanged,
    TResult Function(TransactionSummaryAccountChanged value)? accountChanged,
    required TResult orElse(),
  }) {
    if (fetched != null) {
      return fetched(this);
    }
    return orElse();
  }
}

abstract class TransactionSummaryFetched implements TransactionSummaryEvent {
  const factory TransactionSummaryFetched() = _$TransactionSummaryFetchedImpl;
}

/// @nodoc
abstract class _$$TransactionSummaryDateRangeChangedImplCopyWith<$Res> {
  factory _$$TransactionSummaryDateRangeChangedImplCopyWith(
          _$TransactionSummaryDateRangeChangedImpl value,
          $Res Function(_$TransactionSummaryDateRangeChangedImpl) then) =
      __$$TransactionSummaryDateRangeChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime? startDate, DateTime? endDate});
}

/// @nodoc
class __$$TransactionSummaryDateRangeChangedImplCopyWithImpl<$Res>
    extends _$TransactionSummaryEventCopyWithImpl<$Res,
        _$TransactionSummaryDateRangeChangedImpl>
    implements _$$TransactionSummaryDateRangeChangedImplCopyWith<$Res> {
  __$$TransactionSummaryDateRangeChangedImplCopyWithImpl(
      _$TransactionSummaryDateRangeChangedImpl _value,
      $Res Function(_$TransactionSummaryDateRangeChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionSummaryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(_$TransactionSummaryDateRangeChangedImpl(
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$TransactionSummaryDateRangeChangedImpl
    implements TransactionSummaryDateRangeChanged {
  const _$TransactionSummaryDateRangeChangedImpl(
      {this.startDate, this.endDate});

  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;

  @override
  String toString() {
    return 'TransactionSummaryEvent.dateRangeChanged(startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionSummaryDateRangeChangedImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate);

  /// Create a copy of TransactionSummaryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionSummaryDateRangeChangedImplCopyWith<
          _$TransactionSummaryDateRangeChangedImpl>
      get copyWith => __$$TransactionSummaryDateRangeChangedImplCopyWithImpl<
          _$TransactionSummaryDateRangeChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetched,
    required TResult Function(DateTime? startDate, DateTime? endDate)
        dateRangeChanged,
    required TResult Function(int accountId) accountChanged,
  }) {
    return dateRangeChanged(startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetched,
    TResult? Function(DateTime? startDate, DateTime? endDate)? dateRangeChanged,
    TResult? Function(int accountId)? accountChanged,
  }) {
    return dateRangeChanged?.call(startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetched,
    TResult Function(DateTime? startDate, DateTime? endDate)? dateRangeChanged,
    TResult Function(int accountId)? accountChanged,
    required TResult orElse(),
  }) {
    if (dateRangeChanged != null) {
      return dateRangeChanged(startDate, endDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionSummaryFetched value) fetched,
    required TResult Function(TransactionSummaryDateRangeChanged value)
        dateRangeChanged,
    required TResult Function(TransactionSummaryAccountChanged value)
        accountChanged,
  }) {
    return dateRangeChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionSummaryFetched value)? fetched,
    TResult? Function(TransactionSummaryDateRangeChanged value)?
        dateRangeChanged,
    TResult? Function(TransactionSummaryAccountChanged value)? accountChanged,
  }) {
    return dateRangeChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionSummaryFetched value)? fetched,
    TResult Function(TransactionSummaryDateRangeChanged value)?
        dateRangeChanged,
    TResult Function(TransactionSummaryAccountChanged value)? accountChanged,
    required TResult orElse(),
  }) {
    if (dateRangeChanged != null) {
      return dateRangeChanged(this);
    }
    return orElse();
  }
}

abstract class TransactionSummaryDateRangeChanged
    implements TransactionSummaryEvent {
  const factory TransactionSummaryDateRangeChanged(
      {final DateTime? startDate,
      final DateTime? endDate}) = _$TransactionSummaryDateRangeChangedImpl;

  DateTime? get startDate;
  DateTime? get endDate;

  /// Create a copy of TransactionSummaryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionSummaryDateRangeChangedImplCopyWith<
          _$TransactionSummaryDateRangeChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransactionSummaryAccountChangedImplCopyWith<$Res> {
  factory _$$TransactionSummaryAccountChangedImplCopyWith(
          _$TransactionSummaryAccountChangedImpl value,
          $Res Function(_$TransactionSummaryAccountChangedImpl) then) =
      __$$TransactionSummaryAccountChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int accountId});
}

/// @nodoc
class __$$TransactionSummaryAccountChangedImplCopyWithImpl<$Res>
    extends _$TransactionSummaryEventCopyWithImpl<$Res,
        _$TransactionSummaryAccountChangedImpl>
    implements _$$TransactionSummaryAccountChangedImplCopyWith<$Res> {
  __$$TransactionSummaryAccountChangedImplCopyWithImpl(
      _$TransactionSummaryAccountChangedImpl _value,
      $Res Function(_$TransactionSummaryAccountChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionSummaryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
  }) {
    return _then(_$TransactionSummaryAccountChangedImpl(
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TransactionSummaryAccountChangedImpl
    implements TransactionSummaryAccountChanged {
  const _$TransactionSummaryAccountChangedImpl({required this.accountId});

  @override
  final int accountId;

  @override
  String toString() {
    return 'TransactionSummaryEvent.accountChanged(accountId: $accountId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionSummaryAccountChangedImpl &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, accountId);

  /// Create a copy of TransactionSummaryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionSummaryAccountChangedImplCopyWith<
          _$TransactionSummaryAccountChangedImpl>
      get copyWith => __$$TransactionSummaryAccountChangedImplCopyWithImpl<
          _$TransactionSummaryAccountChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fetched,
    required TResult Function(DateTime? startDate, DateTime? endDate)
        dateRangeChanged,
    required TResult Function(int accountId) accountChanged,
  }) {
    return accountChanged(accountId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fetched,
    TResult? Function(DateTime? startDate, DateTime? endDate)? dateRangeChanged,
    TResult? Function(int accountId)? accountChanged,
  }) {
    return accountChanged?.call(accountId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fetched,
    TResult Function(DateTime? startDate, DateTime? endDate)? dateRangeChanged,
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
    required TResult Function(TransactionSummaryFetched value) fetched,
    required TResult Function(TransactionSummaryDateRangeChanged value)
        dateRangeChanged,
    required TResult Function(TransactionSummaryAccountChanged value)
        accountChanged,
  }) {
    return accountChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionSummaryFetched value)? fetched,
    TResult? Function(TransactionSummaryDateRangeChanged value)?
        dateRangeChanged,
    TResult? Function(TransactionSummaryAccountChanged value)? accountChanged,
  }) {
    return accountChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionSummaryFetched value)? fetched,
    TResult Function(TransactionSummaryDateRangeChanged value)?
        dateRangeChanged,
    TResult Function(TransactionSummaryAccountChanged value)? accountChanged,
    required TResult orElse(),
  }) {
    if (accountChanged != null) {
      return accountChanged(this);
    }
    return orElse();
  }
}

abstract class TransactionSummaryAccountChanged
    implements TransactionSummaryEvent {
  const factory TransactionSummaryAccountChanged(
      {required final int accountId}) = _$TransactionSummaryAccountChangedImpl;

  int get accountId;

  /// Create a copy of TransactionSummaryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionSummaryAccountChangedImplCopyWith<
          _$TransactionSummaryAccountChangedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransactionSummaryState {
  TransactionSummaryStatus get status => throw _privateConstructorUsedError;
  TransactionSummary? get summary => throw _privateConstructorUsedError;
  int get accountId => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of TransactionSummaryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionSummaryStateCopyWith<TransactionSummaryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionSummaryStateCopyWith<$Res> {
  factory $TransactionSummaryStateCopyWith(TransactionSummaryState value,
          $Res Function(TransactionSummaryState) then) =
      _$TransactionSummaryStateCopyWithImpl<$Res, TransactionSummaryState>;
  @useResult
  $Res call(
      {TransactionSummaryStatus status,
      TransactionSummary? summary,
      int accountId,
      DateTime? startDate,
      DateTime? endDate,
      String errorMessage});

  $TransactionSummaryCopyWith<$Res>? get summary;
}

/// @nodoc
class _$TransactionSummaryStateCopyWithImpl<$Res,
        $Val extends TransactionSummaryState>
    implements $TransactionSummaryStateCopyWith<$Res> {
  _$TransactionSummaryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionSummaryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? summary = freezed,
    Object? accountId = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? errorMessage = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransactionSummaryStatus,
      summary: freezed == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as TransactionSummary?,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of TransactionSummaryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionSummaryCopyWith<$Res>? get summary {
    if (_value.summary == null) {
      return null;
    }

    return $TransactionSummaryCopyWith<$Res>(_value.summary!, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransactionSummaryStateImplCopyWith<$Res>
    implements $TransactionSummaryStateCopyWith<$Res> {
  factory _$$TransactionSummaryStateImplCopyWith(
          _$TransactionSummaryStateImpl value,
          $Res Function(_$TransactionSummaryStateImpl) then) =
      __$$TransactionSummaryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TransactionSummaryStatus status,
      TransactionSummary? summary,
      int accountId,
      DateTime? startDate,
      DateTime? endDate,
      String errorMessage});

  @override
  $TransactionSummaryCopyWith<$Res>? get summary;
}

/// @nodoc
class __$$TransactionSummaryStateImplCopyWithImpl<$Res>
    extends _$TransactionSummaryStateCopyWithImpl<$Res,
        _$TransactionSummaryStateImpl>
    implements _$$TransactionSummaryStateImplCopyWith<$Res> {
  __$$TransactionSummaryStateImplCopyWithImpl(
      _$TransactionSummaryStateImpl _value,
      $Res Function(_$TransactionSummaryStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionSummaryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? summary = freezed,
    Object? accountId = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? errorMessage = null,
  }) {
    return _then(_$TransactionSummaryStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransactionSummaryStatus,
      summary: freezed == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as TransactionSummary?,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TransactionSummaryStateImpl implements _TransactionSummaryState {
  const _$TransactionSummaryStateImpl(
      {this.status = TransactionSummaryStatus.initial,
      this.summary,
      this.accountId = 0,
      this.startDate,
      this.endDate,
      this.errorMessage = ''});

  @override
  @JsonKey()
  final TransactionSummaryStatus status;
  @override
  final TransactionSummary? summary;
  @override
  @JsonKey()
  final int accountId;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  @JsonKey()
  final String errorMessage;

  @override
  String toString() {
    return 'TransactionSummaryState(status: $status, summary: $summary, accountId: $accountId, startDate: $startDate, endDate: $endDate, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionSummaryStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, summary, accountId,
      startDate, endDate, errorMessage);

  /// Create a copy of TransactionSummaryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionSummaryStateImplCopyWith<_$TransactionSummaryStateImpl>
      get copyWith => __$$TransactionSummaryStateImplCopyWithImpl<
          _$TransactionSummaryStateImpl>(this, _$identity);
}

abstract class _TransactionSummaryState implements TransactionSummaryState {
  const factory _TransactionSummaryState(
      {final TransactionSummaryStatus status,
      final TransactionSummary? summary,
      final int accountId,
      final DateTime? startDate,
      final DateTime? endDate,
      final String errorMessage}) = _$TransactionSummaryStateImpl;

  @override
  TransactionSummaryStatus get status;
  @override
  TransactionSummary? get summary;
  @override
  int get accountId;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  String get errorMessage;

  /// Create a copy of TransactionSummaryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionSummaryStateImplCopyWith<_$TransactionSummaryStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
