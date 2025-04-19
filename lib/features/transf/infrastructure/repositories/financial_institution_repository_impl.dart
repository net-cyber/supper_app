import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/financial_institution/financial_institution.dart';
import 'package:super_app/features/transf/domain/repositories/financial_institution_repository.dart';
import 'package:super_app/features/transf/infrastructure/datasources/financial_institution_remote_data_source.dart';

@Injectable(as: FinancialInstitutionRepository)
class FinancialInstitutionRepositoryImpl implements FinancialInstitutionRepository {
  final FinancialInstitutionRemoteDataSource _remoteDataSource;

  FinancialInstitutionRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<NetworkExceptions, List<FinancialInstitution>>> getFinancialInstitutions({
    required int pageId,
    required int pageSize,
  }) async {
    return _remoteDataSource.getFinancialInstitutions(
      pageId: pageId,
      pageSize: pageSize,
    );
  }
} 