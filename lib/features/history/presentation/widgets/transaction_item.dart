import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:super_app/features/history/domain/entities/transaction.dart';
import 'package:super_app/features/history/domain/entities/transaction_extensions.dart';
import 'package:super_app/features/history/presentation/pages/transaction_detail_page.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionItem({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOutgoing = transaction.isOutgoing;
    
    // Format the date string
    final dateString = DateFormat('MM/dd/yyyy').format(transaction.created_at);
    
    // Format the amount string
    final amountString = transaction.formattedAmount;

    return GestureDetector(
      onTap: () {
        // Using Navigate.push for now since we aren't using GoRouter with named routes for transaction details
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetailPage(
              transaction: transaction,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Arrow icon showing direction
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: isOutgoing ? Colors.pink[50] : Colors.green[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isOutgoing ? Icons.arrow_outward : Icons.arrow_downward,
                  color: isOutgoing ? Colors.pink[400] : Colors.green[400],
                  size: 20.w,
                ),
              ),
              SizedBox(width: 12.w),
              
              // Transaction details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.counterparty_name ?? 'Unknown',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      transaction.transactionTypeDisplay,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Amount and date
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    amountString,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isOutgoing ? Colors.black : Colors.green,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    dateString,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 