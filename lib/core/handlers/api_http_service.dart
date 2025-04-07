import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/auth/token_service.dart';
import 'package:super_app/core/config/api_config.dart';

@lazySingleton
class ApiHttpService {
  final ApiConfig _apiConfig;
  final TokenService _tokenService;

  ApiHttpService(this._apiConfig, this._tokenService);

  Future<Dio> client() async {
    // Get dynamic token from token service if user is logged in
    String? authHeader;
    final isLoggedIn = await _tokenService.isUserLoggedIn();

    if (isLoggedIn) {
      final token = await _tokenService.getAccessToken();
      if (token != null && token.isNotEmpty) {
        authHeader = 'Bearer $token';
      }
    }

    // Use hardcoded token from config as fallback if no user is logged in
    // This is primarily for development/testing purposes
    authHeader ??= 'Bearer ${_apiConfig.apiToken}';

    return Dio(
      BaseOptions(
        baseUrl: _apiConfig.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': authHeader,
        },
      ),
    )..interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ));
  }
}
