import 'package:dartz/dartz.dart';
import 'package:super_app/core/value_failures/value_failures.dart';

Either<ValueFailure<String>, String> validateMaxStringLength(
  String input,
  int maxLength,
) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(
      ValueFailure.exceedingLength(
        failedValue: input,
        max: maxLength,
      ),
    );
  }
}

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if (input.isEmpty) {
    return left(ValueFailure.empty(failedValue: input));
  } else {
    return right(input);
  }
}

Either<ValueFailure<String>, String> validateSingleLine(String input) {
  if (input.contains('\n')) {
    return left(ValueFailure.multiline(failedValue: input));
  } else {
    return right(input);
  }
}

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

  // Trim the input to handle whitespace
  final trimmedInput = input.trim();

  // Check for empty or whitespace-only input
  if (trimmedInput.isEmpty) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Please enter your email address',
      ),
    );
  }

  // Check for length constraints
  if (trimmedInput.length > 254) {
    // Maximum length per RFC 5321
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Email address is too long (maximum 254 characters)',
      ),
    );
  }

  // Check for basic structure
  if (!trimmedInput.contains('@')) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Email address must contain "@" symbol',
      ),
    );
  }

  // Split email into local and domain parts
  final parts = trimmedInput.split('@');
  if (parts.length > 2) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Email address cannot contain multiple "@" symbols',
      ),
    );
  }

  final localPart = parts[0];
  final domainPart = parts[1];

  // Validate local part
  if (localPart.isEmpty) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Username part before "@" cannot be empty',
      ),
    );
  }

  if (localPart.length > 64) {
    // Maximum length per RFC 5321
    return left(
      const ValueFailure.invalidEmail(
        failedValue:
            'Username part before "@" is too long (maximum 64 characters)',
      ),
    );
  }

  // Check for invalid starting/ending characters in local part
  if (localPart.startsWith('.') || localPart.endsWith('.')) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Username part cannot start or end with a dot',
      ),
    );
  }

  // Validate domain part
  if (domainPart.isEmpty) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Domain part after "@" cannot be empty',
      ),
    );
  }

  if (!domainPart.contains('.')) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Domain must contain a dot (e.g., .com, .net)',
      ),
    );
  }

  if (domainPart.startsWith('.') || domainPart.endsWith('.')) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Domain cannot start or end with a dot',
      ),
    );
  }

  if (domainPart.startsWith('-') || domainPart.endsWith('-')) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Domain cannot start or end with a hyphen',
      ),
    );
  }

  // Check for consecutive dots
  if (trimmedInput.contains('..')) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Email address cannot contain consecutive dots',
      ),
    );
  }

  // Check for invalid characters
  if (trimmedInput.contains(' ')) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Email address cannot contain spaces',
      ),
    );
  }

  // Final regex check for overall format
  if (RegExp(emailRegex).hasMatch(trimmedInput)) {
    return right(trimmedInput);
  }

  // If all specific checks pass but regex fails, provide a general message
  return left(
    const ValueFailure.invalidEmail(
      failedValue: 'Please enter a valid email address',
    ),
  );
}

