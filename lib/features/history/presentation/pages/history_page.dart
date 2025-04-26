import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/presentation/widgets/app_error_widget.dart';
import 'package:super_app/core/presentation/widgets/app_loading_indicator.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/history/application/transactions_bloc.dart';
import 'package:super_app/features/history/domain/entities/transaction/transaction.dart';
import 'package:super_app/features/history/domain/entities/transaction_extensions.dart';
import 'package:super_app/features/history/domain/entities/transaction_filter/transaction_filter.dart';
import 'package:super_app/features/history/domain/entities/transaction_type.dart';
import 'package:super_app/features/history/presentation/widgets/filter_button.dart';
import 'package:super_app/features/history/presentation/widgets/transaction_item.dart';
import 'package:super_app/features/history/presentation/widgets/transaction_filter_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:super_app/core/router/route_name.dart';

/// The main history page that shows transaction history
/// This is a stateless component that uses BlocProvider to handle TransactionsBloc
class HistoryPage extends StatelessWidget {
  final int accountId;
  
  const HistoryPage({super.key, this.accountId = 0});

  @override
  Widget build(BuildContext context) {
    // Use BlocProvider to provide a new TransactionsBloc instance to the widget tree
    // We use BlocProvider.value because the bloc is a singleton managed by dependency injection
    // This prevents the bloc from being closed when the widget is disposed
    final bloc = getIt<TransactionsBloc>();
    
    return BlocProvider.value(
      value: bloc,
      child: _HistoryPageContent(accountId: accountId),
    );
  }
}

/// A wrapper widget that initializes the TransactionsBloc safely
class _HistoryPageContent extends StatefulWidget {
  final int accountId;
  
  const _HistoryPageContent({required this.accountId});
  
  @override
  State<_HistoryPageContent> createState() => _HistoryPageContentState();
}

class _HistoryPageContentState extends State<_HistoryPageContent> {
  bool _shouldPreserveFilters = false;
  static const String _preserveFiltersKey = 'preserve_transaction_filters';
  static const String _lastFilterKey = 'last_transaction_filter';
  
  @override
  void initState() {
    super.initState();
    // Initialize the bloc here, which is safer than in the BlocProvider.create
    _initializeFiltersAndData();
  }
  
  Future<void> _initializeFiltersAndData() async {
    if (!mounted) return;
    
    await _loadFilterPreservationSetting();
    
    final bloc = context.read<TransactionsBloc>();
    
    // Reset any active filters when entering the page, but only if not preserving filters
    if (bloc.state.isFilterActive && !_shouldPreserveFilters) {
      bloc.add(const TransactionsEvent.clearAllFilters());
    } else if (_shouldPreserveFilters) {
      // If we should preserve filters, try to load the last filter
      final savedFilter = await _loadLastAppliedFilter();
      if (savedFilter != null) {
        bloc.add(TransactionsEvent.filtered(filter: savedFilter));
        return; // Don't proceed with regular fetch since we're applying a filter
      }
    }
    
    // Then initialize with the appropriate account or fetch data
    if (widget.accountId > 0) {
      bloc.add(TransactionsEvent.accountChanged(accountId: widget.accountId));
    } else {
      bloc.add(const TransactionsEvent.fetched());
    }
  }
  
  Future<void> _loadFilterPreservationSetting() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _shouldPreserveFilters = prefs.getBool(_preserveFiltersKey) ?? false;
    } catch (e) {
      // In case of error, default to false
      _shouldPreserveFilters = false;
    }
  }
  
  Future<TransactionFilter?> _loadLastAppliedFilter() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final filterString = prefs.getString(_lastFilterKey);
      
      if (filterString == null || filterString.isEmpty) {
        return null;
      }
      
      // Parse the JSON and work with it directly without type casting the map
      final dynamic json = jsonDecode(filterString);
      
      // Extract type
      TransactionType? type;
      final typeValue = json['type']?.toString();
      if (typeValue == 'external_transfer') {
        type = TransactionType.externalTransfer;
      } else if (typeValue == 'internal_transfer') {
        type = TransactionType.internalTransfer;
      } else if (typeValue == 'topup') {
        type = TransactionType.topUp;
      }
      
      // Extract direction
      TransactionDirection? direction;
      final directionValue = json['direction']?.toString();
      if (directionValue == 'incoming') {
        direction = TransactionDirection.incoming;
      } else if (directionValue == 'outgoing') {
        direction = TransactionDirection.outgoing;
      }
      
      // Extract status
      TransactionStatus? status;
      final statusValue = json['status']?.toString();
      if (statusValue == 'completed') {
        status = TransactionStatus.completed;
      } else if (statusValue == 'pending') {
        status = TransactionStatus.pending;
      } else if (statusValue == 'failed') {
        status = TransactionStatus.failed;
      }
      
      // Extract dates
      DateTime? startDate, endDate;
      if (json['startDate'] is int) {
        startDate = DateTime.fromMillisecondsSinceEpoch(json['startDate'] as int);
      }
      if (json['endDate'] is int) {
        endDate = DateTime.fromMillisecondsSinceEpoch(json['endDate'] as int);
      }
      
      // Extract other fields
      String? counterpartyName = json['counterpartyName']?.toString();
      
      double? minAmount;
      if (json['minAmount'] != null) {
        minAmount = double.tryParse(json['minAmount'].toString());
      }
      
      double? maxAmount;
      if (json['maxAmount'] != null) {
        maxAmount = double.tryParse(json['maxAmount'].toString());
      }
      
      // Create and return the filter
      return TransactionFilter(
        type: type,
        direction: direction,
        status: status,
        startDate: startDate,
        endDate: endDate,
        counterpartyName: counterpartyName,
        minAmount: minAmount,
        maxAmount: maxAmount,
      );
    } catch (e) {
      // Return null in case of any error
      return null;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return const HistoryView();
  }
}

