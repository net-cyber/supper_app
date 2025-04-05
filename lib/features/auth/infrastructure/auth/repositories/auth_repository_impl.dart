import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/core/utils/local_storage.dart';
import 'package:super_app/features/auth/domain/login/entities/login_response.dart';
import 'package:super_app/features/auth/domain/registration/entities/registration.dart';
import 'package:super_app/features/auth/domain/registration/entities/registration_response.dart';
import 'package:super_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:super_app/features/auth/domain/verification/entities/verification_code_response.dart';
import 'package:super_app/features/auth/domain/verification/entities/verification_confirm_response.dart';
import 'package:super_app/features/auth/infrastructure/auth/datasources/auth_remote_data_source.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {

  AuthRepositoryImpl(this._remoteDataSource);
  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<Either<NetworkExceptions, RegistrationResponse>> register(Registration registration) async {
    try {
      final response = await _remoteDataSource.register(registration);
      return right(response);
    } on DioException catch (e) {
      return left(NetworkExceptions.getDioException(e));
    } catch (e) {
      return left(NetworkExceptions.defaultError(e.toString()));
    }
  }
  
  @override
  Future<Either<NetworkExceptions, VerificationCodeResponse>> sendVerificationCode(String phoneNumber) async {
    try {
      final response = await _remoteDataSource.sendVerificationCode(phoneNumber);
      return right(response);
    } on DioException catch (e) {
      return left(NetworkExceptions.getDioException(e));
    } catch (e) {
      return left(NetworkExceptions.defaultError(e.toString()));
    }
  }

  @override
  Future<Either<NetworkExceptions, VerificationConfirmResponse>> verifyOtp(String phoneNumber, String otp) async {
    try {
      final response = await _remoteDataSource.verifyOtp(phoneNumber, otp);
      return right(response);
    } on DioException catch (e) {
      return left(NetworkExceptions.getDioException(e));
    } catch (e) {
      return left(NetworkExceptions.defaultError(e.toString()));
    }
  }

  @override
  Future<Either<NetworkExceptions, LoginResponse>> login(String username, String password) async {
    try {
      final response = await _remoteDataSource.login(username, password);
    
      
      return right(response);
    } on DioException catch (e) {
      return left(NetworkExceptions.getDioException(e));
    } catch (e) {
      return left(const NetworkExceptions.unexpectedError());
    }
  }
} 