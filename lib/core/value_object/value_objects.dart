import 'package:dartz/dartz.dart';
import 'package:super_app/core/validation_pipe/value_validators.dart';
import 'package:super_app/core/value_failures/value_failures.dart';
import 'package:super_app/core/value_object/abstract_value_objects.dart';

class EmailAddress extends AbstractValueObject<String> {

  factory EmailAddress(String input) {
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class Username extends AbstractValueObject<String> {
  factory Username(String input) {
    return Username._(
      validateUsername(input),
    );
  }

  const Username._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class Password extends AbstractValueObject<String> {

  factory Password(String input) {
    return Password._(
      validatePassword(input),
    );
  }

  const Password._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class ConfirmPassword extends AbstractValueObject<String> {

  factory ConfirmPassword(String input, String originalPassword) {
    return ConfirmPassword._(
      validateConfirmPassword(input, originalPassword),
    );
  }

  const ConfirmPassword._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}


class FullName extends AbstractValueObject<String> {

  factory FullName(String input) {
    return FullName._(
      validateFullName(input),
    );
  }

  const FullName._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class UserName extends AbstractValueObject<String> {
  factory UserName(String input) {
    return UserName._(
      validateUserName(input),
    );
  }

  const UserName._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class PhoneNumber extends AbstractValueObject<String> {
  factory PhoneNumber(String input) {
    return PhoneNumber._(
      validatePhoneNumber(input),
    );
  }

  const PhoneNumber._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class ReferralCode extends AbstractValueObject<String> {
  factory ReferralCode(String input) {
    return ReferralCode._(
      validateReferralCode(input),
    );
  }

  const ReferralCode._(this.value);
  @override
  final Either<ValueFailure<String>, String> value;
}

class TermsAcceptance extends AbstractValueObject<bool> {
  factory TermsAcceptance(bool input) {
    return TermsAcceptance._(
      validateTermsAcceptance(input),
    );
  }

  const TermsAcceptance._(this.value);
  @override
  final Either<ValueFailure<bool>, bool> value;
}

class ProfilePhoto extends AbstractValueObject<String?> {
  factory ProfilePhoto(String? input) {
    return ProfilePhoto._(
      validateProfilePhoto(input),
    );
  }

  const ProfilePhoto._(this.value);
  @override
  final Either<ValueFailure<String?>, String?> value;
}
