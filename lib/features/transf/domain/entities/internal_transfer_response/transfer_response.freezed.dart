// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransferResponse _$TransferResponseFromJson(Map<String, dynamic> json) {
  return _TransferResponse.fromJson(json);
}

/// @nodoc
mixin _$TransferResponse {
  /// Transfer ID
  @JsonKey(name: 'transfer_id')
  String get transferId => throw _privateConstructorUsedError;

  /// Status of the transfer
  String get status => throw _privateConstructorUsedError;

  /// Transaction reference number
  @JsonKey(name: 'transaction_ref')
  String get transactionRef => throw _privateConstructorUsedError;

  /// Date and time of the transfer
  @JsonKey(name: 'timestamp')
  String get timestamp => throw _privateConstructorUsedError;

  /// Amount transferred
  double get amount => throw _privateConstructorUsedError;

  /// Source account ID
  @JsonKey(name: 'from_account_id')
  String get fromAccountId => throw _privateConstructorUsedError;

  /// Destination account ID
  @JsonKey(name: 'to_account_id')
  String get toAccountId => throw _privateConstructorUsedError;

  /// Optional message
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this TransferResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransferResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransferResponseCopyWith<TransferResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferResponseCopyWith<$Res> {
  factory $TransferResponseCopyWith(
          TransferResponse value, $Res Function(TransferResponse) then) =
      _$TransferResponseCopyWithImpl<$Res, TransferResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'transfer_id') String transferId,
      String status,
      @JsonKey(name: 'transaction_ref') String transactionRef,
      @JsonKey(name: 'timestamp') String timestamp,
      double amount,
      @JsonKey(name: 'from_account_id') String fromAccountId,
      @JsonKey(name: 'to_account_id') String toAccountId,
      String? message});
}

/// @nodoc
class _$TransferResponseCopyWithImpl<$Res, $Val extends TransferResponse>
    implements $TransferResponseCopyWith<$Res> {
  _$TransferResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransferResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transferId = null,
    Object? status = null,
    Object? transactionRef = null,
    Object? timestamp = null,
    Object? amount = null,
    Object? fromAccountId = null,
    Object? toAccountId = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      transferId: null == transferId
          ? _value.transferId
          : transferId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      transactionRef: null == transactionRef
          ? _value.transactionRef
          : transactionRef // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      fromAccountId: null == fromAccountId
          ? _value.fromAccountId
          : fromAccountId // ignore: cast_nullable_to_non_nullable
              as String,
      toAccountId: null == toAccountId
          ? _value.toAccountId
          : toAccountId // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransferResponseImplCopyWith<$Res>
    implements $TransferResponseCopyWith<$Res> {
  factory _$$TransferResponseImplCopyWith(_$TransferResponseImpl value,
          $Res Function(_$TransferResponseImpl) then) =
      __$$TransferResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'transfer_id') String transferId,
      String status,
      @JsonKey(name: 'transaction_ref') String transactionRef,
      @JsonKey(name: 'timestamp') String timestamp,
      double amount,
      @JsonKey(name: 'from_account_id') String fromAccountId,
      @JsonKey(name: 'to_account_id') String toAccountId,
      String? message});
}

