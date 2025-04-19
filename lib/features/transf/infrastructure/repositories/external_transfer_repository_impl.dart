import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/external_transfer/external_transfer.dart';
import 'package:super_app/features/transf/domain/entities/external_transfer/external_transfer_request.dart';
import 'package:super_app/features/transf/domain/repositories/external_transfer_repository.dart';
import 'package:super_app/features/transf/infrastructure/datasources/external_transfer_remote_data_source_impl.dart';

@Injectable(as: ExternalTransferRepository)
class ExternalTransferRepositoryImpl implements ExternalTransferRepository {
  ExternalTransferRepositoryImpl(this._remoteDataSource);

  final ExternalTransferRemoteDataSource _remoteDataSource;

  @override
  Future<Either<NetworkExceptions, ExternalTransfer>> makeExternalTransfer(
    ExternalTransferRequest request,
  ) async {
    log('ExternalTransferRepositoryImpl: makeExternalTransfer called with request: ${request.toJson()}');

    try {
      log('ExternalTransferRepositoryImpl: Calling remote data source');
      final transferResponse = await _remoteDataSource.makeExternalTransfer(request);

      log('ExternalTransferRepositoryImpl: Successfully got response from remote data source');
      return right(transferResponse);
    } on DioException catch (e) {
      log('ExternalTransferRepositoryImpl: DioException caught: ${e.toString()}');
      log('ExternalTransferRepositoryImpl: Status code: ${e.response?.statusCode}');
      log('ExternalTransferRepositoryImpl: Response data: ${e.response?.data}');

      if (e.response?.statusCode == 401) {
        return left(const NetworkExceptions.unauthorisedRequest());
      }
      return left(NetworkExceptions.getDioException(e));
    } catch (e) {
      log('ExternalTransferRepositoryImpl: Unexpected error: ${e.toString()}');

      if (e.toString().contains("type 'Null'") ||
          e.toString().contains("null is not a subtype of")) {
        return left(const NetworkExceptions.unexpectedError());
      }
      return left(NetworkExceptions.defaultError(e.toString()));
    }
  }
} 