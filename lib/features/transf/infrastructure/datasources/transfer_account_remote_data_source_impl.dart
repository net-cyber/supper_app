import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/handlers/http_service.dart';
import 'package:super_app/core/utils/local_storage.dart';
import 'package:super_app/features/transf/domain/entities/account_verification/account_verification.dart';

@injectable
class TransferAccountRemoteDataSource {
  Future<AccountVerification> verifyAccount(int accountId) async {
    try {
      final response = await getIt<HttpService>().client(requireAuth: true).get(
        '/accounts/verification/$accountId',
      );

      if (response.data == null) {
        throw Exception('Server returned null response');
      }

      if (response.data is! Map<String, dynamic>) {
        // If it's a string, try to convert to AccountVerification with fullName
        if (response.data is String) {
          return AccountVerification(fullName: response.data.toString());
        }

        // Try to handle common response formats
        if (response.data is Map) {
          // Force cast to Map<String, dynamic> if it's a Map of some kind
          final Map<String, dynamic> dataMap =
              Map<String, dynamic>.from(response.data as Map);
          if (dataMap.containsKey('full_name')) {
            return AccountVerification.fromJson(dataMap);
          }

          // Handle potential nested data structure
          if (dataMap.containsKey('data') && dataMap['data'] is Map) {
            final nestedData =
                Map<String, dynamic>.from(dataMap['data'] as Map);
            if (nestedData.containsKey('full_name')) {
              return AccountVerification.fromJson(nestedData);
            }
          }
        }

        throw Exception('Unexpected response format');
      }

      // Parse the response
      return AccountVerification.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      // Re-throw to be handled by the repository
      throw e;
    } catch (e) {
      // Re-throw any other exceptions
      throw e;
    }
  }
}

// Helper function for safe substring operation
int min(int a, int b) => a < b ? a : b;
