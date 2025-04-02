import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/auth/domain/registration/entities/registration.dart';
import 'package:super_app/features/auth/domain/registration/entities/registration_response.dart';
import 'package:super_app/features/auth/domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<NetworkExceptions, RegistrationResponse>> register(Registration registration) async {
    try {
      // This is a mock implementation for testing
      // In a real app, this would call a data source to make API requests
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
      
      final response = RegistrationResponse(
        username: registration.userName.getOrCrash(),
        full_name: registration.fullName.getOrCrash(),
        international_phone_number: registration.phoneNumber.getOrCrash(),
        password_changed_at: DateTime.now(),
        created_at: DateTime.now(),
      );
      
      return right(response);
    } catch (e) {
      return left(NetworkExceptions.defaultError(e.toString()));
    }
  }
} 