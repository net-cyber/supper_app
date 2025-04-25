import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/presentation/widgets/app_error_widget.dart';
import 'package:super_app/core/presentation/widgets/app_loading_indicator.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/history/application/transactions_bloc.dart';
import 'package:super_app/features/history/domain/entities/transaction/transaction.dart';
import 'package:super_app/features/history/domain/entities/transaction_extensions.dart';
import 'package:super_app/features/history/domain/entities/transaction_filter/transaction_filter.dart';
import 'package:super_app/features/history/presentation/widgets/filter_button.dart';
import 'package:super_app/features/history/presentation/widgets/transaction_item.dart';
import 'package:super_app/features/history/presentation/widgets/transaction_filter_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:super_app/core/router/route_name.dart';

class HistoryPage extends StatelessWidget {
  final int accountId;
  
  const HistoryPage({super.key, this.accountId = 0});

  @override
  Widget build(BuildContext context) {
    return HistoryView(accountId: accountId);
  }
}

class HistoryView extends StatefulWidget {
  final int accountId;
  
  const HistoryView({super.key, this.accountId = 0});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    
    if (widget.accountId > 0) {
      context.read<TransactionsBloc>().add(TransactionsEvent.accountChanged(accountId: widget.accountId));
    } else {
      context.read<TransactionsBloc>().add(const TransactionsEvent.fetched());
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<TransactionsBloc>().add(const TransactionsEvent.loadMore());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onRefresh() {
    if (widget.accountId > 0) {
      context.read<TransactionsBloc>().add(
        TransactionsEvent.accountChanged(accountId: widget.accountId)
      );
    } else {
      context.read<TransactionsBloc>().add(
        const TransactionsEvent.refreshed()
      );
    }
  }

  void _onFilterByAccount() {
    if (widget.accountId > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Using selected account ID: ${widget.accountId}',
            style: GoogleFonts.outfit(),
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      
      context.read<TransactionsBloc>().add(
        TransactionsEvent.accountChanged(accountId: widget.accountId)
      );
    } else {
      _showAccountSelectionDialog();
    }
  }
  
  void _showAccountSelectionDialog() {
    final accountsState = context.read<AccountsBloc>().state;
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    
    if (accountsState.accounts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No accounts available to select',
            style: GoogleFonts.outfit(),
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Select Account',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: primaryColor,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
        content: SizedBox(
          width: double.maxFinite,
          height: 250.h,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: accountsState.accounts.length,
            itemBuilder: (context, index) {
              final account = accountsState.accounts[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: primaryColor.withOpacity(0.1)),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  title: Text(
                    account.owner,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                  subtitle: Text(
                    'ID: ${account.id}',
                    style: GoogleFonts.outfit(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                trailing: Text(
                  '${account.currency} ${account.balance}',
                    style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: primaryColor,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  
                  context.read<TransactionsBloc>().add(
                    TransactionsEvent.accountChanged(accountId: account.id)
                  );
                },
                ),
              );
            },
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.outfit(
                color: primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transaction History',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: Colors.black,
              ),
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          BlocBuilder<TransactionsBloc, TransactionsState>(
            buildWhen: (previous, current) => previous.filter != current.filter,
            builder: (context, state) {
              final bool hasActiveFilters = state.filter != null;
              
              return Stack(
                children: [
                  FilterButton(
                    icon: Icons.filter_list,
                    onPressed: _showFilterDialog,
                  ),
                  if (hasActiveFilters)
                    Positioned(
                      right: 8.w,
                      top: 8.h,
                      child: Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          SizedBox(width: 8.w),
          FilterButton(
            icon: Icons.account_balance,
            onPressed: _onFilterByAccount,
          ),
          SizedBox(width: 16.w),
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<TransactionsBloc, TransactionsState>(
            buildWhen: (previous, current) => previous.filter != current.filter,
            builder: (context, state) {
              final filter = state.filter;
              
              if (filter == null) {
                return const SizedBox.shrink();
              }
              
              final List<Widget> filterChips = [];
              
              if (filter.type != null) {
                String typeLabel;
                if (filter.type?.value == 'external_transfer') {
                  typeLabel = 'External Transfer';
                } else if (filter.type?.value == 'internal_transfer') {
                  typeLabel = 'Internal Transfer';
                } else {
                  typeLabel = 'Top-up';
                }
                
                filterChips.add(_buildActiveFilterChip(
                  label: typeLabel,
                  onRemove: () => _removeTypeFilter(),
                ));
              }
              
              if (filter.direction != null) {
                filterChips.add(_buildActiveFilterChip(
                  label: filter.direction?.value == 'incoming' 
                      ? 'Incoming' 
                      : 'Outgoing',
                  onRemove: () => _removeDirectionFilter(),
                ));
              }
              
              if (filter.status != null) {
                String statusLabel;
                if (filter.status?.value == 'completed') {
                  statusLabel = 'Completed';
                } else if (filter.status?.value == 'pending') {
                  statusLabel = 'Pending';
                } else {
                  statusLabel = 'Failed';
                }
                
                filterChips.add(_buildActiveFilterChip(
                  label: statusLabel,
                  onRemove: () => _removeStatusFilter(),
                ));
              }
              
              if (filter.startDate != null || filter.endDate != null) {
                final DateFormat dateFormat = DateFormat('MMM d, yy');
                String dateLabel = 'Date: ';
                
                if (filter.startDate != null && filter.endDate != null) {
                  dateLabel += '${dateFormat.format(filter.startDate!)} - ${dateFormat.format(filter.endDate!)}';
                } else if (filter.startDate != null) {
                  dateLabel += 'From ${dateFormat.format(filter.startDate!)}';
                } else if (filter.endDate != null) {
                  dateLabel += 'Until ${dateFormat.format(filter.endDate!)}';
                }
                
                filterChips.add(_buildActiveFilterChip(
                  label: dateLabel,
                  onRemove: () => _removeDateFilters(),
                ));
              }
              
              if (filter.counterpartyName != null && filter.counterpartyName!.isNotEmpty) {
                filterChips.add(_buildActiveFilterChip(
                  label: 'Name: ${filter.counterpartyName}',
                  onRemove: () => _removeCounterpartyFilter(),
                ));
              }
              
              if (filter.minAmount != null || filter.maxAmount != null) {
                String amountLabel = 'Amount: ';
                
                if (filter.minAmount != null && filter.maxAmount != null) {
                  amountLabel += '${filter.minAmount} - ${filter.maxAmount}';
                } else if (filter.minAmount != null) {
                  amountLabel += '≥ ${filter.minAmount}';
                } else if (filter.maxAmount != null) {
                  amountLabel += '≤ ${filter.maxAmount}';
                }
                
                filterChips.add(_buildActiveFilterChip(
                  label: amountLabel,
                  onRemove: () => _removeAmountFilters(),
                ));
              }
              
              if (filterChips.isEmpty) {
                return const SizedBox.shrink();
              }
              
              return Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: primaryColor.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
              boxShadow: [
                BoxShadow(
                      color: primaryColor.withOpacity(0.03),
                  offset: const Offset(0, 2),
                      blurRadius: 3,
                ),
              ],
            ),
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
              children: [
                          Text(
                            'Active Filters:',
                            style: GoogleFonts.outfit(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: primaryColor.withOpacity(0.8),
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: _clearAllFilters,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Clear All',
                              style: GoogleFonts.outfit(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                ),
              ],
            ),
                    ),
                    SizedBox(height: 6.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          for (int i = 0; i < filterChips.length; i++) ...[
                            filterChips[i],
                            if (i < filterChips.length - 1) 
                              SizedBox(width: 8.w),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          
          Expanded(
            child: BlocConsumer<TransactionsBloc, TransactionsState>(
              listenWhen: (previous, current) => 
                previous.listStatus != current.listStatus || 
                previous.listErrorMessage != current.listErrorMessage,
              listener: (context, state) {
                if (state.listStatus == TransactionsListStatus.failure && state.listErrorMessage.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.listErrorMessage,
                        style: GoogleFonts.outfit(),
                      ),
                      backgroundColor: Colors.red[700],
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      margin: EdgeInsets.all(16.r),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state.listStatus == TransactionsListStatus.initial) {
                  return const Center(child: AppLoadingIndicator());
                }
                
                if (state.listStatus == TransactionsListStatus.loading && 
                   (state.paginatedTransactions == null || state.paginatedTransactions!.isEmpty)) {
                  return const Center(child: AppLoadingIndicator());
                }
                
                if (state.listStatus == TransactionsListStatus.failure && 
                   (state.paginatedTransactions == null || state.paginatedTransactions!.isEmpty)) {
                  if (state.listErrorMessage.contains('account') || state.listErrorMessage.contains('log in')) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20.r),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                              Icons.account_balance_wallet_outlined,
                                size: 70.sp,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Text(
                              'Account Required',
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.sp,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 32.w),
                              child: Text(
                                state.listErrorMessage,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.outfit(
                                  fontSize: 14.sp,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            SizedBox(height: 32.h),
                            ElevatedButton(
                              onPressed: () {
                                _onRefresh();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                elevation: 2,
                              ),
                              child: Text(
                                'Refresh',
                                style: GoogleFonts.outfit(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  
                  return Center(
                    child: AppErrorWidget(
                      message: state.listErrorMessage,
                      onRetry: _onRefresh,
                    ),
                  );
                }
                
                final transactions = state.paginatedTransactions?.transactions ?? [];
                
                if (transactions.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20.r),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                          Icons.receipt_long,
                            size: 64.sp,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'No transactions found',
                          style: GoogleFonts.outfit(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Try adjusting your filters or time period',
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 24.h),
                        ElevatedButton.icon(
                          onPressed: _onRefresh,
                          icon: Icon(Icons.refresh, size: 18.sp),
                          label: Text('Refresh'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 2,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                
                return RefreshIndicator(
                  onRefresh: () async => _onRefresh(),
                  color: primaryColor,
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    itemCount: transactions.length + (state.hasReachedMax ? 1 : 1),
                    itemBuilder: (context, index) {
                      if (index >= transactions.length) {
                        return state.hasReachedMax
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Center(
                                child: Text(
                                  'No more transactions',
                                  style: GoogleFonts.outfit(
                                    fontSize: 16.sp,
                                    color: primaryColor.withOpacity(0.7),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Center(
                                child: SizedBox(
                                  width: 24.w,
                                  height: 24.h,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                  ),
                                ),
                              ),
                            );
                      }

                      final transaction = transactions[index];
                      
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: TransactionItem(
                          transaction: transaction,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => TransactionFilterDialog(
        initialFilter: context.read<TransactionsBloc>().state.filter,
      ),
    );
  }
  
  Widget _buildActiveFilterChip({
    required String label,
    required VoidCallback onRemove,
  }) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColor.withOpacity(0.15),
            primaryColor.withOpacity(0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.w, top: 6.h, bottom: 6.h),
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12.sp,
                color: primaryColor,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onRemove,
              child: Padding(
                padding: EdgeInsets.all(6.w),
                child: Icon(
                  Icons.close,
                  size: 16.sp,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _removeTypeFilter() {
    final currentFilter = context.read<TransactionsBloc>().state.filter;
    if (currentFilter == null) return;
    
    final updatedFilter = currentFilter.copyWith(type: null);
    context.read<TransactionsBloc>().add(TransactionsEvent.filtered(filter: updatedFilter));
  }
  
  void _removeDirectionFilter() {
    final currentFilter = context.read<TransactionsBloc>().state.filter;
    if (currentFilter == null) return;
    
    final updatedFilter = currentFilter.copyWith(direction: null);
    context.read<TransactionsBloc>().add(TransactionsEvent.filtered(filter: updatedFilter));
  }
  
  void _removeStatusFilter() {
    final currentFilter = context.read<TransactionsBloc>().state.filter;
    if (currentFilter == null) return;
    
    final updatedFilter = currentFilter.copyWith(status: null);
    context.read<TransactionsBloc>().add(TransactionsEvent.filtered(filter: updatedFilter));
  }
  
  void _removeDateFilters() {
    final currentFilter = context.read<TransactionsBloc>().state.filter;
    if (currentFilter == null) return;
    
    final updatedFilter = currentFilter.copyWith(startDate: null, endDate: null);
    context.read<TransactionsBloc>().add(TransactionsEvent.filtered(filter: updatedFilter));
  }
  
  void _removeCounterpartyFilter() {
    final currentFilter = context.read<TransactionsBloc>().state.filter;
    if (currentFilter == null) return;
    
    final updatedFilter = currentFilter.copyWith(counterpartyName: null);
    context.read<TransactionsBloc>().add(TransactionsEvent.filtered(filter: updatedFilter));
  }
  
  void _removeAmountFilters() {
    final currentFilter = context.read<TransactionsBloc>().state.filter;
    if (currentFilter == null) return;
    
    final updatedFilter = currentFilter.copyWith(minAmount: null, maxAmount: null);
    context.read<TransactionsBloc>().add(TransactionsEvent.filtered(filter: updatedFilter));
  }
  
  void _clearAllFilters() {
    context.read<TransactionsBloc>().add(
      TransactionsEvent.filtered(filter: TransactionFilter()),
    );
  }
} 