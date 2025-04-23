import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/features/history/application/detail/bloc/transaction_detail_bloc.dart';
import 'package:super_app/features/history/domain/entities/transaction.dart';
import 'package:super_app/features/history/domain/entities/transaction_extensions.dart';

class TransactionDetailPage extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailPage({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TransactionDetailBloc>()
        ..add(TransactionDetailSetFromCache(transaction: transaction)),
      child: const TransactionDetailView(),
    );
  }
}

class TransactionDetailView extends StatelessWidget {
  const TransactionDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<TransactionDetailBloc, TransactionDetailState>(
      builder: (context, state) {
        if (state.status == TransactionDetailStatus.loading) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Transaction Details'),
              centerTitle: false,
              backgroundColor: Colors.grey[100],
              elevation: 0,
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == TransactionDetailStatus.failure) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Transaction Details'),
              centerTitle: false,
              backgroundColor: Colors.grey[100],
              elevation: 0,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.errorMessage}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            ),
          );
        }

        final transaction = state.transaction!;
        
        // Format created_at date
        final String formattedDate = DateFormat('MMM dd, yyyy · hh:mm a').format(transaction.created_at);

        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            title: const Text(
              'Transaction Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: false,
            backgroundColor: Colors.grey[100],
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Transaction Status and Amount
                  _buildStatusCard(context, theme, transaction),
                  
                  SizedBox(height: 24.h),
                  
                  // Transaction Details
                  _buildDetailsSection(context, theme, formattedDate, transaction),
                  
                  SizedBox(height: 24.h),
                  
                  // Amount Breakdown
                  _buildAmountSection(context, theme, transaction),
                  
                  SizedBox(height: 24.h),
                  
                  // Recipient Details
                  _buildRecipientSection(context, theme, transaction),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusCard(BuildContext context, ThemeData theme, Transaction transaction) {
    final isCompleted = transaction.isCompleted;
    final statusColor = isCompleted ? Colors.green : Colors.orange;
    final isOutgoing = transaction.isOutgoing;
    final amountPrefix = isOutgoing ? '- ' : '+ ';
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Status Indicator
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              transaction.status.toUpperCase(),
              style: theme.textTheme.bodySmall?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Amount
          Text(
            '$amountPrefix${transaction.currency} ${transaction.amount}',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          
          SizedBox(height: 8.h),
          
          // Reference
          Text(
            'Reference: ${transaction.reference ?? "N/A"}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context, ThemeData theme, String formattedDate, Transaction transaction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transaction Details',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildDetailItem(
                context,
                'Transaction Type',
                transaction.transactionTypeDisplay,
                showDivider: true,
              ),
              _buildDetailItem(
                context,
                'Date & Time',
                formattedDate,
                showDivider: true,
              ),
              _buildDetailItem(
                context,
                'Transaction ID',
                transaction.id.toString(),
                showDivider: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAmountSection(BuildContext context, ThemeData theme, Transaction transaction) {
    final totalAmount = transaction.totalAmount;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildDetailItem(
                context,
                'Amount',
                '${transaction.currency} ${transaction.amount}',
                showDivider: true,
              ),
              _buildDetailItem(
                context,
                'Transaction Fee',
                '${transaction.currency} ${transaction.transaction_fees ?? 0}',
                showDivider: true,
              ),
              _buildDetailItem(
                context,
                'Total Amount',
                '${transaction.currency} ${totalAmount}',
                showDivider: false,
                isTotal: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecipientSection(BuildContext context, ThemeData theme, Transaction transaction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          transaction.isOutgoing ? 'Recipient Details' : 'Sender Details',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildDetailItem(
                context,
                transaction.isOutgoing ? 'Recipient Name' : 'Sender Name',
                transaction.counterparty_name ?? 'Not Available',
                showDivider: true,
              ),
              _buildDetailItem(
                context,
                'Bank',
                transaction.bank_code ?? 'Not Available',
                showDivider: true,
              ),
              _buildDetailItem(
                context,
                'Account Number',
                transaction.account_number ?? 'Not Available',
                showDivider: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(
    BuildContext context,
    String label,
    String value, {
    bool showDivider = true,
    bool isTotal = false,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14.sp,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  fontSize: isTotal ? 16.sp : 14.sp,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[200],
          ),
      ],
    );
  }
} 