/// The main view for transaction history
/// Receives TransactionsBloc via BlocProvider
class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      try {
        context.read<TransactionsBloc>().add(const TransactionsEvent.scrolledToBottom());
      } catch (e) {
        // Silently ignore errors when adding the event
        // This could happen if the bloc is closed or not available
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onRefresh() {
    try {
      context.read<TransactionsBloc>().add(const TransactionsEvent.refreshed());
    } catch (e) {
      // Provide feedback if refresh fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Unable to refresh. Please try again.',
            style: GoogleFonts.outfit(),
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _onFilterByAccount() {
    try {
      final bloc = context.read<TransactionsBloc>();
      final state = bloc.state;
      
      if (state.accountId > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Using selected account ID: ${state.accountId}',
              style: GoogleFonts.outfit(),
            ),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
        
        bloc.add(TransactionsEvent.accountChanged(accountId: state.accountId));
      } else {
        bloc.add(const TransactionsEvent.openAccountSelection());
      }
    } catch (e) {
      // Provide feedback if account filtering fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Unable to filter by account. Please try again.',
            style: GoogleFonts.outfit(),
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
  
  void _showAccountSelectionDialog() {
    final accountsState = context.read<AccountsBloc>().state;
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final transactionsBloc = context.read<TransactionsBloc>();
    
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
                  transactionsBloc.accountSelectorClosed();
                  
                  transactionsBloc.add(
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
            onPressed: () {
              Navigator.of(context).pop();
              transactionsBloc.accountSelectorClosed();
            },
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

    return BlocListener<TransactionsBloc, TransactionsState>(
      listenWhen: (previous, current) => 
        previous.shouldOpenAccountSelector != current.shouldOpenAccountSelector,
      listener: (context, state) {
        if (state.shouldOpenAccountSelector) {
          _showAccountSelectionDialog();
        }
      },
      child: Scaffold(
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
              buildWhen: (previous, current) => previous.isFilterActive != current.isFilterActive,
            builder: (context, state) {
              return Stack(
                children: [
                  FilterButton(
                    icon: Icons.filter_list,
                    onPressed: _showFilterDialog,
                  ),
                    if (state.isFilterActive)
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
            BlocBuilder<TransactionsBloc, TransactionsState>(
              buildWhen: (previous, current) => previous.isFilterActive != current.isFilterActive,
              builder: (context, state) {
                if (!state.isFilterActive) {
                  return const SizedBox.shrink();
                }
                return FilterButton(
                  icon: Icons.clear_all,
                  onPressed: () {
                    try {
                      context.read<TransactionsBloc>().add(
                        const TransactionsEvent.clearAllFilters()
                      );
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'All filters cleared',
                            style: GoogleFonts.outfit(),
                          ),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    } catch (e) {
                      // Handle error
                    }
                  },
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
              buildWhen: (previous, current) => 
                previous.activeFilterLabels != current.activeFilterLabels || 
                previous.isFilterActive != current.isFilterActive,
            builder: (context, state) {
                if (!state.isFilterActive || state.activeFilterLabels.isEmpty) {
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
                              onPressed: () => context.read<TransactionsBloc>().add(
                                const TransactionsEvent.clearAllFilters()
                              ),
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
                            for (int i = 0; i < state.activeFilterLabels.length; i++) ...[
                              _buildActiveFilterChip(
                                filterLabel: state.activeFilterLabels[i],
                              ),
                              if (i < state.activeFilterLabels.length - 1) 
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
                                onPressed: _onRefresh,
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
      ),
    );
  }

  void _showFilterDialog() {
    try {
      final transactionsBloc = context.read<TransactionsBloc>();
      
      // Create a copy of the current filter to pass to the dialog
      final currentFilter = transactionsBloc.state.filter;
      
      showDialog(
        context: context,
        builder: (dialogContext) => TransactionFilterDialog(
          initialFilter: currentFilter,
          showFilterPreservationOption: true,
        ),
      );
    } catch (e) {
      // If we can't access the bloc, create a new dialog without initial filter
    showDialog(
      context: context,
        builder: (dialogContext) => const TransactionFilterDialog(
          showFilterPreservationOption: true,
      ),
    );
    }
  }
  
  Widget _buildActiveFilterChip({
    required FilterLabel filterLabel,
  }) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final transactionsBloc = context.read<TransactionsBloc>();
    
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
              filterLabel.label,
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
              onTap: () {
                try {
                  switch (filterLabel.type) {
                    case FilterLabelType.type:
                      transactionsBloc.add(const TransactionsEvent.removeFilterType());
                      break;
                    case FilterLabelType.direction:
                      transactionsBloc.add(const TransactionsEvent.removeFilterDirection());
                      break;
                    case FilterLabelType.status:
                      transactionsBloc.add(const TransactionsEvent.removeFilterStatus());
                      break;
                    case FilterLabelType.dates:
                      transactionsBloc.add(const TransactionsEvent.removeFilterDates());
                      break;
                    case FilterLabelType.counterparty:
                      transactionsBloc.add(const TransactionsEvent.removeFilterCounterparty());
                      break;
                    case FilterLabelType.amounts:
                      transactionsBloc.add(const TransactionsEvent.removeFilterAmounts());
                      break;
                  }
                } catch (e) {
                  // Silently ignore errors when removing filters
                  // This could happen if the bloc is closed or not available
                }
              },
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
} 