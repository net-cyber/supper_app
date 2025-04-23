import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:super_app/features/history/domain/entities/transaction.dart';

part 'paginated_transactions.freezed.dart';
part 'paginated_transactions.g.dart';

@freezed
class PaginatedTransactions with _$PaginatedTransactions {
  const factory PaginatedTransactions({
    required List<Transaction> transactions,
    required int totalCount,
    required int currentPage,
    required int pageSize,
    @Default(false) bool hasReachedMax,
  }) = _PaginatedTransactions;

  const PaginatedTransactions._();

  factory PaginatedTransactions.fromJson(Map<String, dynamic> json) =>
      _$PaginatedTransactionsFromJson(json);
      
  bool get isEmpty => transactions.isEmpty;
  bool get isNotEmpty => transactions.isNotEmpty;
  int get pageCount => (totalCount / pageSize).ceil();
  bool get hasNextPage => currentPage < pageCount;
  bool get hasPreviousPage => currentPage > 1;
} 