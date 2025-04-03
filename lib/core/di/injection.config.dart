// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/transf/application/external_transfer/external_transfer_bloc.dart'
    as _i622;
import '../../features/transf/application/internal_transfer/internal_transfer_bloc.dart'
    as _i436;
import '../../features/transf/application/wallet_transfer/wallet_transfer_bloc.dart'
    as _i65;
import '../../features/transf/domain/repositories/bank_account_repository.dart'
    as _i291;
import '../../features/transf/domain/repositories/transfer_repository.dart'
    as _i754;
import '../../features/transf/domain/repositories/wallet_repository.dart'
    as _i915;
import '../handlers/http_service.dart' as _i350;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i350.HttpService>(() => _i350.HttpService());
  gh.factory<_i65.WalletTransferBloc>(() => _i65.WalletTransferBloc(
        walletRepository: gh<_i915.WalletRepository>(),
        transferRepository: gh<_i754.TransferRepository>(),
      ));
  gh.factory<_i622.ExternalTransferBloc>(() => _i622.ExternalTransferBloc(
        bankAccountRepository: gh<_i291.BankAccountRepository>(),
        transferRepository: gh<_i754.TransferRepository>(),
      ));
  gh.factory<_i436.InternalTransferBloc>(() => _i436.InternalTransferBloc(
        bankAccountRepository: gh<_i291.BankAccountRepository>(),
        transferRepository: gh<_i754.TransferRepository>(),
      ));
  return getIt;
}
