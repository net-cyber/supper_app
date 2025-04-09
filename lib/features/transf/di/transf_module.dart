import 'package:injectable/injectable.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/transf/application/validation/bloc/account_validation_bloc.dart';
import 'package:super_app/features/transf/application/verification/bloc/account_verification_bloc.dart';
import 'package:super_app/features/transf/domain/repositories/account_validation_repository.dart';
import 'package:super_app/features/transf/domain/repositories/transfer_account_repository.dart';
import 'package:super_app/features/transf/infrastructure/datasources/account_validation_remote_data_source_impl.dart';
import 'package:super_app/features/transf/infrastructure/datasources/transfer_account_remote_data_source_impl.dart';
import 'package:super_app/features/transf/infrastructure/repositories/account_validation_repository_impl.dart';
import 'package:super_app/features/transf/infrastructure/repositories/transfer_account_repository_impl.dart';

@module
abstract class TransfModule {
  // Register data sources
  @injectable
  TransferAccountRemoteDataSource get transferAccountRemoteDataSource =>
      TransferAccountRemoteDataSource();

  @injectable
  AccountValidationRemoteDataSource get accountValidationRemoteDataSource =>
      AccountValidationRemoteDataSource();

  // Register repository implementations
  @Injectable(as: TransferAccountRepository)
  TransferAccountRepository get transferAccountRepository =>
      TransferAccountRepositoryImpl(transferAccountRemoteDataSource);

  @Injectable(as: AccountValidationRepository)
  AccountValidationRepository get accountValidationRepository =>
      AccountValidationRepositoryImpl(accountValidationRemoteDataSource);

  // Register blocs
  @injectable
  AccountVerificationBloc get accountVerificationBloc =>
      AccountVerificationBloc(transferAccountRepository);

  @injectable
  AccountValidationBloc get accountValidationBloc => AccountValidationBloc(
        accountValidationRepository,
        getIt<AccountsBloc>(),
      );
}
