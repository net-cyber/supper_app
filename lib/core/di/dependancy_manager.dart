import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/di/dependancy_manager.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => getIt.init();
