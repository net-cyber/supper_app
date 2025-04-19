import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/constants/app_constants.dart';
import 'package:super_app/core/handlers/token_interceptor.dart';

@lazySingleton
class HttpService {
  Dio client({bool requireAuth = false}) {
    return Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    )
      ..interceptors.add(TokenInterceptor(requireAuth: requireAuth))
      ..interceptors.add(LogInterceptor());
  }
}