/// @nodoc
class __$$TransferResponseImplCopyWithImpl<$Res>
    extends _$TransferResponseCopyWithImpl<$Res, _$TransferResponseImpl>
    implements _$$TransferResponseImplCopyWith<$Res> {
  __$$TransferResponseImplCopyWithImpl(_$TransferResponseImpl _value,
      $Res Function(_$TransferResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransferResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transferId = null,
    Object? status = null,
    Object? transactionRef = null,
    Object? timestamp = null,
    Object? amount = null,
    Object? fromAccountId = null,
    Object? toAccountId = null,
    Object? message = freezed,
  }) {
    return _then(_$TransferResponseImpl(
      transferId: null == transferId
          ? _value.transferId
          : transferId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      transactionRef: null == transactionRef
          ? _value.transactionRef
          : transactionRef // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      fromAccountId: null == fromAccountId
          ? _value.fromAccountId
          : fromAccountId // ignore: cast_nullable_to_non_nullable
              as String,
      toAccountId: null == toAccountId
          ? _value.toAccountId
          : toAccountId // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransferResponseImpl implements _TransferResponse {
  const _$TransferResponseImpl(
      {@JsonKey(name: 'transfer_id') required this.transferId,
      required this.status,
      @JsonKey(name: 'transaction_ref') required this.transactionRef,
      @JsonKey(name: 'timestamp') required this.timestamp,
      required this.amount,
      @JsonKey(name: 'from_account_id') required this.fromAccountId,
      @JsonKey(name: 'to_account_id') required this.toAccountId,
      this.message});

  factory _$TransferResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferResponseImplFromJson(json);

  /// Transfer ID
  @override
  @JsonKey(name: 'transfer_id')
  final String transferId;

  /// Status of the transfer
  @override
  final String status;

  /// Transaction reference number
  @override
  @JsonKey(name: 'transaction_ref')
  final String transactionRef;

  /// Date and time of the transfer
  @override
  @JsonKey(name: 'timestamp')
  final String timestamp;

  /// Amount transferred
  @override
  final double amount;

  /// Source account ID
  @override
  @JsonKey(name: 'from_account_id')
  final String fromAccountId;

  /// Destination account ID
  @override
  @JsonKey(name: 'to_account_id')
  final String toAccountId;

  /// Optional message
  @override
  final String? message;

  @override
  String toString() {
    return 'TransferResponse(transferId: $transferId, status: $status, transactionRef: $transactionRef, timestamp: $timestamp, amount: $amount, fromAccountId: $fromAccountId, toAccountId: $toAccountId, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferResponseImpl &&
            (identical(other.transferId, transferId) ||
                other.transferId == transferId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.transactionRef, transactionRef) ||
                other.transactionRef == transactionRef) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.fromAccountId, fromAccountId) ||
                other.fromAccountId == fromAccountId) &&
            (identical(other.toAccountId, toAccountId) ||
                other.toAccountId == toAccountId) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, transferId, status,
      transactionRef, timestamp, amount, fromAccountId, toAccountId, message);

  /// Create a copy of TransferResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferResponseImplCopyWith<_$TransferResponseImpl> get copyWith =>
      __$$TransferResponseImplCopyWithImpl<_$TransferResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferResponseImplToJson(
      this,
    );
  }
}

abstract class _TransferResponse implements TransferResponse {
  const factory _TransferResponse(
      {@JsonKey(name: 'transfer_id') required final String transferId,
      required final String status,
      @JsonKey(name: 'transaction_ref') required final String transactionRef,
      @JsonKey(name: 'timestamp') required final String timestamp,
      required final double amount,
      @JsonKey(name: 'from_account_id') required final String fromAccountId,
      @JsonKey(name: 'to_account_id') required final String toAccountId,
      final String? message}) = _$TransferResponseImpl;

  factory _TransferResponse.fromJson(Map<String, dynamic> json) =
      _$TransferResponseImpl.fromJson;

  /// Transfer ID
  @override
  @JsonKey(name: 'transfer_id')
  String get transferId;

  /// Status of the transfer
  @override
  String get status;

  /// Transaction reference number
  @override
  @JsonKey(name: 'transaction_ref')
  String get transactionRef;

  /// Date and time of the transfer
  @override
  @JsonKey(name: 'timestamp')
  String get timestamp;

  /// Amount transferred
  @override
  double get amount;

  /// Source account ID
  @override
  @JsonKey(name: 'from_account_id')
  String get fromAccountId;

  /// Destination account ID
  @override
  @JsonKey(name: 'to_account_id')
  String get toAccountId;

  /// Optional message
  @override
  String? get message;

  /// Create a copy of TransferResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferResponseImplCopyWith<_$TransferResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Transfer _$TransferFromJson(Map<String, dynamic> json) {
  return _Transfer.fromJson(json);
}

