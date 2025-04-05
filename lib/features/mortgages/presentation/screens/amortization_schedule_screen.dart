import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:super_app/core/theme/app_colors.dart';
import 'dart:math';

class AmortizationScheduleScreen extends StatefulWidget {

  const AmortizationScheduleScreen({
    Key? key,
    required this.loanAmount,
    required this.interestRate,
    required this.loanTerm,
    required this.startDate,
    required this.monthlyPayment,
  }) : super(key: key);
  final double loanAmount;
  final double interestRate;
  final int loanTerm;
  final DateTime startDate;
  final double monthlyPayment;

  @override
  State<AmortizationScheduleScreen> createState() => _AmortizationScheduleScreenState();
}

class _AmortizationScheduleScreenState extends State<AmortizationScheduleScreen> {
  final currencyFormat = NumberFormat.currency(
    locale: 'en_ET',
    symbol: 'ETB ',
    decimalDigits: 0,
  );
  
  late List<Map<String, dynamic>> _amortizationSchedule;
  int _currentYear = 1;
  
  @override
  void initState() {
    super.initState();
    _generateAmortizationSchedule();
  }
  
  void _generateAmortizationSchedule() {
    _amortizationSchedule = [];
    
    var balance = widget.loanAmount;
    final monthlyRate = widget.interestRate / 100 / 12;
    final totalPayments = widget.loanTerm * 12;
    
    for (var i = 1; i <= totalPayments; i++) {
      var interestPayment = balance * monthlyRate;
      var principalPayment = widget.monthlyPayment - interestPayment;
      
      // Handle final payment rounding issues
      if (i == totalPayments) {
        principalPayment = balance;
        interestPayment = widget.monthlyPayment - principalPayment;
      }
      
      balance -= principalPayment;
      if (balance < 0) balance = 0;
      
      final paymentDate = DateTime(
        widget.startDate.year,
        widget.startDate.month + i - 1,
        widget.startDate.day,
      );
      
      _amortizationSchedule.add({
        'paymentNumber': i,
        'date': paymentDate,
        'payment': widget.monthlyPayment,
        'principal': principalPayment,
        'interest': interestPayment,
        'balance': balance,
        'year': ((i - 1) ~/ 12) + 1,
      });
    }
  }
  
  List<Map<String, dynamic>> _getPaymentsForYear(int year) {
    return _amortizationSchedule.where((payment) => payment['year'] == year).toList();
  }
  
  @override
  Widget build(BuildContext context) {
    final paymentsForCurrentYear = _getPaymentsForYear(_currentYear);
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Amortization Schedule',
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
      body: Column(
        children: [
          // Year selector
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: 20.sp),
                  onPressed: _currentYear > 1
                      ? () => setState(() => _currentYear--)
                      : null,
                  color: _currentYear > 1 ? Colors.black87 : Colors.grey[400],
                ),
                Text(
                  'Year $_currentYear of ${widget.loanTerm}',
                  style: GoogleFonts.outfit(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, size: 20.sp),
                  onPressed: _currentYear < widget.loanTerm
                      ? () => setState(() => _currentYear++)
                      : null,
                  color: _currentYear < widget.loanTerm ? Colors.black87 : Colors.grey[400],
                ),
              ],
            ),
          ),
          
          // Year summary
          Container(
            padding: EdgeInsets.all(16.w),
            color: AppColors.primaryColor.withOpacity(0.1),
            child: Row(
              children: [
                Expanded(
                  child: _buildYearSummaryItem(
                    'Principal',
                    paymentsForCurrentYear.fold<double>(
                      0, (sum, payment) => sum + (payment['principal'] as double),),
                    AppColors.primaryColor,
                  ),
                ),
                Expanded(
                  child: _buildYearSummaryItem(
                    'Interest',
                    paymentsForCurrentYear.fold<double>(
                      0, (sum, payment) => sum + (payment['interest'] as double),),
                    Colors.orange,
                  ),
                ),
                Expanded(
                  child: _buildYearSummaryItem(
                    'Total Paid',
                    paymentsForCurrentYear.fold<double>(
                      0, (sum, payment) => sum + (payment['payment'] as double),),
                    Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          
          // Column headers
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                SizedBox(
                  width: 40.w,
                  child: Text(
                    '#',
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                SizedBox(
                  width: 80.w,
                  child: Text(
                    'Date',
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Principal',
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Interest',
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Balance',
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
          
          // Payment list
          Expanded(
            child: ListView.builder(
              itemCount: paymentsForCurrentYear.length,
              itemBuilder: (context, index) {
                final payment = paymentsForCurrentYear[index];
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.white : Colors.grey[50],
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[200]!),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40.w,
                        child: Text(
                          payment['paymentNumber'].toString(),
                          style: GoogleFonts.outfit(
                            fontSize: 14.sp,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80.w,
                        child: Text(
                          DateFormat('MMM yyyy').format(payment['date'] as DateTime),
                          style: GoogleFonts.outfit(
                            fontSize: 14.sp,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          currencyFormat.format(payment['principal']),
                          style: GoogleFonts.outfit(
                            fontSize: 14.sp,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          currencyFormat.format(payment['interest']),
                          style: GoogleFonts.outfit(
                            fontSize: 14.sp,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          currencyFormat.format(payment['balance']),
                          style: GoogleFonts.outfit(
                            fontSize: 14.sp,
                            color: Colors.grey[800],
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildYearSummaryItem(String label, double amount, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          currencyFormat.format(amount),
          style: GoogleFonts.outfit(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
} 