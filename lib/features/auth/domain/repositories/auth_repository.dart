import 'package:dartz/dartz.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/auth/domain/entities/auth_user.dart';
import 'package:super_app/features/auth/domain/entities/registration.dart';

abstract class AuthRepository {
  Future<Either<NetworkExceptions, AuthUser>> register(Registration registration);
} 