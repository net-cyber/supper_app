part of 'financial_institution_bloc.dart';

enum FinancialInstitutionType { bank, wallet, all }

@freezed
class FinancialInstitutionState with _$FinancialInstitutionState {
  const factory FinancialInstitutionState({
    required bool isLoading,
    required List<FinancialInstitution> institutions,
    required List<FinancialInstitution> filteredInstitutions,
    required FinancialInstitutionType type,
    required String searchQuery,
    required int currentPage,
    required int totalPages,
    required bool hasMorePages,
    required String errorMessage,
    required bool hasError,
  }) = _FinancialInstitutionState;

  factory FinancialInstitutionState.initial() => const FinancialInstitutionState(
        isLoading: false,
        institutions: [],
        filteredInstitutions: [],
        type: FinancialInstitutionType.all,
        searchQuery: '',
        currentPage: 1,
        totalPages: 1,
        hasMorePages: false,
        errorMessage: '',
        hasError: false,
      );
} 