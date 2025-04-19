part of 'financial_institution_bloc.dart';

@freezed
class FinancialInstitutionEvent with _$FinancialInstitutionEvent {
  const factory FinancialInstitutionEvent.fetchInstitutions({
    @Default(1) int pageId,
    @Default(0) int pageSize,
  }) = FetchInstitutions;

  const factory FinancialInstitutionEvent.filterByType({
    required FinancialInstitutionType type,
  }) = FilterByType;

  const factory FinancialInstitutionEvent.searchQueryChanged({
    required String query,
  }) = SearchQueryChanged;

  const factory FinancialInstitutionEvent.loadMoreInstitutions() = LoadMoreInstitutions;

  const factory FinancialInstitutionEvent.refresh() = RefreshInstitutions;
} 