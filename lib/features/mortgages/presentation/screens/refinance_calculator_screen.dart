import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:super_app/core/theme/app_colors.dart';
import 'dart:math';

class RefinanceCalculatorScreen extends StatefulWidget {

  const RefinanceCalculatorScreen({
    Key? key,
    required this.currentLoanBalance,
    required this.currentInterestRate,
    required this.remainingTerm,
    required this.monthlyPayment,
  }) : super(key: key);
  final double currentLoanBalance;
  final double currentInterestRate;
  final int remainingTerm;
  final double monthlyPayment;

  @override
  State<RefinanceCalculatorScreen> createState() => _RefinanceCalculatorScreenState();
}

class _RefinanceCalculatorScreenState extends State<RefinanceCalculatorScreen> {
  final currencyFormat = NumberFormat.currency(
    locale: 'en_ET',
    symbol: 'ETB ',
    decimalDigits: 0,
  );
  
  final _formKey = GlobalKey<FormState>();
  
  // Form values
  double _newInterestRate = 0;
  int _newTerm = 0;
  double _closingCosts = 0;
  
  // Results
  double _newMonthlyPayment = 0;
  double _monthlySavings = 0;
  double _totalSavings = 0;
  int _breakEvenMonths = 0;
  bool _hasCalculated = false;
  
  @override
  void initState() {
    super.initState();
    // Initialize with current values
    _newInterestRate = widget.currentInterestRate - 0.5; // Default to 0.5% lower
    _newTerm = widget.remainingTerm;
    _closingCosts = widget.currentLoanBalance * 0.02; // Estimate 2% closing costs
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Refinance Calculator',
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
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current mortgage summary
            Card(
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
                      'Current Mortgage',
                      style: GoogleFonts.outfit(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _buildSummaryRow('Loan Balance:', currencyFormat.format(widget.currentLoanBalance)),
                    SizedBox(height: 8.h),
                    _buildSummaryRow('Interest Rate:', '${widget.currentInterestRate.toStringAsFixed(2)}%'),
                    SizedBox(height: 8.h),
                    _buildSummaryRow('Remaining Term:', '${widget.remainingTerm} years'),
                    SizedBox(height: 8.h),
                    _buildSummaryRow('Monthly Payment:', currencyFormat.format(widget.monthlyPayment)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            
            // Refinance calculator form
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: BorderSide(color: Colors.grey[200]!),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Loan Details',
                        style: GoogleFonts.outfit(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      
                      // Interest Rate Slider
                      Text(
                        'New Interest Rate: ${_newInterestRate.toStringAsFixed(2)}%',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Slider(
                        value: _newInterestRate,
                        min: 5,
                        max: widget.currentInterestRate,
                        divisions: ((widget.currentInterestRate - 5.0) * 4).round(),
                        label: _newInterestRate.toStringAsFixed(2),
                        activeColor: AppColors.primaryColor,
                        onChanged: (value) {
                          setState(() {
                            _newInterestRate = double.parse(value.toStringAsFixed(2));
                          });
                        },
                      ),
                      SizedBox(height: 16.h),
                      
                      // Loan Term Dropdown
                      Text(
                        'New Loan Term',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      DropdownButtonFormField<int>(
                        value: _newTerm,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        ),
                        items: [15, 20, 25, 30].map((term) {
                          return DropdownMenuItem<int>(
                            value: term,
                            child: Text('$term years'),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _newTerm = value!;
                          });
                        },
                      ),
                      SizedBox(height: 16.h),
                      
                      // Closing Costs
                      Text(
                        'Closing Costs',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        initialValue: currencyFormat.format(_closingCosts).replaceAll('ETB ', ''),
                        decoration: InputDecoration(
                          prefixText: 'ETB ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter closing costs';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _closingCosts = double.tryParse(value.replaceAll(',', '')) ?? 0.0;
                          });
                        },
                      ),
                      SizedBox(height: 24.h),
                      
                      // Calculate Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _calculateRefinance,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            'Calculate Savings',
                            style: GoogleFonts.outfit(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            
            // Results section (only shown after calculation)
            if (_hasCalculated) ...[
              Card(
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
                        'Refinance Results',
                        style: GoogleFonts.outfit(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _buildResultRow(
                        'New Monthly Payment:',
                        currencyFormat.format(_newMonthlyPayment),
                        AppColors.primaryColor,
                      ),
                      SizedBox(height: 8.h),
                      _buildResultRow(
                        'Monthly Savings:',
                        currencyFormat.format(_monthlySavings),
                        Colors.green[700]!,
                      ),
                      SizedBox(height: 8.h),
                      _buildResultRow(
                        'Total Savings:',
                        currencyFormat.format(_totalSavings),
                        Colors.green[700]!,
                      ),
                      SizedBox(height: 8.h),
                      _buildResultRow(
                        'Break-Even Point:',
                        '$_breakEvenMonths months',
                        Colors.orange,
                      ),
                      SizedBox(height: 16.h),
                      
                      // Recommendation
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: _breakEvenMonths < 36 ? Colors.green[50] : Colors.orange[50],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _breakEvenMonths < 36 ? Icons.check_circle : Icons.info,
                              color: _breakEvenMonths < 36 ? Colors.green[700] : Colors.orange,
                              size: 24.sp,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                _breakEvenMonths < 36
                                    ? "This refinance option looks good! You'll break even in less than 3 years."
                                    : 'Consider carefully. It will take over 3 years to recover your closing costs.',
                                style: GoogleFonts.outfit(
                                  fontSize: 14.sp,
                                  color: _breakEvenMonths < 36 ? Colors.green[700] : Colors.orange[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      
                      // Apply for Refinance Button
                      if (_breakEvenMonths < 60) // Only show if it makes financial sense
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to refinance application
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Navigating to refinance application...'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              'Apply for Refinance',
                              style: GoogleFonts.outfit(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  void _calculateRefinance() {
    if (_formKey.currentState!.validate()) {
      // Calculate new monthly payment
      var monthlyRate = _newInterestRate / 100 / 12;
      var totalPayments = _newTerm * 12;
      
      _newMonthlyPayment = widget.currentLoanBalance * 
          (monthlyRate * pow(1 + monthlyRate, totalPayments)) / 
          (pow(1 + monthlyRate, totalPayments) - 1);
      
      // Calculate savings
      _monthlySavings = widget.monthlyPayment - _newMonthlyPayment;
      _totalSavings = (_monthlySavings * totalPayments) - _closingCosts;
      
      // Calculate break-even point
      _breakEvenMonths = (_closingCosts / _monthlySavings).ceil();
      
      setState(() {
        _hasCalculated = true;
      });
    }
  }
  
  Widget _buildSummaryRow(String label, String value) {
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
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
  
  Widget _buildResultRow(String label, String value, Color valueColor) {
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
            color: valueColor,
          ),
        ),
      ],
    );
  }
} 