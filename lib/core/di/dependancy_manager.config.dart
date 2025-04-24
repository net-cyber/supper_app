// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/accounts/application/list/bloc/accounts_bloc.dart'
    as _i671;
import '../../features/accounts/domain/repositories/account_repository.dart'
    as _i706;
import '../../features/accounts/infrastructure/datasources/accounts_remote_data_source.dart'
    as _i811;
import '../../features/accounts/infrastructure/repositories/account_repository_impl.dart'
    as _i658;
import '../../features/auth/application/login/bloc/login_bloc.dart' as _i623;
import '../../features/auth/application/registration/bloc/registration_bloc.dart'
    as _i859;
import '../../features/auth/application/verification/bloc/otp_verification_bloc.dart'
    as _i247;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/user/user_service.dart' as _i516;
import '../../features/auth/infrastructure/auth/datasources/auth_remote_data_source.dart'
    as _i1046;
import '../../features/auth/infrastructure/auth/repositories/auth_repository_impl.dart'
    as _i446;
import '../../features/history/application/transactions_bloc.dart' as _i73;
import '../../features/history/domain/repositories/transaction_repository.dart'
    as _i28;
import '../../features/history/infrastructure/datasources/transactions_remote_data_source.dart'
    as _i1019;
import '../../features/history/infrastructure/repositories/transaction_repository_impl.dart'
    as _i348;
import '../../features/transf/application/bank_account_validation/bloc/bank_account_validation_bloc.dart'
    as _i649;
import '../../features/transf/application/external_transfer/bloc/external_transfer_bloc.dart'
    as _i1032;
import '../../features/transf/application/financial_institution/bloc/financial_institution_bloc.dart'
    as _i811;
import '../../features/transf/application/transfer/bloc/transfer_bloc.dart'
    as _i1017;
import '../../features/transf/application/validation/bloc/account_validation_bloc.dart'
    as _i346;
import '../../features/transf/application/verification/bloc/account_verification_bloc.dart'
    as _i265;
import '../../features/transf/domain/repositories/account_validation_repository.dart'
    as _i153;
import '../../features/transf/domain/repositories/bank_account_validation_repository.dart'
    as _i924;
import '../../features/transf/domain/repositories/external_transfer_repository.dart'
    as _i863;
import '../../features/transf/domain/repositories/financial_institution_repository.dart'
    as _i192;
import '../../features/transf/domain/repositories/transfer_account_repository.dart'
    as _i644;
import '../../features/transf/domain/repositories/transfer_repository.dart'
    as _i754;
import '../../features/transf/infrastructure/datasources/account_validation_remote_data_source_impl.dart'
    as _i670;
import '../../features/transf/infrastructure/datasources/bank_account_validation_remote_data_source_impl.dart'
    as _i15;
import '../../features/transf/infrastructure/datasources/external_transfer_remote_data_source_impl.dart'
    as _i552;
import '../../features/transf/infrastructure/datasources/financial_institution_remote_data_source_impl.dart'
    as _i537;
import '../../features/transf/infrastructure/datasources/transfer_account_remote_data_source_impl.dart'
    as _i213;
import '../../features/transf/infrastructure/datasources/transfer_remote_data_source_impl.dart'
    as _i548;
import '../../features/transf/infrastructure/repositories/account_validation_repository_impl.dart'
    as _i519;
import '../../features/transf/infrastructure/repositories/bank_account_validation_repository_impl.dart'
    as _i284;
import '../../features/transf/infrastructure/repositories/external_transfer_repository_impl.dart'
    as _i159;
import '../../features/transf/infrastructure/repositories/financial_institution_repository_impl.dart'
    as _i987;
import '../../features/transf/infrastructure/repositories/transfer_account_repository_impl.dart'
    as _i354;
import '../../features/transf/infrastructure/repositories/transfer_repository_impl.dart'
    as _i655;
