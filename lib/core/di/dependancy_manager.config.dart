// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/application/registration/bloc/registration_bloc.dart'
    as _i859;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/infrastructure/repositories/auth_repository_impl.dart'
    as _i748;

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
    gh.factory<_i787.AuthRepository>(() => _i748.AuthRepositoryImpl());
    gh.factory<_i859.RegistrationBloc>(
        () => _i859.RegistrationBloc(gh<_i787.AuthRepository>()));
    return this;
  }
}
