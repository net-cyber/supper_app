import 'package:dartz/dartz.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/financial_institution/financial_institution.dart';

abstract class FinancialInstitutionRemoteDataSource {
  Future<Either<NetworkExceptions, List<FinancialInstitution>>> getFinancialInstitutions({
    required int pageId,
    required int pageSize,
  });
} 