import 'package:injectable/injectable.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/history/application/detail/bloc/transaction_detail_bloc.dart';
import 'package:super_app/features/history/application/list/bloc/transaction_history_bloc.dart';
import 'package:super_app/features/history/application/summary/bloc/transaction_summary_bloc.dart';
import 'package:super_app/features/history/domain/repositories/transaction_repository.dart';
import 'package:super_app/features/history/infrastructure/datasources/transactions_remote_data_source.dart';
import 'package:super_app/features/history/infrastructure/repositories/transaction_repository_impl.dart';

@module
class HistoryModule {
  // Register datasources
  TransactionsRemoteDataSource provideTransactionsRemoteDataSource() => 
      TransactionsRemoteDataSourceImpl();

  // Register repositories
  TransactionRepository provideTransactionRepository(
    TransactionsRemoteDataSource dataSource,
  ) => 
      TransactionRepositoryImpl(dataSource);

  // Register blocs
  TransactionHistoryBloc provideTransactionHistoryBloc(
    TransactionRepository repository,
    AccountsBloc accountsBloc,
  ) => 
      TransactionHistoryBloc(repository, accountsBloc);

  TransactionDetailBloc provideTransactionDetailBloc(
    TransactionRepository repository,
    AccountsBloc accountsBloc,
  ) => 
      TransactionDetailBloc(repository, accountsBloc);

  TransactionSummaryBloc provideTransactionSummaryBloc(
    TransactionRepository repository,
    AccountsBloc accountsBloc,
  ) => 
      TransactionSummaryBloc(repository, accountsBloc);
} 