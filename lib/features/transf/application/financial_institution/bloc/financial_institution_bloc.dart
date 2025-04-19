import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:super_app/core/handlers/app_connectivity.dart';
import 'package:super_app/core/handlers/network_exceptions.dart';
import 'package:super_app/features/transf/domain/entities/financial_institution/financial_institution.dart';
import 'package:super_app/features/transf/domain/repositories/financial_institution_repository.dart';

part 'financial_institution_event.dart';
part 'financial_institution_state.dart';
part 'financial_institution_bloc.freezed.dart';

@injectable
class FinancialInstitutionBloc
    extends Bloc<FinancialInstitutionEvent, FinancialInstitutionState> {
  final FinancialInstitutionRepository _repository;

  // Add separate page sizes for different institution types
  static const int defaultPageSize = 10;
  static const int bankPageSize = 6;
  static const int walletPageSize = 6;
  
  // Track empty responses to determine end of pagination
  bool _receivedEmptyResponse = false;
  
  // Track if we're automatically loading all pages
  bool _isLoadingAll = false;

  FinancialInstitutionBloc(this._repository)
      : super(FinancialInstitutionState.initial()) {
    on<FetchInstitutions>(_onFetchInstitutions);
    on<FilterByType>(_onFilterByType);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<LoadMoreInstitutions>(_onLoadMoreInstitutions);
    on<RefreshInstitutions>(_onRefreshInstitutions);
  }

  // Get the appropriate page size based on institution type
  int _getPageSize(FinancialInstitutionType type) {
    switch (type) {
      case FinancialInstitutionType.bank:
        return bankPageSize;
      case FinancialInstitutionType.wallet:
        return walletPageSize;
      case FinancialInstitutionType.all:
      default:
        return defaultPageSize;
    }
  }

  // Helper to automatically load the next page
  void _loadNextPageAutomatically() {
    if (_isLoadingAll && state.hasMorePages && !state.isLoading) {
      log('FinancialInstitutionBloc: Automatically loading next page (${state.currentPage + 1})');
      add(FetchInstitutions(
        pageId: state.currentPage + 1,
        pageSize: _getPageSize(state.type),
      ));
    }
  }

  Future<void> _onFetchInstitutions(
      FetchInstitutions event, Emitter<FinancialInstitutionState> emit) async {
    log('FinancialInstitutionBloc: Fetching institutions - pageId: ${event.pageId}, pageSize: ${event.pageSize}');
    
    // If it's page 1, we're starting a new fetch - enable auto-loading all pages
    if (event.pageId == 1) {
      _isLoadingAll = true;
    }
    
    // Get the appropriate page size based on current type filter
    final pageSize = event.pageSize > 0 ? event.pageSize : _getPageSize(state.type);
    
    // If it's the first page, reset tracking and show loading indicator
    if (event.pageId == 1) {
      _receivedEmptyResponse = false;
      emit(state.copyWith(isLoading: true, hasError: false, errorMessage: ''));
    } else {
      // Show loading indicator for subsequent pages too, but keep existing data
      emit(state.copyWith(isLoading: true));
    }

    // Check internet connection
    final hasConnectivity = await AppConnectivity.connectivity();
    log('FinancialInstitutionBloc: Internet connectivity check: $hasConnectivity');

    if (!hasConnectivity) {
      log('FinancialInstitutionBloc: No internet connection');
      emit(
        state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage: 'No internet connection. Please check your network.',
        ),
      );
      return;
    }

    try {
      log('FinancialInstitutionBloc: Calling repository with pageSize: $pageSize');
      final result = await _repository.getFinancialInstitutions(
        pageId: event.pageId,
        pageSize: pageSize,
      );

      log('FinancialInstitutionBloc: Got result from repository');

      result.fold(
        (failure) {
          log('FinancialInstitutionBloc: Fetching institutions failed: ${failure.toString()}');
          emit(
            state.copyWith(
              isLoading: false,
              hasError: true,
              errorMessage: NetworkExceptions.getErrorMessage(failure),
            ),
          );
          // Stop auto-loading on error
          _isLoadingAll = false;
        },
        (institutions) {
          log('FinancialInstitutionBloc: Fetched ${institutions.length} institutions');
          
          // Check if we've reached the end of data - completely empty response
          if (institutions.isEmpty) {
            log('FinancialInstitutionBloc: Received empty response');
            _receivedEmptyResponse = true;
            _isLoadingAll = false; // Stop auto-loading
            
            if (event.pageId == 1) {
              // If first page is empty, no institutions exist
              log('FinancialInstitutionBloc: No institutions found for first page');
              emit(
                state.copyWith(
                  isLoading: false,
                  institutions: [],
                  filteredInstitutions: [],
                  currentPage: event.pageId,
                  hasMorePages: false,
                  hasError: false,
                  errorMessage: '',
                ),
              );
              return;
            } else {
              // For subsequent pages, just mark that there are no more pages
              log('FinancialInstitutionBloc: No more institutions available');
              emit(
                state.copyWith(
                  isLoading: false,
                  hasMorePages: false,
                ),
              );
              return;
            }
          }
          
          // If it's the first page, replace the list; otherwise, append
          final allInstitutions = event.pageId == 1
              ? institutions
              : [...state.institutions, ...institutions];
          
          // Apply the current filter and search
          final filteredInstitutions = _filterInstitutions(
            allInstitutions, 
            state.type, 
            state.searchQuery
          );
          
          log('FinancialInstitutionBloc: Filtered to ${filteredInstitutions.length} institutions');
          
          // Determine if there are more pages to load:
          // 1. If we got fewer items than the page size, we've reached the end
          // 2. Otherwise, assume there are more pages unless we've received an empty response
          final hasMorePages = institutions.length >= pageSize && !_receivedEmptyResponse;
          
          log('FinancialInstitutionBloc: Has more pages: $hasMorePages (got ${institutions.length} of requested $pageSize)');
          
          emit(
            state.copyWith(
              isLoading: false,
              institutions: allInstitutions,
              filteredInstitutions: filteredInstitutions,
              currentPage: event.pageId,
              hasMorePages: hasMorePages,
              hasError: false,
              errorMessage: '',
            ),
          );
          
          // If we didn't get a full page but we didn't get an empty response either,
          // consider this the last page. For safety, update _receivedEmptyResponse
          if (institutions.length < pageSize) {
            log('FinancialInstitutionBloc: Received partial page, setting _receivedEmptyResponse to true');
            _receivedEmptyResponse = true;
            _isLoadingAll = false; // Stop auto-loading
          }
          
          // If we still have more pages and we're auto-loading, load the next page automatically
          if (hasMorePages && _isLoadingAll) {
            log('FinancialInstitutionBloc: Scheduling next page load automatically...');
            // Use a small delay to avoid overwhelming the system with requests
            Future.delayed(const Duration(milliseconds: 100), () {
              _loadNextPageAutomatically();
            });
          }
        },
      );
    } catch (e) {
      log('FinancialInstitutionBloc: Unexpected error: $e');
      emit(
        state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage: 'An unexpected error occurred: $e',
        ),
      );
      // Stop auto-loading on error
      _isLoadingAll = false;
    }
  }

  void _onFilterByType(
      FilterByType event, Emitter<FinancialInstitutionState> emit) {
    log('FinancialInstitutionBloc: Filtering by type: ${event.type}');
    
    final filteredInstitutions = _filterInstitutions(
      state.institutions, 
      event.type, 
      state.searchQuery
    );
    
    log('FinancialInstitutionBloc: Filtered to ${filteredInstitutions.length} institutions');
    
    emit(
      state.copyWith(
        type: event.type,
        filteredInstitutions: filteredInstitutions,
      ),
    );
  }

  void _onSearchQueryChanged(
      SearchQueryChanged event, Emitter<FinancialInstitutionState> emit) {
    log('FinancialInstitutionBloc: Search query changed: ${event.query}');
    
    final filteredInstitutions = _filterInstitutions(
      state.institutions, 
      state.type, 
      event.query
    );
    
    log('FinancialInstitutionBloc: Search filtered to ${filteredInstitutions.length} institutions');
    
    emit(
      state.copyWith(
        searchQuery: event.query,
        filteredInstitutions: filteredInstitutions,
      ),
    );
  }

  Future<void> _onLoadMoreInstitutions(
      LoadMoreInstitutions event, Emitter<FinancialInstitutionState> emit) async {
    log('FinancialInstitutionBloc: Loading more institutions, hasMorePages: ${state.hasMorePages}, isLoading: ${state.isLoading}');
    
    // Always try to load more as long as we're not already loading and 
    // we haven't explicitly determined we're at the end
    if (!state.isLoading && state.hasMorePages) {
      // Use the appropriate page size based on current type
      final pageSize = _getPageSize(state.type);
      final nextPage = state.currentPage + 1;
      
      log('FinancialInstitutionBloc: Loading page $nextPage with page size $pageSize');
      
      add(FetchInstitutions(
        pageId: nextPage,
        pageSize: pageSize,
      ));
    } else {
      log('FinancialInstitutionBloc: Cannot load more - hasMorePages: ${state.hasMorePages}, isLoading: ${state.isLoading}');
    }
  }

  Future<void> _onRefreshInstitutions(
      RefreshInstitutions event, Emitter<FinancialInstitutionState> emit) async {
    log('FinancialInstitutionBloc: Refreshing institutions');
    
    // Reset tracking
    _receivedEmptyResponse = false;
    // Enable auto-loading all pages on refresh
    _isLoadingAll = true;
    
    // Use the appropriate page size based on current type
    final pageSize = _getPageSize(state.type);
    
    add(FetchInstitutions(pageId: 1, pageSize: pageSize));
  }

  // Helper method to filter institutions by type and search query
  List<FinancialInstitution> _filterInstitutions(
      List<FinancialInstitution> institutions,
      FinancialInstitutionType type,
      String query) {
    log('FinancialInstitutionBloc: Filtering institutions - type: $type, query: "$query", total: ${institutions.length}');
    
    // Log all institutions for debugging (limited to avoid excessive logging)
    final loggingLimit = 5;
    for (int i = 0; i < institutions.length && i < loggingLimit; i++) {
      log('Available institution: ${institutions[i].name} (${institutions[i].code}) - type: ${institutions[i].type}');
    }
    if (institutions.length > loggingLimit) {
      log('... and ${institutions.length - loggingLimit} more institutions');
    }
    
    if (institutions.isEmpty) {
      log('FinancialInstitutionBloc: No institutions to filter');
      return [];
    }
    
    // Start with type filtering
    var filteredList = institutions;
    
    // Filter by type if not 'all'
    if (type != FinancialInstitutionType.all) {
      log('FinancialInstitutionBloc: Filtering by type: $type');
      filteredList = institutions.where((institution) {
        // Use try-catch to avoid crashes from unexpected data formats
        try {
          // Simply check the type field from the API data
          if (type == FinancialInstitutionType.bank) {
            final isBank = institution.type.toLowerCase() == 'bank';
            return isBank;
          } 
          else if (type == FinancialInstitutionType.wallet) {
            final isWallet = institution.type.toLowerCase() == 'wallet';
            return isWallet;
          }
        } catch (e) {
          log('FinancialInstitutionBloc: Error filtering institution: $e');
        }
        
        return true;
      }).toList();
      
      log('FinancialInstitutionBloc: After type filtering: ${filteredList.length} institutions');
    }
    
    // Then apply search query filter if query is not empty
    if (query.isNotEmpty) {
      log('FinancialInstitutionBloc: Filtering by query: "$query"');
      final lowerQuery = query.toLowerCase().trim();
      filteredList = filteredList.where((institution) {
        try {
          return institution.name.toLowerCase().contains(lowerQuery) ||
                 institution.code.toLowerCase().contains(lowerQuery) ||
                 (institution.description?.toLowerCase().contains(lowerQuery) ?? false);
        } catch (e) {
          log('FinancialInstitutionBloc: Error filtering institution by query: $e');
          return false;
        }
      }).toList();
      
      log('FinancialInstitutionBloc: After query filtering: ${filteredList.length} institutions');
    }
    
    // If we filtered out everything, log that for debugging
    if (filteredList.isEmpty && institutions.isNotEmpty) {
      log('FinancialInstitutionBloc: Warning: All institutions filtered out. Original count: ${institutions.length}');
    }
    
    return filteredList;
  }
  
  int min(int a, int b) => a < b ? a : b;
} 