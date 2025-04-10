import 'package:dartz/dartz.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/auth/domain/registration/entities/registration_response.dart';
import 'package:super_app/features/auth/domain/registration/entities/registration.dart';

abstract class AuthRepository {
  Future<Either<NetworkExceptions, RegistrationResponse>> register(Registration registration);
} 