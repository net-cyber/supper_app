import 'package:dartz/dartz.dart';
import 'package:super_app/core/validation_pipe/value_validators.dart';
import 'package:super_app/core/value_failures/value_failures.dart';
import 'package:super_app/core/value_object/value_objects.dart';

class PhoneNumber extends ValueObject<String> {

  factory PhoneNumber(String input) {
    return PhoneNumber._(
      validatePhoneNumber(input),
    );
  }

  const PhoneNumber._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class Amount extends ValueObject<String> {

  factory Amount(String input) {
    if (input.isEmpty) {
      return Amount._(left(const ValueFailure.invalidAmount(
        failedValue: 'Amount is required',
      )));
    }
    
    try {
      final amount = double.parse(input);
      if (amount <= 0) {
        return Amount._(left(const ValueFailure.invalidAmount(
          failedValue: 'Amount must be greater than 0',
        )));
      }
      return Amount._(right(input));
    } catch (e) {
      return Amount._(left(const ValueFailure.invalidAmount(
        failedValue: 'Invalid amount format',
      )));
    }
  }

  const Amount._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class AccountNumber extends ValueObject<String> {

  factory AccountNumber(String input) {
    return AccountNumber._(
      validateAccountNumber(input),
    );
  }

  const AccountNumber._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}


