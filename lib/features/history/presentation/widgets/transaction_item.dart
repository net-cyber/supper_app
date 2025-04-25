import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/features/history/domain/entities/transaction/transaction.dart';
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

    // Status indicator using theme color variations
    final statusColor = transaction.isCompleted 
        ? Colors.green[600] 
        : transaction.isPending 
          ? primaryColor 
          : Colors.red[700];

    // Get transaction icon based on direction (not type)
    IconData transactionIcon;
    Color iconColor;
    
    if (isOutgoing) {
      // Outgoing transaction
      transactionIcon = Icons.north_east; // Diagonal up-right arrow
      iconColor = primaryColor;
    } else {
      // Incoming transaction
      transactionIcon = Icons.south_west; // Diagonal down-left arrow
      iconColor = primaryColor;
    }

    // Get the bank display text
    String bankDisplayText = _getBankDisplayText();

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
          border: Border.all(color: primaryColor.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Transaction direction icon with gradient background
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor.withOpacity(0.2),
                      primaryColor.withOpacity(0.1),
                    ],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: primaryColor.withOpacity(0.15),
                    width: 1,
                  ),
                ),
                child: Icon(
                  transactionIcon,
                  color: isOutgoing ? primaryColor.withOpacity(0.8) : Colors.green[600],
                  size: 18.w,
                ),
              ),
              SizedBox(width: 14.w),
              
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
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        // Status indicator with rounded design
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w, 
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor!.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(
                              color: statusColor.withOpacity(0.3),
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            transaction.status.toUpperCase(),
                            style: GoogleFonts.outfit(
                              color: statusColor,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Bank name display with different rules for internal vs external transfers
                        Expanded(
                          child: Text(
                            bankDisplayText,
                            style: GoogleFonts.outfit(
                              color: Colors.grey[700],
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    // Date and time with reference (if available)
                    Row(
                      children: [
                        Text(
                          dateTimeString,
                          style: GoogleFonts.outfit(
                            color: Colors.grey[500],
                            fontSize: 12.sp,
                          ),
                        ),
                        if (transaction.reference != null && transaction.reference!.isNotEmpty) ...[
                          Text(
                            " • ",
                            style: GoogleFonts.outfit(
                              color: Colors.grey[400],
                              fontSize: 12.sp,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Ref: ${transaction.reference}',
                              style: GoogleFonts.outfit(
                                color: Colors.grey[500],
                                fontSize: 12.sp,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 6.h),
                    // Amount with improved styling
                    Text(
                      formattedAmount,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: isOutgoing 
                            ? primaryColor
                            : Colors.green[600],
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

  // Helper method to get the bank display text based on transaction type
  String _getBankDisplayText() {
    // For internal transfers, show "Gohe Betoch Bank"
    if (transaction.type == 'internal_transfer') {
      return "Gohe Betoch Bank";
    }
    
    // For external transfers with bank code, show just the bank name
    if (transaction.bank_code != null && transaction.bank_code!.isNotEmpty) {
      return transaction.bank_code!;
    }
    
    // Fallback for other cases
    return transaction.isOutgoing ? "Sent" : "Received";
  }
} 