import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';

part 'internal_transfer_event.freezed.dart';

@freezed
class InternalTransferEvent with _$InternalTransferEvent {
  const factory InternalTransferEvent.accountNumberChanged(
      String accountNumber) = AccountNumberChanged;

  const factory InternalTransferEvent.verifyAccount(String accountNumber) =
      VerifyAccount;

  const factory InternalTransferEvent.amountChanged(String amount) =
      AmountChanged;

  const factory InternalTransferEvent.reasonChanged(String reason) =
      ReasonChanged;

  const factory InternalTransferEvent.submitTransfer({
    required AccountNumber fromAccountNumber,
    required AccountNumber toAccountNumber,
    required Amount amount,
    String? reason,
  }) = SubmitTransfer;

  const factory InternalTransferEvent.resetState() = ResetState;
}
