import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/transfer_result.dart';
import 'package:super_app/features/transf/domain/failures/failure.dart';
import 'package:super_app/features/transf/domain/repositories/transfer_repository.dart';
import 'package:super_app/features/transf/domain/value_objects/value_objects.dart';
import 'package:super_app/features/transf/infrastructure/datasources/transfer_remote_data_source.dart';

@Injectable(as: TransferRepository)
class TransferRepositoryImpl implements TransferRepository {
  final TransferRemoteDataSource _remoteDataSource;

  TransferRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, TransferResult>> transfer({
    required AccountNumber fromAccountNumber,
    required AccountNumber toAccountNumber,
    required Amount amount,
    String? reference,
    String? description,
  }) async {
    try {
      // Extract the raw values from our domain objects
      final fromAccount = fromAccountNumber.getOrElse('');
      final toAccount = toAccountNumber.getOrElse('');
      final amountValue = amount.getValue();

      // Call the data source method
      final response = await _remoteDataSource.executeTransfer(
        fromAccountId: fromAccount,
        toAccountId: toAccount,
        amount: amountValue,
        reference: reference,
        description: description,
      );

      // Parse response to our domain entity
      // The mapping here assumes the response structure matches what we need
      // You may need to adjust based on the actual API response
      final transferResult = TransferResult(
        transactionId: response['transfer']['id'].toString(),
        fromAccountNumber: fromAccountNumber,
        toAccountNumber: toAccountNumber,
        amount: response['transfer']['amount'] as double,
        currency: response['from_account']['currency'] as String,
        timestamp: DateTime.parse(response['transfer']['created_at'] as String),
        status: 'completed', // Assuming successful transfer means completed
        reference: reference,
        description: description,
      );

      return right(transferResult);
    } on DioException catch (e) {
      return left(_handleDioException(e));
    } catch (e) {
      if (e.toString().contains('Authentication required')) {
        return left(const Failure.unauthorized(
            'Authentication required. Please log in.'));
      }
      return left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> verifyAccount(
      AccountNumber accountNumber) async {
    try {
      final accountId = accountNumber.getOrElse('');
      final response = await _remoteDataSource.verifyAccount(accountId);

      // The response contains the account owner's full name
      final fullName = response['full_name'] as String;
      return right(fullName);
    } on DioException catch (e) {
      return left(_handleDioException(e));
    } catch (e) {
      if (e.toString().contains('Authentication required')) {
        return left(const Failure.unauthorized(
            'Authentication required. Please log in.'));
      }
      return left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> hasSufficientFunds({
    required AccountNumber accountNumber,
    required Amount amount,
  }) async {
    try {
      final accountId = accountNumber.getOrElse('');
      final amountValue = amount.getValue();

      final response = await _remoteDataSource.validateFunds(
        accountId: accountId,
        amount: amountValue,
      );

      // Check the response message to determine if there are sufficient funds
      final message = response['message'] as String;
      final hasSufficientFunds = message.contains('sufficient');

      return right(hasSufficientFunds);
    } on DioException catch (e) {
      return left(_handleDioException(e));
    } catch (e) {
      if (e.toString().contains('Authentication required')) {
        return left(const Failure.unauthorized(
            'Authentication required. Please log in.'));
      }
      return left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> getAccountBalance(
      AccountNumber accountNumber) async {
    try {
      final accountId = accountNumber.getOrElse('');
      final response = await _remoteDataSource.getAccountBalance(accountId);

      // Extract the balance from the response
      final balance = response['balance'] as double;
      return right(balance);
    } on DioException catch (e) {
      return left(_handleDioException(e));
    } catch (e) {
      if (e.toString().contains('Authentication required')) {
        return left(const Failure.unauthorized(
            'Authentication required. Please log in.'));
      }
      return left(Failure.unknown(e.toString()));
    }
  }

  // Helper method to convert DioExceptions to our domain Failures
  Failure _handleDioException(DioException e) {
    final networkException = NetworkExceptions.getDioException(e);

    // Map network exceptions to appropriate domain failures using when pattern
    return networkException.when(
      unauthorisedRequest: () => const Failure.unauthorized(
          'You are not authorized to perform this action'),
      notFound: (String reason) =>
          Failure.accountNotFound('Account not found: $reason'),
      badRequest: () {
        final response = e.response?.data as Map<String, dynamic>?;
        final message =
            response?['message'] as String? ?? 'Invalid data provided';

        if (message.toLowerCase().contains('insufficient')) {
          return Failure.insufficientFunds(message);
        } else {
          return Failure.validationError(message);
        }
      },
      noInternetConnection: () =>
          const Failure.networkError('No internet connection'),
      internalServerError: () =>
          const Failure.serverError('Internal server error'),
      // Handle all other types of network exceptions
      requestCancelled: () => Failure.unknown('Request cancelled'),
      badCertificate: () => Failure.unknown('Bad certificate'),
      connectionError: () => const Failure.networkError('Connection error'),
      notImplemented: () => Failure.serverError('Not implemented'),
      serviceUnavailable: () => Failure.serverError('Service unavailable'),
      methodNotAllowed: () => Failure.serverError('Method not allowed'),
      unexpectedError: () => Failure.unknown('Unexpected error occurred'),
      requestTimeout: () => const Failure.networkError('Request timeout'),
      conflict: () => Failure.validationError('Conflict error'),
      sendTimeout: () => const Failure.networkError('Send timeout'),
      unableToProcess: () => Failure.unknown('Unable to process the data'),
      defaultError: (String error) => Failure.unknown(error),
      formatException: () => Failure.unknown('Format exception'),
      notAcceptable: () => Failure.serverError('Not acceptable'),
    );
  }
}
