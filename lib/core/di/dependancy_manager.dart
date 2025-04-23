import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/di/dependancy_manager.config.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/history/application/detail/bloc/transaction_detail_bloc.dart';
import 'package:super_app/features/history/application/list/bloc/transaction_history_bloc.dart';
import 'package:super_app/features/history/application/summary/bloc/transaction_summary_bloc.dart';
import 'package:super_app/features/history/di/history_module.dart';
import 'package:super_app/features/history/domain/repositories/transaction_repository.dart';
import 'package:super_app/features/history/infrastructure/datasources/transactions_remote_data_source.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() {
  getIt.init();
  _registerManualDependencies();
}

// Register dependencies that couldn't be handled by build_runner
void _registerManualDependencies() {
  // Register history module dependencies
  final historyModule = HistoryModule();
  
  // Register datasources
  getIt.registerFactory<TransactionsRemoteDataSource>(
    () => historyModule.provideTransactionsRemoteDataSource(),
  );
  
  // Register repositories
  getIt.registerFactory<TransactionRepository>(
    () => historyModule.provideTransactionRepository(
      getIt<TransactionsRemoteDataSource>(),
    ),
  );
  
  // Register blocs
  getIt.registerFactory<TransactionHistoryBloc>(
    () => historyModule.provideTransactionHistoryBloc(
      getIt<TransactionRepository>(),
      getIt<AccountsBloc>(),
    ),
  );
  
  getIt.registerFactory<TransactionDetailBloc>(
    () => historyModule.provideTransactionDetailBloc(
      getIt<TransactionRepository>(),
      getIt<AccountsBloc>(),
    ),
  );
  
  getIt.registerFactory<TransactionSummaryBloc>(
    () => historyModule.provideTransactionSummaryBloc(
      getIt<TransactionRepository>(),
      getIt<AccountsBloc>(),
    ),
  );
}