/// @nodoc
mixin _$Transfer {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'from_account_id')
  int get fromAccountId => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_account_id')
  int get toAccountId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Transfer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransferCopyWith<Transfer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferCopyWith<$Res> {
  factory $TransferCopyWith(Transfer value, $Res Function(Transfer) then) =
      _$TransferCopyWithImpl<$Res, Transfer>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'from_account_id') int fromAccountId,
      @JsonKey(name: 'to_account_id') int toAccountId,
      double amount,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$TransferCopyWithImpl<$Res, $Val extends Transfer>
    implements $TransferCopyWith<$Res> {
  _$TransferCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromAccountId = null,
    Object? toAccountId = null,
    Object? amount = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
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
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransferImplCopyWith<$Res>
    implements $TransferCopyWith<$Res> {
  factory _$$TransferImplCopyWith(
          _$TransferImpl value, $Res Function(_$TransferImpl) then) =
      __$$TransferImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'from_account_id') int fromAccountId,
      @JsonKey(name: 'to_account_id') int toAccountId,
      double amount,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$TransferImplCopyWithImpl<$Res>
    extends _$TransferCopyWithImpl<$Res, _$TransferImpl>
    implements _$$TransferImplCopyWith<$Res> {
  __$$TransferImplCopyWithImpl(
      _$TransferImpl _value, $Res Function(_$TransferImpl) _then)
      : super(_value, _then);

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromAccountId = null,
    Object? toAccountId = null,
    Object? amount = null,
    Object? createdAt = null,
  }) {
    return _then(_$TransferImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
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
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransferImpl implements _Transfer {
  const _$TransferImpl(
      {required this.id,
      @JsonKey(name: 'from_account_id') required this.fromAccountId,
      @JsonKey(name: 'to_account_id') required this.toAccountId,
      required this.amount,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$TransferImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'from_account_id')
  final int fromAccountId;
  @override
  @JsonKey(name: 'to_account_id')
  final int toAccountId;
  @override
  final double amount;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'Transfer(id: $id, fromAccountId: $fromAccountId, toAccountId: $toAccountId, amount: $amount, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fromAccountId, fromAccountId) ||
                other.fromAccountId == fromAccountId) &&
            (identical(other.toAccountId, toAccountId) ||
                other.toAccountId == toAccountId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, fromAccountId, toAccountId, amount, createdAt);

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferImplCopyWith<_$TransferImpl> get copyWith =>
      __$$TransferImplCopyWithImpl<_$TransferImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferImplToJson(
      this,
    );
  }
}

abstract class _Transfer implements Transfer {
  const factory _Transfer(
          {required final int id,
          @JsonKey(name: 'from_account_id') required final int fromAccountId,
          @JsonKey(name: 'to_account_id') required final int toAccountId,
          required final double amount,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$TransferImpl;

  factory _Transfer.fromJson(Map<String, dynamic> json) =
      _$TransferImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'from_account_id')
  int get fromAccountId;
  @override
  @JsonKey(name: 'to_account_id')
  int get toAccountId;
  @override
  double get amount;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of Transfer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferImplCopyWith<_$TransferImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Account _$AccountFromJson(Map<String, dynamic> json) {
  return _Account.fromJson(json);
}

/// @nodoc
mixin _$Account {
  int get id => throw _privateConstructorUsedError;
  String get owner => throw _privateConstructorUsedError;
  double get balance => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Account to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountCopyWith<Account> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountCopyWith<$Res> {
  factory $AccountCopyWith(Account value, $Res Function(Account) then) =
      _$AccountCopyWithImpl<$Res, Account>;
  @useResult
  $Res call(
      {int id,
      String owner,
      double balance,
      String currency,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$AccountCopyWithImpl<$Res, $Val extends Account>
    implements $AccountCopyWith<$Res> {
  _$AccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? owner = null,
    Object? balance = null,
    Object? currency = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountImplCopyWith<$Res> implements $AccountCopyWith<$Res> {
  factory _$$AccountImplCopyWith(
          _$AccountImpl value, $Res Function(_$AccountImpl) then) =
      __$$AccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String owner,
      double balance,
      String currency,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$AccountImplCopyWithImpl<$Res>
    extends _$AccountCopyWithImpl<$Res, _$AccountImpl>
    implements _$$AccountImplCopyWith<$Res> {
  __$$AccountImplCopyWithImpl(
      _$AccountImpl _value, $Res Function(_$AccountImpl) _then)
      : super(_value, _then);

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? owner = null,
    Object? balance = null,
    Object? currency = null,
    Object? createdAt = null,
  }) {
    return _then(_$AccountImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountImpl implements _Account {
  const _$AccountImpl(
      {required this.id,
      required this.owner,
      required this.balance,
      required this.currency,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$AccountImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountImplFromJson(json);

  @override
  final int id;
  @override
  final String owner;
  @override
  final double balance;
  @override
  final String currency;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'Account(id: $id, owner: $owner, balance: $balance, currency: $currency, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, owner, balance, currency, createdAt);

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountImplCopyWith<_$AccountImpl> get copyWith =>
      __$$AccountImplCopyWithImpl<_$AccountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountImplToJson(
      this,
    );
  }
}

abstract class _Account implements Account {
  const factory _Account(
          {required final int id,
          required final String owner,
          required final double balance,
          required final String currency,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$AccountImpl;

  factory _Account.fromJson(Map<String, dynamic> json) = _$AccountImpl.fromJson;

  @override
  int get id;
  @override
  String get owner;
  @override
  double get balance;
  @override
  String get currency;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of Account
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountImplCopyWith<_$AccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Entry _$EntryFromJson(Map<String, dynamic> json) {
  return _Entry.fromJson(json);
}

/// @nodoc
mixin _$Entry {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'account_id')
  int get accountId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Entry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EntryCopyWith<Entry> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryCopyWith<$Res> {
  factory $EntryCopyWith(Entry value, $Res Function(Entry) then) =
      _$EntryCopyWithImpl<$Res, Entry>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'account_id') int accountId,
      double amount,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$EntryCopyWithImpl<$Res, $Val extends Entry>
    implements $EntryCopyWith<$Res> {
  _$EntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountId = null,
    Object? amount = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EntryImplCopyWith<$Res> implements $EntryCopyWith<$Res> {
  factory _$$EntryImplCopyWith(
          _$EntryImpl value, $Res Function(_$EntryImpl) then) =
      __$$EntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'account_id') int accountId,
      double amount,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$$EntryImplCopyWithImpl<$Res>
    extends _$EntryCopyWithImpl<$Res, _$EntryImpl>
    implements _$$EntryImplCopyWith<$Res> {
  __$$EntryImplCopyWithImpl(
      _$EntryImpl _value, $Res Function(_$EntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? accountId = null,
    Object? amount = null,
    Object? createdAt = null,
  }) {
    return _then(_$EntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EntryImpl implements _Entry {
  const _$EntryImpl(
      {required this.id,
      @JsonKey(name: 'account_id') required this.accountId,
      required this.amount,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$EntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntryImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'account_id')
  final int accountId;
  @override
  final double amount;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'Entry(id: $id, accountId: $accountId, amount: $amount, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, accountId, amount, createdAt);

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EntryImplCopyWith<_$EntryImpl> get copyWith =>
      __$$EntryImplCopyWithImpl<_$EntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EntryImplToJson(
      this,
    );
  }
}

abstract class _Entry implements Entry {
  const factory _Entry(
          {required final int id,
          @JsonKey(name: 'account_id') required final int accountId,
          required final double amount,
          @JsonKey(name: 'created_at') required final DateTime createdAt}) =
      _$EntryImpl;

  factory _Entry.fromJson(Map<String, dynamic> json) = _$EntryImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'account_id')
  int get accountId;
  @override
  double get amount;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntryImplCopyWith<_$EntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
