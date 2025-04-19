import 'package:dartz/dartz.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/external_transfer/external_transfer.dart';
import 'package:super_app/features/transf/domain/entities/external_transfer/external_transfer_request.dart';

abstract class ExternalTransferRepository {
  Future<Either<NetworkExceptions, ExternalTransfer>> makeExternalTransfer(
    ExternalTransferRequest request,
  );
} 