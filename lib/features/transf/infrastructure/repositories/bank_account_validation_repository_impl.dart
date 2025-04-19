import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/bank_account_validation/bank_account_validation.dart';
import 'package:super_app/features/transf/domain/repositories/bank_account_validation_repository.dart';
import 'package:super_app/features/transf/infrastructure/datasources/bank_account_validation_remote_data_source_impl.dart';

@Injectable(as: BankAccountValidationRepository)
class BankAccountValidationRepositoryImpl implements BankAccountValidationRepository {
  final BankAccountValidationRemoteDataSource _remoteDataSource;

  BankAccountValidationRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<NetworkExceptions, BankAccountValidation>> validateBankAccount({
    required String bankCode, 
    required String accountNumber,
  }) async {
    return await _remoteDataSource.validateBankAccount(
      bankCode: bankCode,
      accountNumber: accountNumber,
    );
  }
} 