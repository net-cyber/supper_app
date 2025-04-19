import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/handlers/http_service.dart';
import 'package:super_app/features/transf/domain/entities/account_validation/account_validation.dart';

@injectable
class AccountValidationRemoteDataSource {
  Future<AccountValidation> validateAccount(
      double amount, int currentAccountId) async {
    try {
      final Map<String, dynamic> body = {
        'amount': amount.toInt(),
        'account_id': currentAccountId,
      };

      final response = await getIt<HttpService>().client(requireAuth: true).get(
        '/accounts/validate',
        data: body,
      );

      if (response.data == null) {
        throw Exception('Server returned null response');
      }

      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        final message = data['message'] as String? ?? 'Account validated';
        bool isSufficient = false;

        if (data.containsKey('is_sufficient')) {
          isSufficient = data['is_sufficient'] as bool;
        } else {
          isSufficient = message.toLowerCase().contains('sufficient');
        }

        return AccountValidation(
          message: message,
          isSufficient: isSufficient,
        );
      } else if (response.data is String) {
        final message = response.data as String;
        final isSufficient = message.toLowerCase().contains('sufficient');

        return AccountValidation(
          message: message,
          isSufficient: isSufficient,
        );
      }

      throw Exception('Unexpected response format');
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw DioException(
          requestOptions: e.requestOptions,
          error: 'Your session has expired. Please login again.',
          type: DioExceptionType.badResponse,
          response: e.response,
        );
      } else if (e.response?.statusCode == 422) {
        final message = e.response?.data?['message'] as String? ??
            'Insufficient funds for this transaction';

        throw Exception(message);
      } else if (e.response?.statusCode == 404) {
        throw Exception(
            'Account validation service unavailable. Please try again later.');
      } else if (e.response?.statusCode == 400) {
        String errorMessage = 'Invalid request format';

        if (e.response?.data != null && e.response?.data is Map) {
          final errorData = e.response?.data as Map;
          if (errorData.containsKey('message')) {
            errorMessage = errorData['message'].toString();
          } else if (errorData.containsKey('error')) {
            errorMessage = errorData['error'].toString();
          }
        }

        throw Exception('Validation failed: $errorMessage');
      }
      throw e;
    } catch (e) {
      throw e;
    }
  }
}
