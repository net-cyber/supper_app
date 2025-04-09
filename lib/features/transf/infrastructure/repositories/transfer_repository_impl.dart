import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/transfer_response.dart';
import 'package:super_app/features/transf/domain/repositories/transfer_repository.dart';
import 'package:super_app/features/transf/infrastructure/datasources/transfer_remote_data_source_impl.dart';

@Injectable(as: TransferRepository)
class TransferRepositoryImpl implements TransferRepository {
  TransferRepositoryImpl(this._remoteDataSource);

  final TransferRemoteDataSource _remoteDataSource;

  @override
  Future<Either<NetworkExceptions, TransferResponse>> createTransfer({
    required int fromAccountId,
    required int toAccountId,
    required double amount,
    required String currency,
  }) async {
    log('TransferRepositoryImpl: createTransfer called with fromAccountId=$fromAccountId, toAccountId=$toAccountId, amount=$amount, currency=$currency');

    try {
      log('TransferRepositoryImpl: Calling remote data source');
      final transferResponse = await _remoteDataSource.createTransfer(
        fromAccountId: fromAccountId,
        toAccountId: toAccountId,
        amount: amount,
        currency: currency,
      );

      log('TransferRepositoryImpl: Successfully got response from remote data source');
      return right(transferResponse);
    } on DioException catch (e) {
      log('TransferRepositoryImpl: DioException caught: ${e.toString()}');
      log('TransferRepositoryImpl: Status code: ${e.response?.statusCode}');
      log('TransferRepositoryImpl: Response data: ${e.response?.data}');

      if (e.response?.statusCode == 401) {
        return left(const NetworkExceptions.unauthorisedRequest());
      }
      return left(NetworkExceptions.getDioException(e));
    } catch (e) {
      log('TransferRepositoryImpl: Unexpected error: ${e.toString()}');

      if (e.toString().contains("type 'Null'") ||
          e.toString().contains("null is not a subtype of")) {
        return left(const NetworkExceptions.unexpectedError());
      }
      return left(NetworkExceptions.defaultError(e.toString()));
    }
  }
}
