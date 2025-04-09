import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/account_verification.dart';
import 'package:super_app/features/transf/domain/repositories/transfer_account_repository.dart';
import 'package:super_app/features/transf/infrastructure/datasources/transfer_account_remote_data_source_impl.dart';

@Injectable(as: TransferAccountRepository)
class TransferAccountRepositoryImpl implements TransferAccountRepository {
  TransferAccountRepositoryImpl(this._remoteDataSource);

  final TransferAccountRemoteDataSource _remoteDataSource;

  @override
  Future<Either<NetworkExceptions, AccountVerification>> verifyAccount(
      int accountId) async {
    try {
      final verification = await _remoteDataSource.verifyAccount(accountId);
      return right(verification);
    } on DioException catch (e) {
      // Check specifically for auth-related errors
      if (e.response?.statusCode == 401) {
        return left(const NetworkExceptions.unauthorisedRequest());
      }

      return left(NetworkExceptions.getDioException(e));
    } catch (e) {
      // Special handling for null errors that might come from type casting
      if (e.toString().contains("type 'Null'") ||
          e.toString().contains("null is not a subtype of")) {
        return left(const NetworkExceptions.unexpectedError());
      }

      return left(NetworkExceptions.defaultError(e.toString()));
    }
  }
}
