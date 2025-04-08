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
    // Get token from token service
    String? authHeader;
    final token = await _tokenService.getAccessToken();

    if (token != null && token.isNotEmpty) {
      authHeader = 'Bearer $token';
    } else {
      // If no token is available, throw an exception
      throw Exception('Authentication token not available. Please log in.');
    }

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
