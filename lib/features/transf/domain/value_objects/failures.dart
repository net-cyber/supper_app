import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
abstract class TransferFailure<T> with _$TransferFailure<T> {
  // Account related failures
  const factory TransferFailure.invalidAccountNumber({
    required T failedValue,
  }) = InvalidAccountNumber<T>;

  const factory TransferFailure.accountNotFound({
    required T failedValue,
  }) = AccountNotFound<T>;

  // Phone number related failures
  const factory TransferFailure.invalidPhoneNumber({
    required T failedValue,
  }) = InvalidPhoneNumber<T>;

  const factory TransferFailure.phoneNumberNotFound({
    required T failedValue,
  }) = PhoneNumberNotFound<T>;

  // Wallet related failures
  const factory TransferFailure.walletAccountNotFound({
    required T failedValue,
  }) = WalletAccountNotFound<T>;

  const factory TransferFailure.invalidWalletAccount({
    required T failedValue,
  }) = InvalidWalletAccount<T>;

  // Money related failures
  const factory TransferFailure.invalidAmount({
    required T failedValue,
  }) = InvalidAmount<T>;

  const factory TransferFailure.insufficientFunds({
    required T failedValue,
    required double available,
  }) = InsufficientFunds<T>;

  const factory TransferFailure.exceedsTransferLimit({
    required T failedValue,
    required double limit,
  }) = ExceedsTransferLimit<T>;

  const factory TransferFailure.belowMinimumAmount({
    required T failedValue,
    required double minimum,
  }) = BelowMinimumAmount<T>;

  // Server related failures
  const factory TransferFailure.serverError({
    required String message,
  }) = ServerError<T>;

  const factory TransferFailure.networkError() = NetworkError<T>;

  const factory TransferFailure.unexpected() = Unexpected<T>;

  // Transaction related failures
  const factory TransferFailure.transactionNotFound() = TransactionNotFound<T>;

  // Authentication related failures
  const factory TransferFailure.unauthenticated() = Unauthenticated<T>;

  const factory TransferFailure.unauthorized() = Unauthorized<T>;

  // General failures
  const factory TransferFailure.invalidInput({
    required T failedValue,
    required String message,
  }) = InvalidInput<T>;
}