Either<ValueFailure<String>, String> validateUsername(String input) {
  if (input.isEmpty) {
    return left(ValueFailure.empty(failedValue: input));
  } else {
    return right(input);
  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  // Check for empty password
  if (input.isEmpty) {
    return left(
      const ValueFailure.shortPassword(
        failedValue: 'Please enter a password',
      ),
    );
  }

  // Check minimum length
  if (input.length < 8) {
    return left(
      const ValueFailure.shortPassword(
        failedValue: 'Password must be at least 8 characters long',
      ),
    );
  }

  // Check maximum length
  if (input.length > 50) {
    return left(
      const ValueFailure.shortPassword(
        failedValue: 'Password is too long (maximum 50 characters)',
      ),
    );
  }

  // Check for uppercase letters
  if (!RegExp('[A-Z]').hasMatch(input)) {
    return left(
      const ValueFailure.shortPassword(
        failedValue: 'Password must contain at least one uppercase letter',
      ),
    );
  }

  // Check for lowercase letters
  if (!RegExp('[a-z]').hasMatch(input)) {
    return left(
      const ValueFailure.shortPassword(
        failedValue: 'Password must contain at least one lowercase letter',
      ),
    );
  }

  // Check for numbers
  if (!RegExp('[0-9]').hasMatch(input)) {
    return left(
      const ValueFailure.shortPassword(
        failedValue: 'Password must contain at least one number',
      ),
    );
  }

  // Check for special characters
  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(input)) {
    return left(
      const ValueFailure.shortPassword(
        failedValue:
            r'Password must contain at least one special character (!@#$%^&*(),.?":\{\}|<>)',
      ),
    );
  }

  // Check for whitespace
  if (input.contains(' ')) {
    return left(
      const ValueFailure.shortPassword(
        failedValue: 'Password cannot contain spaces',
      ),
    );
  }

  // If all validations pass
  return right(input);
}

Either<ValueFailure<String>, String> validateConfirmPassword(
  String input,
  String originalPassword,
) {
  // Check if confirm password is empty
  if (input.isEmpty) {
    return left(
      const ValueFailure.passwordMismatch(
        failedValue: 'Please confirm your password',
      ),
    );
  }

  // Check if passwords match
  if (input != originalPassword) {
    return left(
      const ValueFailure.passwordMismatch(
        failedValue: 'Passwords do not match',
      ),
    );
  }

  // If validation passes
  return right(input);
}

Either<ValueFailure<String>, String> validateFullName(String input) {
  // Trim the input to handle whitespace
  final trimmedInput = input.trim();

  // Check for empty or whitespace-only input
  if (trimmedInput.isEmpty) {
    return left(
      const ValueFailure.empty(
        failedValue: 'Please enter your full name',
      ),
    );
  }

  // Check minimum length (at least 2 characters)
  if (trimmedInput.length < 2) {
    return left(
      const ValueFailure.invalidName(
        failedValue: 'Name is too short (minimum 2 characters)',
      ),
    );
  }

  // Check maximum length
  if (trimmedInput.length > 50) {
    return left(
      const ValueFailure.invalidName(
        failedValue: 'Name is too long (maximum 50 characters)',
      ),
    );
  }

  // Check for numbers
  if (RegExp('[0-9]').hasMatch(trimmedInput)) {
    return left(
      const ValueFailure.invalidName(
        failedValue: 'Name cannot contain numbers',
      ),
    );
  }

  // Check for special characters (allowing only hyphen and apostrophe)
  if (RegExp(r'[!@#$%^&*()_+=\[\]{};:"\\|,.<>/?]').hasMatch(trimmedInput)) {
    return left(
      const ValueFailure.invalidName(
        failedValue: 'Name contains invalid special characters',
      ),
    );
  }

  // Check for multiple consecutive spaces
  if (RegExp(r'\s{2,}').hasMatch(trimmedInput)) {
    return left(
      const ValueFailure.invalidName(
        failedValue: 'Name cannot contain consecutive spaces',
      ),
    );
  }

  // Check for at least two parts in the name (first and last name)
  final nameParts = trimmedInput.split(' ');
  if (nameParts.length < 2) {
    return left(
      const ValueFailure.invalidName(
        failedValue: 'Please enter both first and last name',
      ),
    );
  }

  // Check each name part for minimum length
  for (final part in nameParts) {
    if (part.length < 2) {
      return left(
        const ValueFailure.invalidName(
          failedValue: 'Each part of the name must be at least 2 characters',
        ),
      );
    }
  }

  // If all validations pass, return the trimmed input
  return right(trimmedInput);
}

