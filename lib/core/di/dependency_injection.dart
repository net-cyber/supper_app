import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/features/transf/application/external_transfer/external_transfer_bloc.dart';
import 'package:super_app/features/transf/domain/repositories/bank_account_repository.dart';
import 'package:super_app/features/transf/domain/repositories/transfer_repository.dart';
import 'package:super_app/core/di/dependency_injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() {
  // Initialize using the auto-generated config
  getIt.init();

  // Register additional BLoCs not handled by Injectable
  _registerAdditionalDependencies();
}

// Register any additional dependencies that are not handled by the generated config
void _registerAdditionalDependencies() {
  // Make sure ExternalTransferBloc is registered
  if (!getIt.isRegistered<ExternalTransferBloc>()) {
    getIt.registerFactory(() => ExternalTransferBloc(
          bankAccountRepository: getIt<BankAccountRepository>(),
          transferRepository: getIt<TransferRepository>(),
        ));
  }
}

// Helper function to get dependencies
T inject<T extends Object>() {
  return getIt.get<T>();
}
