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

/// Register dependencies manually until build_runner is fixed
void registerManualDependencies() {
  // Data sources
  if (!getIt.isRegistered<TransferAccountRemoteDataSource>()) {
    getIt.registerFactory<TransferAccountRemoteDataSource>(
        () => TransferAccountRemoteDataSource());
  }

  if (!getIt.isRegistered<AccountValidationRemoteDataSource>()) {
    getIt.registerFactory<AccountValidationRemoteDataSource>(
        () => AccountValidationRemoteDataSource());
  }

  // Repositories
  if (!getIt.isRegistered<TransferAccountRepository>()) {
    getIt.registerFactory<TransferAccountRepository>(() =>
        TransferAccountRepositoryImpl(
            getIt<TransferAccountRemoteDataSource>()));
  }

  if (!getIt.isRegistered<AccountValidationRepository>()) {
    getIt.registerFactory<AccountValidationRepository>(() =>
        AccountValidationRepositoryImpl(
            getIt<AccountValidationRemoteDataSource>()));
  }

  // Blocs
  if (!getIt.isRegistered<AccountVerificationBloc>()) {
    getIt.registerFactory<AccountVerificationBloc>(
        () => AccountVerificationBloc(getIt<TransferAccountRepository>()));
  }

  if (!getIt.isRegistered<AccountValidationBloc>()) {
    getIt.registerFactory<AccountValidationBloc>(() => AccountValidationBloc(
          getIt<AccountValidationRepository>(),
          getIt<AccountsBloc>(),
        ));
  }
}
