import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/account_validation.dart';
import 'package:super_app/features/transf/domain/repositories/account_validation_repository.dart';
import 'package:super_app/features/transf/infrastructure/datasources/account_validation_remote_data_source_impl.dart';

@Injectable(as: AccountValidationRepository)
class AccountValidationRepositoryImpl implements AccountValidationRepository {
  AccountValidationRepositoryImpl(this._remoteDataSource);

  final AccountValidationRemoteDataSource _remoteDataSource;

  @override
  Future<Either<NetworkExceptions, AccountValidation>> validateAccount(
      double amount, int currentAccountId) async {
    try {
      final validation = await _remoteDataSource.validateAccount(
        amount,
        currentAccountId,
      );
      return right(validation);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return left(const NetworkExceptions.unauthorisedRequest());
      }
      return left(NetworkExceptions.getDioException(e));
    } catch (e) {
      if (e.toString().contains("type 'Null'") ||
          e.toString().contains("null is not a subtype of")) {
        return left(const NetworkExceptions.unexpectedError());
      }
      return left(NetworkExceptions.defaultError(e.toString()));
    }
  }
}
