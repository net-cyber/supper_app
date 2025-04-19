import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/account_validation/account_validation.dart';
import 'package:super_app/features/transf/domain/repositories/account_validation_repository.dart';
import 'package:super_app/features/transf/infrastructure/datasources/account_validation_remote_data_source_impl.dart';

@Injectable(as: AccountValidationRepository)
class AccountValidationRepositoryImpl implements AccountValidationRepository {
  final AccountValidationRemoteDataSource _remoteDataSource;

  AccountValidationRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<NetworkExceptions, AccountValidation>> validateAccount(
      double amount, int currentAccountId) async {
    return await _remoteDataSource.validateAccount(
      amount,
      currentAccountId,
    );
  }
}
