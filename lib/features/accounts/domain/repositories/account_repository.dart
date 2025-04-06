import 'package:dartz/dartz.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/accounts/domain/entities/account.dart';


abstract class AccountRespository {
  /// Fetches a paginated list of accounts
  Future<Either<NetworkExceptions, List<Account>>> getAccounts({
    required int pageId,
    required int pageSize,
  });
  
}
