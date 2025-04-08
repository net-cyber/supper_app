import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:super_app/core/value_object/common_interfaces.dart';
import 'package:super_app/features/transf/domain/value_objects/failures.dart';
import 'package:super_app/features/transf/domain/value_objects/value_validators.dart';

/// Error thrown when a value object contains an invalid value
class UnexpectedTransferError extends Error {
  final TransferFailure failure;

  UnexpectedTransferError(this.failure);

  @override
  String toString() {
    const explanation =
        'Encountered a TransferFailure at an unrecoverable point.';
    return Error.safeToString('$explanation Failure was: $failure');
  }
}

/// Base class for all transfer-related value objects
@immutable
abstract class TransferValueObject<T> implements IValidatable {
  const TransferValueObject();

  Either<TransferFailure<T>, T> get value;

  /// Gets the value or returns a default
  T getOrElse(T dflt) {
    return value.getOrElse(() => dflt);
  }

  /// Gets the value or throws an exception
  T getOrCrash() {
    return value.fold(
      (f) => throw UnexpectedTransferError(f),
      (r) => r,
    );
  }

  /// Maps success to Unit for validation chains
  Either<TransferFailure<dynamic>, Unit> get failureOrUnit {
    return value.fold(
      left,
      (r) => right(unit),
    );
  }

  @override
  bool isValid() {
    return value.isRight();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TransferValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}

/// Represents a unique identifier for entities
class TransferId extends TransferValueObject<String> {
  @override
  final Either<TransferFailure<String>, String> value;

  const TransferId._(this.value);

  /// Creates a new ID with a timestamp-based ID
  factory TransferId() {
    return TransferId._(
        right(DateTime.now().millisecondsSinceEpoch.toString()));
  }

  /// Creates an ID from an existing string
  factory TransferId.fromString(String id) {
    return TransferId._(right(id));
  }
}

/// Represents an account number in the banking system
class AccountNumber extends TransferValueObject<String> {
  @override
  final Either<TransferFailure<String>, String> value;

  const AccountNumber._(this.value);

  factory AccountNumber(String input) {
    return AccountNumber._(validateAccountNumber(input));
  }
}

/// Represents a phone number associated with a wallet
class PhoneNumber extends TransferValueObject<String> {
  @override
  final Either<TransferFailure<String>, String> value;

  const PhoneNumber._(this.value);

  factory PhoneNumber(String input) {
    return PhoneNumber._(validateEthiopianPhoneNumber(input));
  }
}

/// Represents a monetary amount
class Money extends TransferValueObject<double> {
  @override
  final Either<TransferFailure<double>, double> value;

  final String currency;

  const Money._({required this.value, required this.currency});

  factory Money({required double amount, String currency = 'ETB'}) {
    return Money._(
      value: validateAmount(amount),
      currency: currency,
    );
  }

  factory Money.fromString({required String amount, String currency = 'ETB'}) {
    return Money._(
      value: parseAndValidateAmount(amount).fold(
        (failure) => left(TransferFailure.invalidAmount(failedValue: 0.0)),
        (amount) => validateAmount(amount),
      ),
      currency: currency,
    );
  }

  /// Add another money value of the same currency
  Money add(Money other) {
    if (currency != other.currency) {
      return Money._(
        value: left(TransferFailure.invalidAmount(failedValue: 0.0)),
        currency: currency,
      );
    }

    return value.fold(
      (failure) => Money._(value: left(failure), currency: currency),
      (amount) => other.value.fold(
        (failure) => Money._(value: left(failure), currency: currency),
        (otherAmount) =>
            Money(amount: amount + otherAmount, currency: currency),
      ),
    );
  }

