import 'package:dartz/dartz.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/auth/domain/registration/entities/registration_response.dart';
import 'package:super_app/features/auth/domain/registration/entities/registration.dart';
import 'package:super_app/features/auth/domain/verification/entities/verification_code_response.dart';

abstract class AuthRepository {
  Future<Either<NetworkExceptions, RegistrationResponse>> register(Registration registration);
  Future<Either<NetworkExceptions, VerificationCodeResponse>> sendVerificationCode(String phoneNumber);
} 