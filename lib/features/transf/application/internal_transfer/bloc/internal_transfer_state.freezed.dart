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
  AccountNumber? get accountNumber => throw _privateConstructorUsedError;
  String get accountHolderName => throw _privateConstructorUsedError;
  Amount? get amount => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  VerificationStatus get verificationStatus =>
      throw _privateConstructorUsedError;
  TransferStatus get transferStatus => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  TransferResult? get transferResult => throw _privateConstructorUsedError;
  bool get showErrorMessages => throw _privateConstructorUsedError;
  bool get hasSufficientFunds => throw _privateConstructorUsedError;
  double? get accountBalance => throw _privateConstructorUsedError;

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
      {AccountNumber? accountNumber,
      String accountHolderName,
      Amount? amount,
      String reason,
      VerificationStatus verificationStatus,
      TransferStatus transferStatus,
      Failure? failure,
      TransferResult? transferResult,
      bool showErrorMessages,
      bool hasSufficientFunds,
      double? accountBalance});

  $FailureCopyWith<$Res>? get failure;
  $TransferResultCopyWith<$Res>? get transferResult;
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
    Object? accountNumber = freezed,
    Object? accountHolderName = null,
    Object? amount = freezed,
    Object? reason = null,
    Object? verificationStatus = null,
    Object? transferStatus = null,
    Object? failure = freezed,
    Object? transferResult = freezed,
    Object? showErrorMessages = null,
    Object? hasSufficientFunds = null,
    Object? accountBalance = freezed,
  }) {
    return _then(_value.copyWith(
      accountNumber: freezed == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as AccountNumber?,
      accountHolderName: null == accountHolderName
          ? _value.accountHolderName
          : accountHolderName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as Amount?,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      verificationStatus: null == verificationStatus
          ? _value.verificationStatus
          : verificationStatus // ignore: cast_nullable_to_non_nullable
              as VerificationStatus,
      transferStatus: null == transferStatus
          ? _value.transferStatus
          : transferStatus // ignore: cast_nullable_to_non_nullable
              as TransferStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      transferResult: freezed == transferResult
          ? _value.transferResult
          : transferResult // ignore: cast_nullable_to_non_nullable
              as TransferResult?,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      hasSufficientFunds: null == hasSufficientFunds
          ? _value.hasSufficientFunds
          : hasSufficientFunds // ignore: cast_nullable_to_non_nullable
              as bool,
      accountBalance: freezed == accountBalance
          ? _value.accountBalance
          : accountBalance // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  /// Create a copy of InternalTransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureCopyWith<$Res>? get failure {
    if (_value.failure == null) {
      return null;
    }

    return $FailureCopyWith<$Res>(_value.failure!, (value) {
      return _then(_value.copyWith(failure: value) as $Val);
    });
  }

  /// Create a copy of InternalTransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransferResultCopyWith<$Res>? get transferResult {
    if (_value.transferResult == null) {
      return null;
    }

    return $TransferResultCopyWith<$Res>(_value.transferResult!, (value) {
      return _then(_value.copyWith(transferResult: value) as $Val);
    });
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
      {AccountNumber? accountNumber,
      String accountHolderName,
      Amount? amount,
      String reason,
      VerificationStatus verificationStatus,
      TransferStatus transferStatus,
      Failure? failure,
      TransferResult? transferResult,
      bool showErrorMessages,
      bool hasSufficientFunds,
      double? accountBalance});

  @override
  $FailureCopyWith<$Res>? get failure;
  @override
  $TransferResultCopyWith<$Res>? get transferResult;
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
    Object? accountNumber = freezed,
    Object? accountHolderName = null,
    Object? amount = freezed,
    Object? reason = null,
    Object? verificationStatus = null,
    Object? transferStatus = null,
    Object? failure = freezed,
    Object? transferResult = freezed,
    Object? showErrorMessages = null,
    Object? hasSufficientFunds = null,
    Object? accountBalance = freezed,
  }) {
    return _then(_$InternalTransferStateImpl(
      accountNumber: freezed == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as AccountNumber?,
      accountHolderName: null == accountHolderName
          ? _value.accountHolderName
          : accountHolderName // ignore: cast_nullable_to_non_nullable
              as String,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as Amount?,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      verificationStatus: null == verificationStatus
          ? _value.verificationStatus
          : verificationStatus // ignore: cast_nullable_to_non_nullable
              as VerificationStatus,
      transferStatus: null == transferStatus
          ? _value.transferStatus
          : transferStatus // ignore: cast_nullable_to_non_nullable
              as TransferStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      transferResult: freezed == transferResult
          ? _value.transferResult
          : transferResult // ignore: cast_nullable_to_non_nullable
              as TransferResult?,
      showErrorMessages: null == showErrorMessages
          ? _value.showErrorMessages
          : showErrorMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      hasSufficientFunds: null == hasSufficientFunds
          ? _value.hasSufficientFunds
          : hasSufficientFunds // ignore: cast_nullable_to_non_nullable
              as bool,
      accountBalance: freezed == accountBalance
          ? _value.accountBalance
          : accountBalance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$InternalTransferStateImpl extends _InternalTransferState {
  const _$InternalTransferStateImpl(
      {this.accountNumber,
      this.accountHolderName = '',
      this.amount,
      this.reason = '',
      this.verificationStatus = VerificationStatus.initial,
      this.transferStatus = TransferStatus.initial,
      this.failure,
      this.transferResult,
      this.showErrorMessages = false,
      this.hasSufficientFunds = true,
      this.accountBalance})
      : super._();

  @override
  final AccountNumber? accountNumber;
  @override
  @JsonKey()
  final String accountHolderName;
  @override
  final Amount? amount;
  @override
  @JsonKey()
  final String reason;
  @override
  @JsonKey()
  final VerificationStatus verificationStatus;
  @override
  @JsonKey()
  final TransferStatus transferStatus;
  @override
  final Failure? failure;
  @override
  final TransferResult? transferResult;
  @override
  @JsonKey()
  final bool showErrorMessages;
  @override
  @JsonKey()
  final bool hasSufficientFunds;
  @override
  final double? accountBalance;

  @override
  String toString() {
    return 'InternalTransferState(accountNumber: $accountNumber, accountHolderName: $accountHolderName, amount: $amount, reason: $reason, verificationStatus: $verificationStatus, transferStatus: $transferStatus, failure: $failure, transferResult: $transferResult, showErrorMessages: $showErrorMessages, hasSufficientFunds: $hasSufficientFunds, accountBalance: $accountBalance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InternalTransferStateImpl &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.accountHolderName, accountHolderName) ||
                other.accountHolderName == accountHolderName) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.verificationStatus, verificationStatus) ||
                other.verificationStatus == verificationStatus) &&
            (identical(other.transferStatus, transferStatus) ||
                other.transferStatus == transferStatus) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.transferResult, transferResult) ||
                other.transferResult == transferResult) &&
            (identical(other.showErrorMessages, showErrorMessages) ||
                other.showErrorMessages == showErrorMessages) &&
            (identical(other.hasSufficientFunds, hasSufficientFunds) ||
                other.hasSufficientFunds == hasSufficientFunds) &&
            (identical(other.accountBalance, accountBalance) ||
                other.accountBalance == accountBalance));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      accountNumber,
      accountHolderName,
      amount,
      reason,
      verificationStatus,
      transferStatus,
      failure,
      transferResult,
      showErrorMessages,
      hasSufficientFunds,
      accountBalance);

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
      {final AccountNumber? accountNumber,
      final String accountHolderName,
      final Amount? amount,
      final String reason,
      final VerificationStatus verificationStatus,
      final TransferStatus transferStatus,
      final Failure? failure,
      final TransferResult? transferResult,
      final bool showErrorMessages,
      final bool hasSufficientFunds,
      final double? accountBalance}) = _$InternalTransferStateImpl;
  const _InternalTransferState._() : super._();

  @override
  AccountNumber? get accountNumber;
  @override
  String get accountHolderName;
  @override
  Amount? get amount;
  @override
  String get reason;
  @override
  VerificationStatus get verificationStatus;
  @override
  TransferStatus get transferStatus;
  @override
  Failure? get failure;
  @override
  TransferResult? get transferResult;
  @override
  bool get showErrorMessages;
  @override
  bool get hasSufficientFunds;
  @override
  double? get accountBalance;

  /// Create a copy of InternalTransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InternalTransferStateImplCopyWith<_$InternalTransferStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
