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
    gh.lazySingleton<_i350.HttpService>(() => _i350.HttpService());
    gh.factory<_i1046.AuthRemoteDataSource>(
        () => _i1046.AuthRemoteDataSourceImpl());
    gh.factory<_i811.AccountsRemoteDataSource>(
        () => _i811.AccountsRemoteDataSourceImpl());
    gh.factory<_i787.AuthRepository>(
        () => _i446.AuthRepositoryImpl(gh<_i1046.AuthRemoteDataSource>()));
    gh.factory<_i516.UserService>(() => _i516.UserServiceImpl());
    gh.factory<_i706.AccountRespository>(() =>
        _i658.AccountRepositoryImpl(gh<_i811.AccountsRemoteDataSource>()));
    gh.factory<_i247.OtpVerificationBloc>(
        () => _i247.OtpVerificationBloc(gh<_i787.AuthRepository>()));
    gh.factory<_i623.LoginBloc>(
        () => _i623.LoginBloc(gh<_i787.AuthRepository>()));
    gh.factory<_i859.RegistrationBloc>(
        () => _i859.RegistrationBloc(gh<_i787.AuthRepository>()));
    gh.factory<_i671.AccountsBloc>(
        () => _i671.AccountsBloc(gh<_i706.AccountRespository>()));
    return this;
  }
}
