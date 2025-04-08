import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:super_app/features/transf/domain/entities/transfer_result.dart';
import 'package:super_app/features/transf/domain/failures/failure.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

part 'internal_transfer_state.freezed.dart';

enum VerificationStatus { initial, loading, success, failure }

enum TransferStatus { initial, loading, success, failure }

@freezed
class InternalTransferState with _$InternalTransferState {
  const factory InternalTransferState({
    AccountNumber? accountNumber,
    @Default('') String accountHolderName,
    Amount? amount,
    @Default('') String reason,
    @Default(VerificationStatus.initial) VerificationStatus verificationStatus,
    @Default(TransferStatus.initial) TransferStatus transferStatus,
    Failure? failure,
    TransferResult? transferResult,
    @Default(false) bool showErrorMessages,
    @Default(true) bool hasSufficientFunds,
    double? accountBalance,
  }) = _InternalTransferState;

  const InternalTransferState._();

  factory InternalTransferState.initial() => const InternalTransferState();

  bool get isAccountVerified =>
      verificationStatus == VerificationStatus.success &&
      accountHolderName.isNotEmpty;

  bool get isAmountValid => amount != null && amount!.isValid();

  bool get isFormValid =>
      isAccountVerified && isAmountValid && hasSufficientFunds;

  bool get isVerifying => verificationStatus == VerificationStatus.loading;

  bool get isTransferring => transferStatus == TransferStatus.loading;

  bool get hasTransferSucceeded => transferStatus == TransferStatus.success;

  bool get hasTransferFailed => transferStatus == TransferStatus.failure;
}
