import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/auth/domain/registration/entities/registration.dart';
import 'package:super_app/features/auth/domain/registration/entities/registration_response.dart';
import 'package:super_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:super_app/features/auth/infrastructure/auth/datasources/auth_remote_data_source.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

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
} 