Either<ValueFailure<String>, String> validatePhoneNumber(String input) {
  // Trim the input to handle whitespace
  final trimmedInput = input.trim();

  // Check for empty or whitespace-only input
  if (trimmedInput.isEmpty) {
    return left(
      const ValueFailure.empty(
        failedValue: 'Please enter a phone number',
      ),
    );
  }

  // Simple validation for now - check for length and numeric characters
  if (trimmedInput.length < 7) {
    return left(
      const ValueFailure.invalidPhoneNumber(
        failedValue: 'Phone number is too short',
      ),
    );
  }

  if (trimmedInput.length > 15) {
    return left(
      const ValueFailure.invalidPhoneNumber(
        failedValue: 'Phone number is too long',
      ),
    );
  }

  // Check if it contains only digits, plus sign, and parentheses
  if (!RegExp(r'^[0-9\+\(\)\-\s]+$').hasMatch(trimmedInput)) {
    return left(
      const ValueFailure.invalidPhoneNumber(
        failedValue: 'Phone number contains invalid characters',
      ),
    );
  }

  return right(trimmedInput);
}

Either<ValueFailure<String>, String> validateAmount(String input) {
  // Check for negative or zero amount
  if (double.parse(input) <= 0) {
    return left(
      const ValueFailure.invalidAmount(
        failedValue: 'Amount must be greater than 0',
      ),
    );
  }

  // Check for maximum transaction limit (e.g., 100,000 ETB)
  const maxAmount = 100000.0;
  if (double.parse(input) > maxAmount) {
    return left(
      ValueFailure.invalidAmount(
        failedValue: 'Amount cannot exceed ${maxAmount.toStringAsFixed(2)} ETB',
      ),
    );
  }

  // Check for minimum transaction amount (e.g., 1 ETB)
  const minAmount = 1.0;
  if (double.parse(input) < minAmount) {
    return left(
      ValueFailure.invalidAmount(
        failedValue:
            'Amount must be at least ${minAmount.toStringAsFixed(2)} ETB',
      ),
    );
  }

  // Check for decimal places (maximum 2 decimal places allowed)
  final decimalPlaces =
      input.split('.').length > 1 ? input.split('.')[1].length : 0;
  if (decimalPlaces > 2) {
    return left(
      const ValueFailure.invalidAmount(
        failedValue: 'Amount cannot have more than 2 decimal places',
      ),
    );
  }

  // Check for reasonable amount increments (minimum 0.01 ETB)
  const minIncrement = 0.01;
  if ((double.parse(input) * 100) % 1 != 0) {
    return left(
      ValueFailure.invalidAmount(
        failedValue:
            'Amount must be in increments of ${minIncrement.toStringAsFixed(2)} ETB',
      ),
    );
  }

  // Check for NaN or infinite values
  if (double.parse(input).isNaN || double.parse(input).isInfinite) {
    return left(
      const ValueFailure.invalidAmount(
        failedValue: 'Invalid amount value',
      ),
    );
  }

  // If all validations pass, return the amount rounded to 2 decimal places
  return right(input);
}

