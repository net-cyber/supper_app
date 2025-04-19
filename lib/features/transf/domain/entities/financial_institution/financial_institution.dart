import 'package:freezed_annotation/freezed_annotation.dart';

part 'financial_institution.freezed.dart';
part 'financial_institution.g.dart';

@freezed
class FinancialInstitution with _$FinancialInstitution {
  const factory FinancialInstitution({
    required String id,
    required String name,
    required String code,
    required String type,
    String? logoUrl,
    String? description,
    @Default(true) bool active,
  }) = _FinancialInstitution;

  factory FinancialInstitution.fromJson(Map<String, dynamic> json) =>
      _$FinancialInstitutionFromJson(json);
} 
