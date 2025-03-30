import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:super_app/features/auth/domain/value_objects.dart';

part 'registration.freezed.dart';

@freezed
class Registration with _$Registration {
  const factory Registration({
    required UserName userName,
    required FullName fullName,
    required PhoneNumber phoneNumber,
    required EmailAddress emailAddress,
    required Password password,
    required ConfirmPassword confirmPassword,
    ReferralCode? referralCode,
    required TermsAcceptance termsAcceptance,
  }) = _Registration;

  const Registration._();

  factory Registration.empty() => Registration(
        userName: UserName(''),
        fullName: FullName(''),
        phoneNumber: PhoneNumber(''),
        emailAddress: EmailAddress(''),
        password: Password(''),
        confirmPassword: ConfirmPassword('', ''),
        referralCode: ReferralCode(''),
        termsAcceptance: TermsAcceptance(false),
      );

  bool isValid() {
    return userName.isValid() &&
        fullName.isValid() &&
        phoneNumber.isValid() &&
        emailAddress.isValid() &&
        password.isValid() &&
        confirmPassword.isValid() &&
        termsAcceptance.isValid();
  }
} 