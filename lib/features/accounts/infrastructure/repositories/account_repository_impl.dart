import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/accounts/domain/entities/account.dart';
import 'package:super_app/features/accounts/domain/repositories/account_repository.dart';
import 'package:super_app/features/accounts/infrastructure/datasources/accounts_remote_data_source.dart';

@Injectable(as: AccountRespository)
class AccountRepositoryImpl implements AccountRespository {
  AccountRepositoryImpl(this._remoteDataSource);

  final AccountsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<NetworkExceptions, List<Account>>> getAccounts({
    required int pageId,
    required int pageSize,
  }) async {
    try {
      final accounts = await _remoteDataSource.getAccounts(
        pageId: pageId,
        pageSize: pageSize,
      );
      return right(accounts);
    } on DioException catch (e) {
      return left(NetworkExceptions.getDioException(e));
    }
  }
}
