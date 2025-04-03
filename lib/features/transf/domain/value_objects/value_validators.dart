import 'package:dartz/dartz.dart';
import 'package:super_app/features/transf/domain/value_objects/failures.dart';

// Account number validation
Either<TransferFailure<String>, String> validateAccountNumber(String input) {
  // Remove any spaces
  final sanitized = input.replaceAll(' ', '');

  // Check for empty input
  if (sanitized.isEmpty) {
    return left(TransferFailure.invalidAccountNumber(
      failedValue: input,
    ));
  }

  // Check if it's a valid account number format (typically 10-16 digits)
  // This regex allows for different account number formats
  final regex = RegExp(r'^\d{10,16}$');
  if (!regex.hasMatch(sanitized)) {
    return left(TransferFailure.invalidAccountNumber(
      failedValue: input,
    ));
  }

  return right(sanitized);
}

// Ethiopian phone number validation
Either<TransferFailure<String>, String> validateEthiopianPhoneNumber(
    String input) {
  // Remove any spaces, dashes, and parentheses
  final sanitized = input.replaceAll(RegExp(r'[\s\-()]'), '');

  // Check for empty input
  if (sanitized.isEmpty) {
    return left(TransferFailure.invalidPhoneNumber(
      failedValue: input,
    ));
  }

  // Check if it's in the format: +251 9XXXXXXXX or 09XXXXXXXX
  bool isValid = false;

  // Accept formats like +2519XXXXXXXX or +251 9XXXXXXXX
  if (sanitized.startsWith('+251') && sanitized.length == 13) {
    final regex = RegExp(r'^\+251[79]\d{8}$');
    isValid = regex.hasMatch(sanitized);
  }
  // Accept formats like 09XXXXXXXX
  else if (sanitized.startsWith('0') && sanitized.length == 10) {
    final regex = RegExp(r'^0[79]\d{8}$');
    isValid = regex.hasMatch(sanitized);
  }

  if (!isValid) {
    return left(TransferFailure.invalidPhoneNumber(
      failedValue: input,
    ));
  }

  // Standardize format to +251 format
  String standardized = sanitized;
  if (sanitized.startsWith('0')) {
    standardized = '+251${sanitized.substring(1)}';
  }

  return right(standardized);
}

// Money amount validation
Either<TransferFailure<double>, double> validateAmount(double amount,
    {double? minimum, double? maximum}) {
  // Check for negative amount
  if (amount <= 0) {
    return left(TransferFailure.invalidAmount(failedValue: amount));
  }

  // Check for minimum amount if specified
  if (minimum != null && amount < minimum) {
    return left(TransferFailure.belowMinimumAmount(
      failedValue: amount,
      minimum: minimum,
    ));
  }

  // Check for maximum amount if specified
  if (maximum != null && amount > maximum) {
    return left(TransferFailure.exceedsTransferLimit(
      failedValue: amount,
      limit: maximum,
    ));
  }

  return right(amount);
}

// Parse and validate amount from string
Either<TransferFailure<String>, double> parseAndValidateAmount(String input,
    {double? minimum, double? maximum}) {
  // Try to parse the input as a double
  double? amount;
  try {
    // Remove any currency symbols or commas
    final sanitized = input.replaceAll(RegExp(r'[^\d.]'), '');
    amount = double.parse(sanitized);
  } catch (_) {
    return left(TransferFailure.invalidAmount(failedValue: input));
  }

  // Validate the parsed amount
  return validateAmount(amount, minimum: minimum, maximum: maximum)
      .leftMap((failure) => TransferFailure.invalidAmount(failedValue: input));
}

// Transfer reason validation
Either<TransferFailure<String>, String> validateTransferReason(String input) {
  // Reason is optional, so empty is valid
  if (input.isEmpty) {
    return right('');
  }

  // Check if it's not too long (maximum 100 characters)
  if (input.length > 100) {
    return left(TransferFailure.invalidInput(
      failedValue: input,
      message: 'Reason cannot exceed 100 characters',
    ));
  }

  return right(input);
}

// Bank code validation
Either<TransferFailure<String>, String> validateBankCode(String input) {
  // Remove any spaces
  final sanitized = input.trim();

  // Check for empty input
  if (sanitized.isEmpty) {
    return left(TransferFailure.invalidInput(
      failedValue: input,
      message: 'Bank code cannot be empty',
    ));
  }

  // Since bank codes come from the backend API, we'll be more lenient
  // and just do basic normalization and sanitization

  // Normalize to uppercase for consistency
  final normalized = sanitized.toUpperCase();

  return right(normalized);
}

// Wallet provider validation
Either<TransferFailure<String>, String> validateWalletProvider(String input) {
  // Since wallet providers come from the backend API, we'll focus on normalization
  // rather than strict validation

  // Check for empty input
  if (input.isEmpty) {
    return left(TransferFailure.invalidInput(
      failedValue: input,
      message: 'Wallet provider cannot be empty',
    ));
  }

  // Normalize known wallet providers for consistency
  final sanitized = input.trim();

  String normalized = sanitized;
  if (sanitized.toLowerCase() == 'mpesa') {
    normalized = 'M-PESA';
  } else if (sanitized.toLowerCase() == 'telebir') {
    normalized = 'telebir';
  }

  return right(normalized);
}