Either<ValueFailure<String>, String> validateAccountNumber(String input) {
  // Trim the input to handle whitespace
  final trimmedInput = input.trim();

  // Check for empty or whitespace-only input
  if (trimmedInput.isEmpty) {
    return left(
      const ValueFailure.empty(
        failedValue: 'Please enter an account number',
      ),
    );
  }

  // Remove any spaces or special characters
  final cleanNumber = trimmedInput.replaceAll(RegExp(r'[\s-]'), '');

  // Check for non-digit characters
  if (RegExp(r'[^\d]').hasMatch(cleanNumber)) {
    return left(
      const ValueFailure.shortAccountNumber(
        failedValue: 'Account number can only contain digits',
      ),
    );
  }

  // Check minimum length (usually 10-12 digits for Ethiopian banks)
  if (cleanNumber.length < 5) {
    return left(
      const ValueFailure.shortAccountNumber(
        failedValue: 'Account number is too short (minimum 5 digits)',
      ),
    );
  }

  // Check maximum length
  if (cleanNumber.length > 16) {
    return left(
      const ValueFailure.shortAccountNumber(
        failedValue: 'Account number is too long (maximum 16 digits)',
      ),
    );
  }

  // Check for repeated digits (potential invalid numbers)
  if (RegExp(r'(\d)\1{7,}').hasMatch(cleanNumber)) {
    return left(
      const ValueFailure.shortAccountNumber(
        failedValue: 'Invalid account number pattern',
      ),
    );
  }

  // Check for sequential numbers (e.g., 1234567890)
  if (RegExp('1234567890|0987654321').hasMatch(cleanNumber)) {
    return left(
      const ValueFailure.shortAccountNumber(
        failedValue: 'Invalid account number sequence',
      ),
    );
  }

  // Check for all zeros
  if (RegExp(r'^0+$').hasMatch(cleanNumber)) {
    return left(
      const ValueFailure.shortAccountNumber(
        failedValue: 'Invalid account number',
      ),
    );
  }

  // Check for valid starting digits (can be customized per bank)
  // Example: if (cleanNumber.startsWith('00')) {
  //   return left(ValueFailure.shortAccountNumber(
  //     failedValue: 'Invalid account number prefix'));
  // }

  // If all validations pass, return the cleaned number
  return right(cleanNumber);
}

Either<ValueFailure<String>, String> validateUserName(String input) {
  // Trim the input to handle whitespace
  final trimmedInput = input.trim();

  // Check for empty or whitespace-only input
  if (trimmedInput.isEmpty) {
    return left(
      const ValueFailure.empty(
        failedValue: 'Please enter a username',
      ),
    );
  }

  // Check minimum length
  if (trimmedInput.length < 3) {
    return left(
      const ValueFailure.invalidName(
        failedValue: 'Username is too short (minimum 3 characters)',
      ),
    );
  }

  // Check maximum length
  if (trimmedInput.length > 20) {
    return left(
      const ValueFailure.invalidName(
        failedValue: 'Username is too long (maximum 20 characters)',
      ),
    );
  }

  // Check for valid characters (alphanumeric and underscores only)
  if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(trimmedInput)) {
    return left(
      const ValueFailure.invalidName(
        failedValue:
            'Username can only contain letters, numbers, and underscores',
      ),
    );
  }

  return right(trimmedInput);
}

Either<ValueFailure<String>, String> validateReferralCode(String input) {
  // Referral code is optional, so empty is valid
  if (input.isEmpty) {
    return right('');
  }

  final trimmedInput = input.trim();

  // Check format - alphanumeric and typically 6-10 characters
  if (!RegExp(r'^[a-zA-Z0-9]{6,10}$').hasMatch(trimmedInput)) {
    return left(
      const ValueFailure.invalidEmail(
        failedValue: 'Invalid referral code format',
      ),
    );
  }

  return right(trimmedInput);
}

Either<ValueFailure<bool>, bool> validateTermsAcceptance(bool input) {
  if (!input) {
    return left(
      const ValueFailure.empty(
        failedValue: false,
      ),
    );
  }

  return right(input);
}

// New validator for profile photo
Either<ValueFailure<String?>, String?> validateProfilePhoto(String? input) {
  // Profile photo is optional during registration, so null is acceptable
  if (input == null) {
    return right(null);
  }
  
  // Check if the file path is empty
  if (input.isEmpty) {
    return right(null);
  }
  
  // Check file extension
  final validExtensions = ['.jpg', '.jpeg', '.png'];
  final fileExtension = input.toLowerCase().substring(input.lastIndexOf('.'));
  if (!validExtensions.contains(fileExtension)) {
    return left(ValueFailure.invalidPhotoUrl(
      failedValue: 'Only JPG, JPEG, and PNG files are allowed',),);
  }
  
  // Check file size (this would typically be done when actually reading the file)
  // But here we'll just return the valid path
  
  return right(input);
}
