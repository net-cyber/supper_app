import 'package:get_it/get_it.dart';
import 'package:super_app/core/handlers/http_service.dart';


final GetIt getIt = GetIt.instance;

void setUpDependencies() {
  getIt.registerLazySingleton<HttpService>(HttpService.new);
}