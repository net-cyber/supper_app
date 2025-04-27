import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/utils/local_storage.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_state.dart';
import 'package:super_app/features/history/application/transactions_bloc.dart';
import 'package:super_app/features/history/domain/entities/transaction/transaction.dart';
import 'package:super_app/features/history/domain/entities/transaction_extensions.dart';
import 'package:super_app/core/presentation/widgets/app_loading_indicator.dart';
import 'package:super_app/core/presentation/widgets/app_error_widget.dart';

class TransactionDetailPage extends StatefulWidget {
  final Transaction? transaction;

  const TransactionDetailPage({
    super.key,
    this.transaction,
  });

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.transaction != null) {
      context.read<TransactionsBloc>().add(
            TransactionsEvent.detailSetFromCache(
                transaction: widget.transaction!),
          );

      return TransactionDetailView(
        transaction: widget.transaction!,
      );
    }
    return const TransactionDetailLoadingView();
  }
}

class TransactionDetailLoadingView extends StatelessWidget {
  const TransactionDetailLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Transaction Details',
          style: GoogleFonts.outfit(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<TransactionsBloc, TransactionsState>(
        builder: (context, state) {
          if (state.detailStatus == TransactionsDetailStatus.loading) {
            return const AppLoadingIndicator();
          } else if (state.detailStatus == TransactionsDetailStatus.failure) {
            return AppErrorWidget(
              message: state.detailErrorMessage,
              onRetry: () {
                // Retry logic
              },
            );
          } else if (state.detailStatus == TransactionsDetailStatus.success &&
              state.selectedTransaction != null) {
            return TransactionDetailView(
              transaction: state.selectedTransaction!,
            );
          } else {
            return Center(
              child: Text(
                'No transaction data available.',
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  color: Colors.grey[600],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class TransactionDetailView extends StatefulWidget {
  final Transaction transaction;

  const TransactionDetailView({
    super.key,
    required this.transaction,
  });

  @override
  State<TransactionDetailView> createState() => _TransactionDetailViewState();
}

class _TransactionDetailViewState extends State<TransactionDetailView> {
  String _accountHolderName = 'Account Holder';
  String _accountNumber = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    // Get user data from local storage for name
    final userData = LocalStorage.instance.getUserData();
    if (userData != null && userData.containsKey('full_name')) {
      setState(() {
        _accountHolderName = userData['full_name'] as String;
      });
    }

    // Get accounts from AccountsBloc for account number
    final accountsState = context.read<AccountsBloc>().state;
    if (accountsState.accounts.isNotEmpty) {
      setState(() {
        _accountNumber = accountsState.accounts.first.id.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    // Format transaction date
    final DateFormat dateFormat = DateFormat('MMM dd, yyyy');
    final DateFormat timeFormat = DateFormat('hh:mm a');
    final String formattedDate =
        dateFormat.format(widget.transaction.created_at);
    final String formattedTime =
        timeFormat.format(widget.transaction.created_at);

    return BlocListener<TransactionsBloc, TransactionsState>(
      listenWhen: (previous, current) =>
          previous.isShareInProgress != current.isShareInProgress,
      listener: (context, state) {
        if (state.isShareInProgress) {
          // Could show a loading indicator if needed
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Transaction Details',
            style: GoogleFonts.outfit(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Amount and Date section
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 24.w),
                      child: Column(
                        children: [
                          // Amount with currency
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.transaction.amount.toString(),
                                style: GoogleFonts.outfit(
                                  fontSize: 36.sp,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Padding(
                                padding: EdgeInsets.only(bottom: 6.h),
                                child: Text(
                                  widget.transaction.currency,
                                  style: GoogleFonts.outfit(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          // Date and time
                          Text(
                            "$formattedDate   $formattedTime",
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Transaction Details List with BlocBuilder to get account info
                    BlocBuilder<AccountsBloc, AccountsState>(
                      builder: (context, accountsState) {
                        // Update account info if available from the bloc
                        if (accountsState.accounts.isNotEmpty &&
                            _accountNumber.isEmpty) {
                          _accountNumber =
                              accountsState.accounts.first.id.toString();
                        }

                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Column(
                            children: [
                              _buildDetailRow(
                                  'Transaction Type:',
                                  widget.transaction.transactionTypeDisplay
                                      .toUpperCase()),
                              _buildDetailRow(
                                  'Bank Name:',
                                  widget.transaction.bank_code ??
                                      'Gohe Betoch Bank'),

                              // Show sender or recipient based on transaction direction
                              if (widget.transaction.isOutgoing) ...[
                                _buildDetailRow(
                                    'Sender Name:', _accountHolderName),
                                _buildDetailRow('Sender Account:',
                                    _maskAccountNumber(_accountNumber)),
                                _buildDetailRow(
                                    'Recipient Name:',
                                    widget.transaction.counterparty_name ??
                                        'Not Available'),
                                _buildDetailRow(
                                    'Recipient Account:',
                                    widget.transaction.account_number ??
                                        'Not Available'),
                              ] else ...[
                                _buildDetailRow(
                                    'Sender Name:',
                                    widget.transaction.counterparty_name ??
                                        'Not Available'),
                                _buildDetailRow(
                                    'Sender Account:',
                                    widget.transaction.account_number ??
                                        'Not Available'),
                                _buildDetailRow(
                                    'Recipient Name:', _accountHolderName),
                                _buildDetailRow('Recipient Account:',
                                    _maskAccountNumber(_accountNumber)),
                              ],

                              _buildDetailRow('Transaction Ref:',
                                  widget.transaction.id.toString()),

                              // Add FT Ref if available
                              if (widget.transaction.reference != null)
                                _buildDetailRow(
                                    'FT Ref:',
                                    widget.transaction.reference!.substring(
                                        0,
                                        math.min(
                                            widget
                                                .transaction.reference!.length,
                                            16))),

                              // Fee details
                              _buildDetailRow('Service-Charge:',
                                  '${widget.transaction.currency} ${widget.transaction.transaction_fees ?? 0}'),

                              // Add VAT if applicable
                              if (widget.transaction.transaction_fees != null &&
                                  widget.transaction.transaction_fees! > 0)
                                _buildDetailRow('VAT(15%):',
                                    '${widget.transaction.currency} ${(widget.transaction.transaction_fees! * 0.15).toStringAsFixed(2)}'),

                              _buildDetailRow('Total Amount:',
                                  '${widget.transaction.currency} ${widget.transaction.totalAmount}',
                                  valueColor: primaryColor,
                                  valueFontWeight: FontWeight.bold),

                              // Transaction status with color
                              _buildDetailRow('Transaction Status:',
                                  widget.transaction.status.toUpperCase(),
                                  valueColor: widget.transaction.isCompleted
                                      ? Colors.green
                                      : widget.transaction.isPending
                                          ? Colors.orange
                                          : Colors.red,
                                  valueFontWeight: FontWeight.bold),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),

            // Share Button
            BlocBuilder<TransactionsBloc, TransactionsState>(
              buildWhen: (previous, current) =>
                  previous.isShareInProgress != current.isShareInProgress,
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Container(
                    width: double.infinity,
                    height: 56.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          primaryColor,
                          Color.fromARGB(255, primaryColor.red - 20,
                              primaryColor.green - 20, primaryColor.blue + 30),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: state.isShareInProgress
                            ? null
                            : () => _shareReceipt(),
                        borderRadius: BorderRadius.circular(12.r),
                        child: Center(
                          child: state.isShareInProgress
                              ? SizedBox(
                                  width: 24.w,
                                  height: 24.h,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.share_rounded,
                                      color: Colors.white,
                                      size: 22.sp,
                                    ),
                                    SizedBox(width: 12.w),
                                    Text(
                                      'Share Receipt',
                                      style: GoogleFonts.outfit(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    Color? valueColor,
    FontWeight? valueFontWeight,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140.w,
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                fontWeight: valueFontWeight ?? FontWeight.w600,
                color: valueColor ?? Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _maskAccountNumber(String accountNumber) {
    if (accountNumber.isEmpty) return 'Not Available';
    if (accountNumber.length <= 4) return accountNumber;

    final visiblePart = accountNumber.substring(accountNumber.length - 4);
    final maskedPart = '*' * (accountNumber.length - 4);
    return '$maskedPart$visiblePart';
  }

  void _shareReceipt() {
    try {
      context.read<TransactionsBloc>().add(
            TransactionsEvent.shareReceipt(
              transaction: widget.transaction,
            ),
          );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not share receipt: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