  /// Subtract another money value of the same currency
  Money subtract(Money other) {
    if (currency != other.currency) {
      return Money._(
        value: left(TransferFailure.invalidAmount(failedValue: 0.0)),
        currency: currency,
      );
    }

    return value.fold(
      (failure) => Money._(value: left(failure), currency: currency),
      (amount) => other.value.fold(
        (failure) => Money._(value: left(failure), currency: currency),
        (otherAmount) {
          final result = amount - otherAmount;
          if (result < 0) {
            return Money._(
              value: left(TransferFailure.insufficientFunds(
                failedValue: amount,
                available: amount,
              )),
              currency: currency,
            );
          }
          return Money(amount: result, currency: currency);
        },
      ),
    );
  }

  /// Format the money value with its currency
  String get formatted {
    return value.fold(
      (failure) => '0.00 $currency',
      (amount) => '${amount.toStringAsFixed(2)} $currency',
    );
  }
}

/// Represents the reason for a transfer
class TransferReason extends TransferValueObject<String> {
  @override
  final Either<TransferFailure<String>, String> value;

  const TransferReason._(this.value);

  factory TransferReason(String input) {
    return TransferReason._(validateTransferReason(input));
  }

  factory TransferReason.empty() {
    return TransferReason._(right(''));
  }
}

/// Represents a bank code from the backend API
class BankCode extends TransferValueObject<String> {
  @override
  final Either<TransferFailure<String>, String> value;

  const BankCode._(this.value);

  /// Creates a bank code from a string provided by the API
  factory BankCode(String input) {
    return BankCode._(validateBankCode(input));
  }

  /// Convenience factory for Goh Betoch Bank
  factory BankCode.gohBetoch() {
    return BankCode('GOH_BETOCH');
  }

  /// Convenience factory for Commercial Bank of Ethiopia
  factory BankCode.cbe() {
    return BankCode('CBE');
  }

  /// Creates a bank code directly without validation
  /// Use this when the code is coming directly from a trusted API
  factory BankCode.fromApi(String code) {
    return BankCode._(right(code));
  }
}

/// Represents a wallet provider (e.g., telebir, M-PESA) from the backend API
class WalletProvider extends TransferValueObject<String> {
  @override
  final Either<TransferFailure<String>, String> value;

  const WalletProvider._(this.value);

  /// Creates a wallet provider from a string, normalizing common values
  factory WalletProvider(String input) {
    return WalletProvider._(validateWalletProvider(input));
  }

  /// Convenience factory for telebir wallet
  factory WalletProvider.telebir() {
    return WalletProvider('telebir');
  }

  /// Convenience factory for M-PESA wallet
  factory WalletProvider.mpesa() {
    return WalletProvider('M-PESA');
  }

  /// Creates a wallet provider directly without validation
  /// Use this when the provider is coming directly from a trusted API
  factory WalletProvider.fromApi(String provider) {
    return WalletProvider._(right(provider));
  }
}

/// Represents an account identifier
class AccountId extends TransferValueObject<String> {
  @override
  final Either<TransferFailure<String>, String> value;

  const AccountId._(this.value);

  /// Creates an AccountId from a string
  factory AccountId(String input) {
    return AccountId._(validateAccountId(input));
  }

  /// Creates an AccountId directly without validation
  /// Use this when the ID is coming directly from a trusted API
  factory AccountId.fromApi(String id) {
    return AccountId._(right(id));
  }

  /// Gets the raw string value
  String getValue() {
    return value.getOrElse(() => '');
  }
}

/// Represents a transfer amount
class Amount extends TransferValueObject<double> {
  @override
  final Either<TransferFailure<double>, double> value;

  const Amount._(this.value);

  /// Creates an Amount from a double
  factory Amount(double input) {
    return Amount._(validateAmount(input));
  }

  /// Creates an Amount from a string
  factory Amount.fromString(String input) {
    return Amount._(parseAndValidateAmount(input).fold(
      (failure) => left(TransferFailure.invalidAmount(failedValue: 0.0)),
      (amount) => right(amount),
    ));
  }

  /// Gets the raw double value
  double getValue() {
    return value.getOrElse(() => 0.0);
  }
}
