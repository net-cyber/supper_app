import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/handlers/http_service.dart';
import 'package:super_app/features/accounts/domain/entities/account.dart';

abstract class AccountsRemoteDataSource {
  Future<List<Account>> getAccounts({
    required int pageId,
    required int pageSize,
  });
}

@Injectable(as: AccountsRemoteDataSource)
class AccountsRemoteDataSourceImpl implements AccountsRemoteDataSource {
  @override
  Future<List<Account>> getAccounts({
    required int pageId,
    required int pageSize,
  }) async {
    try {
      final response = await getIt<HttpService>().client(requireAuth: true).get(
        '/accounts',
        queryParameters: {
          'page_id': pageId,
          'page_size': pageSize,
        },
      );
      
      // Convert the response data to a list of accounts
      final List<dynamic> accountsData = response.data as List<dynamic>;
      return accountsData
          .map((accountData) => Account.fromJson(accountData as Map<String, dynamic>))
          .toList();
    } on DioException {
      rethrow;
    }
  }
}