import '../auth/token_service.dart' as _i347;
import '../config/api_config.dart' as _i51;
import '../handlers/http_service.dart' as _i350;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i213.TransferAccountRemoteDataSource>(
        () => _i213.TransferAccountRemoteDataSource());
    gh.singleton<_i51.ApiConfig>(() => _i51.ApiConfig.production());
    gh.lazySingleton<_i347.TokenService>(() => _i347.TokenService());
    gh.lazySingleton<_i350.HttpService>(() => _i350.HttpService());
    gh.factory<_i548.TransferRemoteDataSource>(
        () => _i548.TransferRemoteDataSourceImpl());
    gh.factory<_i552.ExternalTransferRemoteDataSource>(
        () => _i552.ExternalTransferRemoteDataSourceImpl());
    gh.factory<_i1046.AuthRemoteDataSource>(
        () => _i1046.AuthRemoteDataSourceImpl());
    gh.factory<_i1019.TransactionsRemoteDataSource>(
        () => _i1019.TransactionsRemoteDataSourceImpl());
    gh.factory<_i537.FinancialInstitutionRemoteDataSource>(
        () => _i537.FinancialInstitutionRemoteDataSourceImpl());
    gh.factory<_i670.AccountValidationRemoteDataSource>(
        () => _i670.AccountValidationRemoteDataSourceImpl());
    gh.factory<_i811.AccountsRemoteDataSource>(
        () => _i811.AccountsRemoteDataSourceImpl());
    gh.factory<_i787.AuthRepository>(
        () => _i446.AuthRepositoryImpl(gh<_i1046.AuthRemoteDataSource>()));
    gh.factory<_i28.TransactionRepository>(() =>
        _i348.TransactionRepositoryImpl(
            gh<_i1019.TransactionsRemoteDataSource>()));
    gh.factory<_i516.UserService>(() => _i516.UserServiceImpl());
    gh.factory<_i15.BankAccountValidationRemoteDataSource>(
        () => _i15.BankAccountValidationRemoteDataSourceImpl());
    gh.factory<_i153.AccountValidationRepository>(() =>
        _i519.AccountValidationRepositoryImpl(
            gh<_i670.AccountValidationRemoteDataSource>()));
    gh.factory<_i192.FinancialInstitutionRepository>(() =>
        _i987.FinancialInstitutionRepositoryImpl(
            gh<_i537.FinancialInstitutionRemoteDataSource>()));
    gh.factory<_i754.TransferRepository>(() =>
        _i655.TransferRepositoryImpl(gh<_i548.TransferRemoteDataSource>()));
    gh.factory<_i924.BankAccountValidationRepository>(() =>
        _i284.BankAccountValidationRepositoryImpl(
            gh<_i15.BankAccountValidationRemoteDataSource>()));
    gh.factory<_i644.TransferAccountRepository>(() =>
        _i354.TransferAccountRepositoryImpl(
            gh<_i213.TransferAccountRemoteDataSource>()));
    gh.factory<_i863.ExternalTransferRepository>(() =>
        _i159.ExternalTransferRepositoryImpl(
            gh<_i552.ExternalTransferRemoteDataSource>()));
    gh.factory<_i706.AccountRespository>(() =>
        _i658.AccountRepositoryImpl(gh<_i811.AccountsRemoteDataSource>()));
    gh.factory<_i623.LoginBloc>(
        () => _i623.LoginBloc(gh<_i787.AuthRepository>()));
    gh.factory<_i859.RegistrationBloc>(
        () => _i859.RegistrationBloc(gh<_i787.AuthRepository>()));
    gh.factory<_i247.OtpVerificationBloc>(
        () => _i247.OtpVerificationBloc(gh<_i787.AuthRepository>()));
    gh.factory<_i811.FinancialInstitutionBloc>(() =>
        _i811.FinancialInstitutionBloc(
            gh<_i192.FinancialInstitutionRepository>()));
    gh.factory<_i265.AccountVerificationBloc>(() =>
        _i265.AccountVerificationBloc(gh<_i644.TransferAccountRepository>()));
    gh.singleton<_i671.AccountsBloc>(
        () => _i671.AccountsBloc(gh<_i706.AccountRespository>()));
    gh.factory<_i1032.ExternalTransferBloc>(() => _i1032.ExternalTransferBloc(
          gh<_i863.ExternalTransferRepository>(),
          gh<_i671.AccountsBloc>(),
        ));
    gh.factory<_i649.BankAccountValidationBloc>(() =>
        _i649.BankAccountValidationBloc(
            gh<_i924.BankAccountValidationRepository>()));
    gh.factory<_i1017.TransferBloc>(() => _i1017.TransferBloc(
          gh<_i754.TransferRepository>(),
          gh<_i671.AccountsBloc>(),
        ));
    gh.singleton<_i73.TransactionsBloc>(() => _i73.TransactionsBloc(
          gh<_i28.TransactionRepository>(),
          gh<_i671.AccountsBloc>(),
        ));
    gh.factory<_i346.AccountValidationBloc>(() => _i346.AccountValidationBloc(
          gh<_i153.AccountValidationRepository>(),
          gh<_i671.AccountsBloc>(),
        ));
    return this;
  }
}
