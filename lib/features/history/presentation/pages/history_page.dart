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
import 'package:super_app/features/history/domain/entities/transaction.dart';
import 'package:super_app/features/history/domain/entities/transaction_extensions.dart';
import 'package:super_app/features/history/domain/entities/transaction_filter.dart';
import 'package:super_app/features/history/presentation/widgets/filter_button.dart';
import 'package:super_app/features/history/presentation/widgets/transaction_item.dart';
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
    
    // If a specific account ID was passed, use it to fetch transactions
    if (widget.accountId > 0) {
      context.read<TransactionsBloc>().add(TransactionsEvent.accountChanged(accountId: widget.accountId));
    } else {
      // Otherwise, just fetch transactions using the default account
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
      // If we have a specific account ID, use it when refreshing
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
    // If we have a specific account ID passed from main page, use it
    if (widget.accountId > 0) {
      // Show a toast or snackbar indicating we're using the selected account
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
      
      // Ensure we're using this account ID for transactions
      context.read<TransactionsBloc>().add(
        TransactionsEvent.accountChanged(accountId: widget.accountId)
      );
    } else {
      // Otherwise, show account selection dialog - implementation would depend on your app's UI
      _showAccountSelectionDialog();
    }
  }
  
  void _showAccountSelectionDialog() {
    // Get accounts from AccountsBloc
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
    
    // Show dialog with account selection
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
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
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
                    // Close dialog
                    Navigator.of(context).pop();
                    
                    // Set selected account ID in bloc
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
          borderRadius: BorderRadius.circular(12.r),
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
      backgroundColor: Colors.white,
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
          FilterButton(
            icon: Icons.account_balance,
            onPressed: _onFilterByAccount,
          ),
          SizedBox(width: 16.w),
        ],
      ),
      body: Column(
        children: [
          // Transactions list
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
                  // Check if it's a "no account" related error
                  if (state.listErrorMessage.contains('account') || state.listErrorMessage.contains('log in')) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_balance_wallet_outlined,
                              size: 80.sp,
                              color: primaryColor.withOpacity(0.7),
                            ),
                            SizedBox(height: 24.h),
                            Text(
                              'Account Required',
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.sp,
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
                                elevation: 1,
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
                  
                  // For other errors, use the standard error widget
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
                        Icon(
                          Icons.receipt_long,
                          size: 72.sp,
                          color: primaryColor.withOpacity(0.5),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No transactions found',
                          style: GoogleFonts.outfit(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
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
                        ElevatedButton(
                          onPressed: _onRefresh,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 1,
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
                      // Check if we've reached the end of the transactions list
                      if (index >= transactions.length) {
                        return state.hasReachedMax
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Center(
                                child: Text(
                                  'No more transactions',
                                  style: GoogleFonts.outfit(
                                    fontSize: 16.sp,
                                    color: Colors.grey[600],
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
} 