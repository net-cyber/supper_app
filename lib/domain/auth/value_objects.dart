import 'package:dartz/dartz.dart';
import 'package:super_app/core/validation_pipe/value_validators.dart';
import 'package:super_app/core/value_failures/value_failures.dart';
import 'package:super_app/core/value_object/value_objects.dart';

class EmailAddress extends ValueObject<String> {

  factory EmailAddress(String input) {
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class Password extends ValueObject<String> {

  factory Password(String input) {
    return Password._(
      validatePassword(input),
    );
  }

  const Password._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class ConfirmPassword extends ValueObject<String> {

  factory ConfirmPassword(String input, String originalPassword) {
    return ConfirmPassword._(
      validateConfirmPassword(input, originalPassword),
    );
  }

  const ConfirmPassword._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}


class FullName extends ValueObject<String> {

  factory FullName(String input) {
    return FullName._(
      validateFullName(input),
    );
  }

  const FullName._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}
