import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/api_http_service.dart';
import 'package:super_app/features/transf/domain/entities/transaction_request.dart';
import 'package:super_app/features/transf/domain/entities/transaction_response.dart';

abstract class TransferRemoteDataSource {
  /// Initiates a bank transfer between accounts via API
  Future<TransactionResponse> initiateTransfer(TransactionRequest request);
}

@Injectable(as: TransferRemoteDataSource)
class TransferRemoteDataSourceImpl implements TransferRemoteDataSource {
  final ApiHttpService _httpService;

  TransferRemoteDataSourceImpl(this._httpService);

  @override
  Future<TransactionResponse> initiateTransfer(
      TransactionRequest request) async {
    try {
      // Convert request to JSON map
      final Map<String, dynamic> data = {
        'from_account_id': request.from_account_id,
        'to_account_id': request.to_account_id,
        'amount': request.amount,
        'currency': request.currency,
      };

      // Get the configured HTTP client
      final client = await _httpService.client();

      // Make the API call
      final response = await client.post(
        '/transfers',
        data: data,
      );

      // Convert response to domain entity
      return TransactionResponse.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      // Log the error for debugging
      print('API Error: ${e.message}');
      print('Response: ${e.response?.data}');

      // Rethrow to be handled by repository
      rethrow;
    } catch (e) {
      // Log any other errors
      print('Unexpected error: $e');
      rethrow;
    }
  }
}
