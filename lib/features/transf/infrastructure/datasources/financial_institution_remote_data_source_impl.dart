import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/handlers/http_service.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/financial_institution/financial_institution.dart';
import 'package:super_app/features/transf/infrastructure/datasources/financial_institution_remote_data_source.dart';

@Injectable(as: FinancialInstitutionRemoteDataSource)
class FinancialInstitutionRemoteDataSourceImpl implements FinancialInstitutionRemoteDataSource {
  @override
  Future<Either<NetworkExceptions, List<FinancialInstitution>>> getFinancialInstitutions({
    required int pageId,
    required int pageSize,
  }) async {
    try {
      log('Fetching financial institutions - pageId: $pageId, pageSize: $pageSize');
      
      final response = await getIt<HttpService>().client(requireAuth: true).get(
        '/financial-institutions',
        queryParameters: {
          'page_id': pageId,
          'page_size': pageSize,
        },
      );

      // Log the response structure for debugging
      log('Financial institutions response: ${response.data}');
      
      if (response.data == null) {
        log('Server returned null response');
        return const Right([]);
      }

      // Initialize an empty list for the institutions
      List<FinancialInstitution> institutions = [];
      
      // Handle different response formats
      if (response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        log('Response is a Map with keys: ${data.keys.join(", ")}');
        
        // Try to find the list of institutions in the response
        dynamic institutionsData;
        
        // Check common patterns for API responses
        if (data.containsKey('data')) {
          institutionsData = data['data'];
          log('Found institutions in "data" field: ${institutionsData.runtimeType}');
        } else if (data.containsKey('items')) {
          institutionsData = data['items'];
          log('Found institutions in "items" field: ${institutionsData.runtimeType}');
        } else if (data.containsKey('results')) {
          institutionsData = data['results'];
          log('Found institutions in "results" field: ${institutionsData.runtimeType}');
        } else if (data.containsKey('financial_institutions')) {
          institutionsData = data['financial_institutions'];
          log('Found institutions in "financial_institutions" field: ${institutionsData.runtimeType}');
        }
        
        // Return empty list if no institutions data found
        if (institutionsData == null || (institutionsData is List && institutionsData.isEmpty)) {
          log('API returned no institutions or invalid format.');
          return const Right([]);
        }
        
        // Process the institutions data if it's a list
        if (institutionsData is List) {
          institutions = institutionsData.map((json) {
            // Log each item for debugging
            log('Processing institution: $json');
            
            // Handle different field naming conventions
            String id = '';
            if (json['id'] != null) id = json['id'].toString();
            else if (json['_id'] != null) id = json['_id'].toString();
            
            String name = json['name']?.toString() ?? 'Unknown Institution';
            
            String code = '';
            if (json['code'] != null) code = json['code'].toString();
            else if (json['short_name'] != null) code = json['short_name'].toString();
            else code = name.split(' ').first.toUpperCase();
            
            String type = 'unknown';
            if (json['type'] != null) type = json['type'].toString().toLowerCase();
            // Default type to 'bank' if name contains 'bank' or 'wallet' if name contains wallet-related keywords
            else if (name.toLowerCase().contains('bank')) type = 'bank';
            else if (name.toLowerCase().contains('birr') || 
                     name.toLowerCase().contains('cash') || 
                     name.toLowerCase().contains('pesa') ||
                     name.toLowerCase().contains('wallet')) {
              type = 'wallet';
            }
            
            String? logoUrl;
            if (json['logo_url'] != null) logoUrl = json['logo_url'].toString();
            else if (json['logo'] != null) logoUrl = json['logo'].toString();
            else if (json['image'] != null) logoUrl = json['image'].toString();
            
            String? description;
            if (json['description'] != null) description = json['description'].toString();
            else if (json['info'] != null) description = json['info'].toString();
            
            bool active = true;
            if (json['active'] != null) active = json['active'] as bool;
            
            return FinancialInstitution(
              id: id,
              name: name,
              code: code,
              type: type,
              logoUrl: logoUrl,
              description: description,
              active: active,
            );
          }).toList();
          
          log('Processed ${institutions.length} institutions successfully');
          return Right(institutions);
        } else if (institutionsData != null) {
          log('institutions data is not a List: ${institutionsData.runtimeType}');
          return const Right([]);
        }
      } else if (response.data is List) {
        // Handle case where response is directly a list
        log('Response is directly a List with ${(response.data as List).length} items');
        
        institutions = (response.data as List).map((json) {
          return FinancialInstitution(
            id: json['id']?.toString() ?? '',
            name: json['name']?.toString() ?? '',
            code: json['code']?.toString() ?? '',
            type: json['type']?.toString() ?? 'unknown',
            logoUrl: json['logo_url']?.toString(),
            description: json['description']?.toString(),
            active: json['active'] as bool? ?? true,
          );
        }).toList();
        
        log('Processed ${institutions.length} institutions successfully');
        return Right(institutions);
      }

      // If no institutions found, return an empty list
      log('No institutions found in response.');
      return const Right([]);
    } catch (e) {
      log('Error fetching financial institutions: $e');
      return Left(NetworkExceptions.getDioException(e));
    }
  }
} 
