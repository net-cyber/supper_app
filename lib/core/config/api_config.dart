import 'package:injectable/injectable.dart';

@singleton
class ApiConfig {
  final String baseUrl;
  final String apiToken;

  ApiConfig({
    required this.baseUrl,
    required this.apiToken,
  });

  @factoryMethod
  @prod
  static ApiConfig production() {
    return ApiConfig(
      baseUrl: 'https://nekapay-a88c51536db4.herokuapp.com',
      apiToken:
          'v2.local.20SCg8pNjjsCYSFwo-ftAVzHAvMZ3-bfAn4EW84mC497WrJgKAywSqOE-RDJtCqFNQY99HZ04VGgHmov1GQgAEeGr6YTuASm-bxv0KAakhgs55_mTf9mJAzMLtIXJknJOTzJmx9kcEDoA0lpsm801fekNTEUasfbzhB7n-ItYR1UM0CnbrqCF8-iPm5lYYDa5KDdPX_4EHq6pVRpRGaV8cg99qfCz-8y8-YTfowl7F5h5WN2Te_7WPb5RqX6GsQ3mvC1oARX3HuS8el309BWS4nOWrVOURSBOTDk.bnVsbA',
    );
  }

  @factoryMethod
  @dev
  static ApiConfig development() {
    return ApiConfig(
      baseUrl: 'https://nekapay-a88c51536db4.herokuapp.com',
      apiToken:
          'v2.local.20SCg8pNjjsCYSFwo-ftAVzHAvMZ3-bfAn4EW84mC497WrJgKAywSqOE-RDJtCqFNQY99HZ04VGgHmov1GQgAEeGr6YTuASm-bxv0KAakhgs55_mTf9mJAzMLtIXJknJOTzJmx9kcEDoA0lpsm801fekNTEUasfbzhB7n-ItYR1UM0CnbrqCF8-iPm5lYYDa5KDdPX_4EHq6pVRpRGaV8cg99qfCz-8y8-YTfowl7F5h5WN2Te_7WPb5RqX6GsQ3mvC1oARX3HuS8el309BWS4nOWrVOURSBOTDk.bnVsbA',
    );
  }

  @factoryMethod
  @test
  static ApiConfig testing() {
    return ApiConfig(
      baseUrl: 'https://nekapay-a88c51536db4.herokuapp.com',
      apiToken: 'test-token',
    );
  }
}
