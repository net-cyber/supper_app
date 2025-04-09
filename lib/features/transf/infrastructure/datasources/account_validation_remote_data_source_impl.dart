import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/handlers/http_service.dart';
import 'package:super_app/core/utils/local_storage.dart';
import 'package:super_app/features/transf/domain/entities/account_validation.dart';

@injectable
class AccountValidationRemoteDataSource {
  Future<AccountValidation> validateAccount(
      double amount, int currentAccountId) async {
    try {
      // Get the access token
      final accessToken = await LocalStorage.instance.getAccessToken();

      // Check if token is null or empty
      if (accessToken == null || accessToken.isEmpty) {
        throw DioException(
          requestOptions: RequestOptions(path: '/accounts/validate'),
          error: 'No valid access token',
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(path: '/accounts/validate'),
            statusCode: 401,
            data: {'message': 'Unauthorized: No valid token'},
          ),
        );
      }

      // Prepare headers with authorization
      final Map<String, dynamic> headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };

      // Prepare request body
      final Map<String, dynamic> body = {
        'account_id': currentAccountId, // Use the passed account ID
        'amount': amount,
      };

      // Make API request
      final response = await getIt<HttpService>().client().post(
            '/accounts/validate',
            data: body,
            options: Options(headers: headers),
          );

      // Check if response data is null
      if (response.data == null) {
        throw Exception('Server returned null response');
      }

      // Handle different response formats
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;

        // Extract message
        final message = data['message'] as String? ?? 'Account validated';

        // Determine if sufficient based on message
        final isSufficient = message.toLowerCase().contains('sufficient');

        return AccountValidation(
          message: message,
          isSufficient: isSufficient,
        );
      } else if (response.data is String) {
        // Handle string response
        final message = response.data as String;
        final isSufficient = message.toLowerCase().contains('sufficient');

        return AccountValidation(
          message: message,
          isSufficient: isSufficient,
        );
      }

      throw Exception('Unexpected response format');
    } on DioException catch (e) {
      // Re-throw to be handled by the repository
      throw e;
    } catch (e) {
      // Re-throw any other exceptions
      throw e;
    }
  }
}
