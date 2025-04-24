import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final primaryColor = theme.colorScheme.primary;
    final isOutgoing = transaction.isOutgoing;
    
    // Format the date and time strings
    final dateString = DateFormat('MMM dd, yyyy').format(transaction.created_at);
    final timeString = DateFormat('hh:mm a').format(transaction.created_at);
    final dateTimeString = '$dateString - $timeString';
    
    // Format the amount string with proper currency formatting
    final currencyFormatter = NumberFormat.currency(
      symbol: transaction.currency + ' ',
      decimalDigits: 2,
    );
    final amount = transaction.amount;
    final formattedAmount = isOutgoing 
        ? '- ${currencyFormatter.format(amount)}'
        : '+ ${currencyFormatter.format(amount)}';

    // Status indicator
    final statusColor = transaction.isCompleted 
        ? Colors.green 
        : transaction.isPending 
          ? Colors.orange 
          : Colors.red;

    // Get transaction icon based on direction (not type)
    IconData transactionIcon;
    Color iconColor;
    
    if (isOutgoing) {
      // Outgoing transaction
      transactionIcon = Icons.north_east; // Diagonal up-right arrow
      iconColor = Colors.red;
    } else {
      // Incoming transaction
      transactionIcon = Icons.south_west; // Diagonal down-left arrow
      iconColor = Colors.green;
    }

    return GestureDetector(
      onTap: () {
        // Navigate to transaction detail page
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
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Transaction direction icon
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  transactionIcon,
                  color: iconColor,
                  size: 18.w,
                ),
              ),
              SizedBox(width: 12.w),
              
              // Transaction details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            transaction.counterparty_name ?? 'TopUp',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontSize: 17.sp,
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        // Status indicator
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w, 
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            transaction.status.toUpperCase(),
                            style: GoogleFonts.outfit(
                              color: statusColor,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Transaction type and reference
                        Expanded(
                          child: Text(
                            transaction.reference != null && transaction.reference!.isNotEmpty
                                ? '${transaction.transactionTypeDisplay} • Ref: ${transaction.reference}'
                                : transaction.transactionTypeDisplay,
                            style: GoogleFonts.outfit(
                              color: Colors.grey[600],
                              fontSize: 14.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    // Date and time
                    Text(
                      dateTimeString,
                      style: GoogleFonts.outfit(
                        color: Colors.grey[500],
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    // Amount
                    Text(
                      formattedAmount,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp,
                        color: isOutgoing 
                            ? Colors.red[700]
                            : Colors.green[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 