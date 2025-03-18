import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:super_app/core/theme/app_colors.dart';
import 'package:super_app/features/mortgages/presentation/screens/amortization_schedule_screen.dart';
import 'package:super_app/features/mortgages/presentation/screens/mortgage_management_screen.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MortgageApprovalScreen extends StatefulWidget {
  final String applicationId;
  final double approvedAmount;
  final double interestRate;
  final int loanTerm;

  const MortgageApprovalScreen({
    Key? key,
    required this.applicationId,
    required this.approvedAmount,
    required this.interestRate,
    required this.loanTerm,
  }) : super(key: key);

  @override
  State<MortgageApprovalScreen> createState() => _MortgageApprovalScreenState();
}

class _MortgageApprovalScreenState extends State<MortgageApprovalScreen> {
  final currencyFormat = NumberFormat.currency(
    locale: 'en_ET',
    symbol: 'ETB ',
    decimalDigits: 0,
  );
  
  // Mock data for closing process steps
  final List<Map<String, dynamic>> _closingSteps = [
    {
      'title': 'Loan Approval',
      'description': 'Your mortgage application has been approved',
      'status': 'completed',
      'date': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'title': 'Property Inspection',
      'description': 'Schedule a professional inspection of the property',
      'status': 'current',
      'date': DateTime.now().add(const Duration(days: 5)),
    },
    {
      'title': 'Title Search & Insurance',
      'description': 'Verify property ownership and obtain title insurance',
      'status': 'pending',
      'date': DateTime.now().add(const Duration(days: 10)),
    },
    {
      'title': 'Final Loan Approval',
      'description': 'Final review of all documents and conditions',
      'status': 'pending',
      'date': DateTime.now().add(const Duration(days: 15)),
    },
    {
      'title': 'Closing Day',
      'description': 'Sign final documents and receive property keys',
      'status': 'pending',
      'date': DateTime.now().add(const Duration(days: 20)),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Mortgage Approval',
          style: GoogleFonts.outfit(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Congratulations banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.celebration,
                    color: Colors.white,
                    size: 48.sp,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Congratulations!',
                    style: GoogleFonts.outfit(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Your mortgage has been approved',
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            // Loan details card
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(color: Colors.grey[200]!),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Loan Details',
                        style: GoogleFonts.outfit(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _buildLoanDetailRow(
                        'Approved Amount:',
                        currencyFormat.format(widget.approvedAmount),
                      ),
                      SizedBox(height: 8.h),
                      _buildLoanDetailRow(
                        'Interest Rate:',
                        '${widget.interestRate}%',
                      ),
                      SizedBox(height: 8.h),
                      _buildLoanDetailRow(
                        'Loan Term:',
                        '${widget.loanTerm} years',
                      ),
                      SizedBox(height: 8.h),
                      _buildLoanDetailRow(
                        'Monthly Payment:',
                        currencyFormat.format(_calculateMonthlyPayment()),
                        isHighlighted: true,
                      ),
                      SizedBox(height: 16.h),
                      Divider(color: Colors.grey[200]),
                      SizedBox(height: 16.h),
                      _buildLoanDetailRow(
                        'Application ID:',
                        widget.applicationId,
                      ),
                      SizedBox(height: 8.h),
                      _buildLoanDetailRow(
                        'Approval Date:',
                        DateFormat('MMMM d, yyyy').format(DateTime.now()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Next steps section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Closing Process',
                style: GoogleFonts.outfit(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            _buildClosingTimeline(),
            SizedBox(height: 24.h),
            
            // Action buttons
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _schedulePropertyInspection();
                      },
                      icon: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                      label: Text(
                        'Schedule Property Inspection',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _viewPaymentHistory();
                      },
                      icon: Icon(
                        Icons.history_outlined,
                        color: AppColors.primaryColor,
                        size: 20.sp,
                      ),
                      label: Text(
                        'View Payment History',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        side: BorderSide(color: AppColors.primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _viewAmortizationSchedule();
                      },
                      icon: Icon(
                        Icons.table_chart_outlined,
                        color: AppColors.primaryColor,
                        size: 20.sp,
                      ),
                      label: Text(
                        'View Amortization Schedule',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        side: BorderSide(color: AppColors.primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _downloadApprovalLetter();
                      },
                      icon: Icon(
                        Icons.download_outlined,
                        color: Colors.black87,
                        size: 20.sp,
                      ),
                      label: Text(
                        'Download Approval Letter',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        side: BorderSide(color: Colors.grey[400]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _viewAmortizationSchedule() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AmortizationScheduleScreen(
        loanAmount: widget.approvedAmount,
        interestRate: widget.interestRate,
        loanTerm: widget.loanTerm,
        startDate: DateTime.now(),
        monthlyPayment: _calculateMonthlyPayment(),
      ),
    ),
  );
}
  
  Widget _buildLoanDetailRow(String label, String value, {bool isHighlighted = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: isHighlighted ? AppColors.primaryColor : Colors.black87,
          ),
        ),
      ],
    );
  }
  
  Widget _buildClosingTimeline() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: List.generate(_closingSteps.length, (index) {
          final step = _closingSteps[index];
          final isFirst = index == 0;
          final isLast = index == _closingSteps.length - 1;
          final isCompleted = step['status'] == 'completed';
          final isCurrent = step['status'] == 'current';
          
          Color getIndicatorColor() {
            if (isCompleted) return Colors.green;
            if (isCurrent) return AppColors.primaryColor;
            return Colors.grey[400]!;
          }
          
          return TimelineTile(
            isFirst: isFirst,
            isLast: isLast,
            beforeLineStyle: LineStyle(
              color: index > 0 && _closingSteps[index - 1]['status'] == 'completed' 
                  ? Colors.green 
                  : Colors.grey[300]!,
              thickness: 2,
            ),
            afterLineStyle: LineStyle(
              color: isCompleted ? Colors.green : Colors.grey[300]!,
              thickness: 2,
            ),
            indicatorStyle: IndicatorStyle(
              width: 24.w,
              height: 24.w,
              indicator: Container(
                decoration: BoxDecoration(
                  color: getIndicatorColor(),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    isCompleted ? Icons.check : Icons.circle,
                    color: Colors.white,
                    size: 14.sp,
                  ),
                ),
              ),
            ),
            endChild: Container(
              padding: EdgeInsets.only(
                left: 16.w,
                top: 16.h,
                bottom: 16.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['title'] as String,
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isCurrent ? AppColors.primaryColor : Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    step['description'] as String ,
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    DateFormat('MMMM d, yyyy').format(step['date'] as DateTime),
                    style: GoogleFonts.outfit(
                      fontSize: 12.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
  
  double _calculateMonthlyPayment() {
    // P = L[c(1 + c)^n]/[(1 + c)^n - 1]
    // where L = loan amount, c = monthly interest rate, n = number of payments
    double monthlyRate = widget.interestRate / 100 / 12;
    int totalPayments = widget.loanTerm * 12;
    
    double monthlyPayment = widget.approvedAmount * 
        (monthlyRate * pow(1 + monthlyRate, totalPayments)) / 
        (pow(1 + monthlyRate, totalPayments) - 1);
    
    return monthlyPayment;
  }
  
  void _schedulePropertyInspection() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Schedule Inspection',
          style: GoogleFonts.outfit(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select a date and time for your property inspection:',
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 16.h),
            // Date picker would go here in a real implementation
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 20.sp,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    DateFormat('MMMM d, yyyy').format(
                      DateTime.now().add(const Duration(days: 3)),
                    ),
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            // Time picker would go here in a real implementation
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 20.sp,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '10:00 AM',
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Property inspection scheduled successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Confirm',
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _viewPaymentHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MortgageManagementScreen(
          mortgageId: widget.applicationId,
          loanAmount: widget.approvedAmount,
          interestRate: widget.interestRate,
          loanTerm: widget.loanTerm,
          startDate: DateTime.now(),
        ),
      ),
    );
    // // Navigate to amortization schedule screen
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text('Navigating to amortization schedule...'),
    //     duration: Duration(seconds: 2),
    //   ),
    // );
  }
  
  void _downloadApprovalLetter() {
    // Download approval letter
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Downloading approval letter...'),
        duration: Duration(seconds: 2),
      ),
    );
  }
} 