import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:super_app/core/value_object/value_objects.dart';

part 'registration.freezed.dart';

@freezed
class Registration with _$Registration {
  const factory Registration({
    required UserName userName,
    required FullName fullName,
    required PhoneNumber phoneNumber,
    required Password password,
    required ConfirmPassword confirmPassword,
    required TermsAcceptance termsAcceptance,
    required ProfilePhoto profilePhoto,
  }) = _Registration;

  const Registration._();

  factory Registration.empty() => Registration(
        userName: UserName(''),
        fullName: FullName(''),
        phoneNumber: PhoneNumber(''),
        password: Password(''),
        confirmPassword: ConfirmPassword('', ''),
        termsAcceptance: TermsAcceptance(false),
        profilePhoto: ProfilePhoto(null),
      );

  bool isValid() {
    return userName.isValid() &&
        fullName.isValid() &&
        phoneNumber.isValid() &&
        password.isValid() &&
        confirmPassword.isValid() &&
        termsAcceptance.isValid() &&
        (profilePhoto.value.getOrElse(() => null) == null || profilePhoto.isValid());
  }
} 