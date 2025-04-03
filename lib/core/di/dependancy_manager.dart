import 'package:injectable/injectable.dart';

// Note: After setting up injectable, individual components will be
// annotated with @injectable, @singleton, etc., and the manual dependency
// registration will be replaced by automatic registration.

@module
abstract class AppModule {
  // Register any third-party services or configurations here
  // Example:
  // @singleton
  // MyExternalService get externalService => MyExternalService();
}
