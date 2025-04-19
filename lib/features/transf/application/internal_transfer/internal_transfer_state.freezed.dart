// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'internal_transfer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InternalTransferState {
// Basic state info
  InternalTransferStatus get status =>
      throw _privateConstructorUsedError; // Form inputs
  String get accountNumberInput => throw _privateConstructorUsedError;
  String get amountInput => throw _privateConstructorUsedError;
  String get reasonInput =>
      throw _privateConstructorUsedError; // Validated data
  BankAccount? get validatedAccount =>
      throw _privateConstructorUsedError; // Response data
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;
  String? get transactionId =>
      throw _privateConstructorUsedError; // Error handling
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of InternalTransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InternalTransferStateCopyWith<InternalTransferState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InternalTransferStateCopyWith<$Res> {
  factory $InternalTransferStateCopyWith(InternalTransferState value,
          $Res Function(InternalTransferState) then) =
      _$InternalTransferStateCopyWithImpl<$Res, InternalTransferState>;
  @useResult
  $Res call(
      {InternalTransferStatus status,
      String accountNumberInput,
      String amountInput,
      String reasonInput,
      BankAccount? validatedAccount,
      bool isLoading,
      bool isSuccess,
      String? transactionId,
      String? errorMessage});
}

/// @nodoc
class _$InternalTransferStateCopyWithImpl<$Res,
        $Val extends InternalTransferState>
    implements $InternalTransferStateCopyWith<$Res> {
  _$InternalTransferStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InternalTransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? accountNumberInput = null,
    Object? amountInput = null,
    Object? reasonInput = null,
    Object? validatedAccount = freezed,
    Object? isLoading = null,
    Object? isSuccess = null,
    Object? transactionId = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as InternalTransferStatus,
      accountNumberInput: null == accountNumberInput
          ? _value.accountNumberInput
          : accountNumberInput // ignore: cast_nullable_to_non_nullable
              as String,
      amountInput: null == amountInput
          ? _value.amountInput
          : amountInput // ignore: cast_nullable_to_non_nullable
              as String,
      reasonInput: null == reasonInput
          ? _value.reasonInput
          : reasonInput // ignore: cast_nullable_to_non_nullable
              as String,
      validatedAccount: freezed == validatedAccount
          ? _value.validatedAccount
          : validatedAccount // ignore: cast_nullable_to_non_nullable
              as BankAccount?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InternalTransferStateImplCopyWith<$Res>
    implements $InternalTransferStateCopyWith<$Res> {
  factory _$$InternalTransferStateImplCopyWith(
          _$InternalTransferStateImpl value,
          $Res Function(_$InternalTransferStateImpl) then) =
      __$$InternalTransferStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {InternalTransferStatus status,
      String accountNumberInput,
      String amountInput,
      String reasonInput,
      BankAccount? validatedAccount,
      bool isLoading,
      bool isSuccess,
      String? transactionId,
      String? errorMessage});
}

/// @nodoc
class __$$InternalTransferStateImplCopyWithImpl<$Res>
    extends _$InternalTransferStateCopyWithImpl<$Res,
        _$InternalTransferStateImpl>
    implements _$$InternalTransferStateImplCopyWith<$Res> {
  __$$InternalTransferStateImplCopyWithImpl(_$InternalTransferStateImpl _value,
      $Res Function(_$InternalTransferStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of InternalTransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? accountNumberInput = null,
    Object? amountInput = null,
    Object? reasonInput = null,
    Object? validatedAccount = freezed,
    Object? isLoading = null,
    Object? isSuccess = null,
    Object? transactionId = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_$InternalTransferStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as InternalTransferStatus,
      accountNumberInput: null == accountNumberInput
          ? _value.accountNumberInput
          : accountNumberInput // ignore: cast_nullable_to_non_nullable
              as String,
      amountInput: null == amountInput
          ? _value.amountInput
          : amountInput // ignore: cast_nullable_to_non_nullable
              as String,
      reasonInput: null == reasonInput
          ? _value.reasonInput
          : reasonInput // ignore: cast_nullable_to_non_nullable
              as String,
      validatedAccount: freezed == validatedAccount
          ? _value.validatedAccount
          : validatedAccount // ignore: cast_nullable_to_non_nullable
              as BankAccount?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$InternalTransferStateImpl extends _InternalTransferState {
  const _$InternalTransferStateImpl(
      {required this.status,
      this.accountNumberInput = '',
      this.amountInput = '',
      this.reasonInput = '',
      this.validatedAccount,
      this.isLoading = false,
      this.isSuccess = false,
      this.transactionId,
      this.errorMessage})
      : super._();

// Basic state info
  @override
  final InternalTransferStatus status;
// Form inputs
  @override
  @JsonKey()
  final String accountNumberInput;
  @override
  @JsonKey()
  final String amountInput;
  @override
  @JsonKey()
  final String reasonInput;
// Validated data
  @override
  final BankAccount? validatedAccount;
// Response data
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSuccess;
  @override
  final String? transactionId;
// Error handling
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'InternalTransferState(status: $status, accountNumberInput: $accountNumberInput, amountInput: $amountInput, reasonInput: $reasonInput, validatedAccount: $validatedAccount, isLoading: $isLoading, isSuccess: $isSuccess, transactionId: $transactionId, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InternalTransferStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.accountNumberInput, accountNumberInput) ||
                other.accountNumberInput == accountNumberInput) &&
            (identical(other.amountInput, amountInput) ||
                other.amountInput == amountInput) &&
            (identical(other.reasonInput, reasonInput) ||
                other.reasonInput == reasonInput) &&
            (identical(other.validatedAccount, validatedAccount) ||
                other.validatedAccount == validatedAccount) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      accountNumberInput,
      amountInput,
      reasonInput,
      validatedAccount,
      isLoading,
      isSuccess,
      transactionId,
      errorMessage);

  /// Create a copy of InternalTransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InternalTransferStateImplCopyWith<_$InternalTransferStateImpl>
      get copyWith => __$$InternalTransferStateImplCopyWithImpl<
          _$InternalTransferStateImpl>(this, _$identity);
}

abstract class _InternalTransferState extends InternalTransferState {
  const factory _InternalTransferState(
      {required final InternalTransferStatus status,
      final String accountNumberInput,
      final String amountInput,
      final String reasonInput,
      final BankAccount? validatedAccount,
      final bool isLoading,
      final bool isSuccess,
      final String? transactionId,
      final String? errorMessage}) = _$InternalTransferStateImpl;
  const _InternalTransferState._() : super._();

// Basic state info
  @override
  InternalTransferStatus get status; // Form inputs
  @override
  String get accountNumberInput;
  @override
  String get amountInput;
  @override
  String get reasonInput; // Validated data
  @override
  BankAccount? get validatedAccount; // Response data
  @override
  bool get isLoading;
  @override
  bool get isSuccess;
  @override
  String? get transactionId; // Error handling
  @override
  String? get errorMessage;

  /// Create a copy of InternalTransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InternalTransferStateImplCopyWith<_$InternalTransferStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
