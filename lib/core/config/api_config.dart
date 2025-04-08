import 'package:injectable/injectable.dart';

@singleton
class ApiConfig {
  final String baseUrl;

  ApiConfig({
    required this.baseUrl,
  });

  @factoryMethod
  @prod
  static ApiConfig production() {
    return ApiConfig(
      baseUrl: 'https://nekapay-a88c51536db4.herokuapp.com',
    );
  }

  @factoryMethod
  @dev
  static ApiConfig development() {
    return ApiConfig(
      baseUrl: 'https://nekapay-a88c51536db4.herokuapp.com',
    );
  }

  @factoryMethod
  @test
  static ApiConfig testing() {
    return ApiConfig(
      baseUrl: 'https://nekapay-a88c51536db4.herokuapp.com',
    );
  }
}
