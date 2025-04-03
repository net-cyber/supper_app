import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/http_service.dart';

@module
abstract class CoreInjectableModule {
  @lazySingleton
  HttpService get httpService => HttpService();
} 