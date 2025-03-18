import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:super_app/core/theme/app_colors.dart';
import 'dart:math';
import 'package:pie_chart/pie_chart.dart';
import 'package:super_app/features/mortgages/presentation/screens/amortization_schedule_screen.dart';
import 'package:super_app/features/mortgages/presentation/screens/property_value_screen.dart';
import 'package:super_app/features/mortgages/presentation/screens/refinance_calculator_screen.dart';

class MortgageManagementScreen extends StatefulWidget {
  final String mortgageId;
  final double loanAmount;
  final double interestRate;
  final int loanTerm;
  final DateTime startDate;

  const MortgageManagementScreen({
    Key? key,
    required this.mortgageId,
    required this.loanAmount,
    required this.interestRate,
    required this.loanTerm,
    required this.startDate,
  }) : super(key: key);

  @override
  State<MortgageManagementScreen> createState() => _MortgageManagementScreenState();
}

class _MortgageManagementScreenState extends State<MortgageManagementScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final currencyFormat = NumberFormat.currency(
    locale: 'en_ET',
    symbol: 'ETB ',
    decimalDigits: 0,
  );
  
  // Mock data for payment history
  final List<Map<String, dynamic>> _paymentHistory = [
    {
      'date': DateTime.now().subtract(const Duration(days: 30)),
      'amount': 25000.0,
      'status': 'paid',
      'type': 'regular',
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 60)),
      'amount': 25000.0,
      'status': 'paid',
      'type': 'regular',
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 90)),
      'amount': 30000.0,
      'status': 'paid',
      'type': 'extra_payment',
    },
  ];
  
  // Mock data for escrow details
  final Map<String, dynamic> _escrowDetails = {
    'balance': 45000.0,
    'propertyTax': {
      'annual': 24000.0,
      'nextDue': DateTime.now().add(const Duration(days: 60)),
    },
    'insurance': {
      'annual': 12000.0,
      'nextDue': DateTime.now().add(const Duration(days: 120)),
    },
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double monthlyPayment = _calculateMonthlyPayment();
    final double totalInterest = (monthlyPayment * widget.loanTerm * 12) - widget.loanAmount;
    final double remainingBalance = _calculateRemainingBalance();
    final double paidPrincipal = widget.loanAmount - remainingBalance;
    final double paidInterest = _calculatePaidInterest();
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Mortgage Management',
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
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: AppColors.primaryColor,
          labelStyle: GoogleFonts.outfit(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.outfit(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Payments'),
            Tab(text: 'Documents'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Overview Tab
          SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mortgage summary card
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mortgage Summary',
                              style: GoogleFonts.outfit(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                'Active',
                                style: GoogleFonts.outfit(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        _buildSummaryRow(
                          'Next Payment:',
                          currencyFormat.format(monthlyPayment),
                          isHighlighted: true,
                        ),
                        SizedBox(height: 4.h),
                        _buildSummaryRow(
                          'Due Date:',
                          DateFormat('MMMM d, yyyy').format(
                            DateTime.now().add(const Duration(days: 15)),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Divider(color: Colors.grey[200]),
                        SizedBox(height: 16.h),
                        _buildSummaryRow(
                          'Remaining Balance:',
                          currencyFormat.format(remainingBalance),
                        ),
                        SizedBox(height: 4.h),
                        _buildSummaryRow(
                          'Original Loan:',
                          currencyFormat.format(widget.loanAmount),
                        ),
                        SizedBox(height: 4.h),
                        _buildSummaryRow(
                          'Interest Rate:',
                          '${widget.interestRate}%',
                        ),
                        SizedBox(height: 4.h),
                        _buildSummaryRow(
                          'Loan Term:',
                          '${widget.loanTerm} years',
                        ),
                        SizedBox(height: 16.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _makePayment();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              'Make a Payment',
                              style: GoogleFonts.outfit(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                _buildLoanBreakdownChart(),
                SizedBox(height: 16.h),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PropertyValueScreen(
                          purchasePrice: widget.loanAmount * 1.2, // Assuming 20% down payment
                          purchaseDate: widget.startDate,
                          currentLoanBalance: _calculateRemainingBalance(),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.trending_up, color: Colors.white),
                  label: Text(
                    'Track Property Value',
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                ElevatedButton.icon(
                  onPressed: () {
                    // Calculate remaining term in years
                    final now = DateTime.now();
                    final monthsElapsed = (now.year - widget.startDate.year) * 12 + 
                                          now.month - widget.startDate.month;
                    final remainingTermYears = widget.loanTerm - (monthsElapsed / 12).floor();
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RefinanceCalculatorScreen(
                          currentLoanBalance: _calculateRemainingBalance(),
                          currentInterestRate: widget.interestRate,
                          remainingTerm: remainingTermYears,
                          monthlyPayment: _calculateMonthlyPayment(),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.calculate, color: Colors.white),
                  label: Text(
                    'Refinance Calculator',
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                
                // Escrow account
                Text(
                  'Escrow Account',
                  style: GoogleFonts.outfit(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16.h),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: BorderSide(color: Colors.grey[200]!),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        _buildEscrowRow(
                          'Current Balance:',
                          currencyFormat.format(_escrowDetails['balance']),
                          isHighlighted: true,
                        ),
                        SizedBox(height: 16.h),
                        Divider(color: Colors.grey[200]),
                        SizedBox(height: 16.h),
                        _buildEscrowItem(
                          'Property Tax',
                          currencyFormat.format(_escrowDetails['propertyTax']['annual']),
                          'Next payment: ${DateFormat('MMMM d, yyyy').format(_escrowDetails['propertyTax']['nextDue'] as DateTime)}',
                          Icons.home_work_outlined,
                        ),
                        SizedBox(height: 16.h),
                        _buildEscrowItem(
                          'Homeowner\'s Insurance',
                          currencyFormat.format(_escrowDetails['insurance']['annual']),
                          'Next payment: ${DateFormat('MMMM d, yyyy').format(_escrowDetails['insurance']['nextDue'] as DateTime)}',
                          Icons.security_outlined,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Payments Tab
          SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Payment breakdown
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
                          'Payment Breakdown',
                          style: GoogleFonts.outfit(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        SizedBox(
                          height: 200.h,
                          child: PieChart(
                            dataMap: {
                              "Principal": monthlyPayment * 0.7,
                              "Interest": monthlyPayment * 0.2,
                              "Escrow": monthlyPayment * 0.1,
                            },
                            colorList: [
                              AppColors.primaryColor,
                              Colors.orange,
                              Colors.blue,
                            ],
                            chartType: ChartType.ring,
                            ringStrokeWidth: 32.r,
                            legendOptions: const LegendOptions(
                              showLegendsInRow: false,
                              legendPosition: LegendPosition.right,
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildProgressLegend(
                              'Principal',
                              currencyFormat.format(monthlyPayment * 0.7),
                              AppColors.primaryColor,
                            ),
                            _buildProgressLegend(
                              'Interest',
                              currencyFormat.format(monthlyPayment * 0.2),
                              Colors.orange,
                            ),
                            _buildProgressLegend(
                              'Escrow',
                              currencyFormat.format(monthlyPayment * 0.1),
                              Colors.blue,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                
                // Payment history
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payment History',
                      style: GoogleFonts.outfit(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // View all payment history
                      },
                      child: Text(
                        'View All',
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _paymentHistory.length,
                  itemBuilder: (context, index) {
                    final payment = _paymentHistory[index];
                    return Card(
                      elevation: 0,
                      margin: EdgeInsets.only(bottom: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        side: BorderSide(color: Colors.grey[200]!),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16.w),
                        leading: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: payment['status'] == 'paid'
                                ? Colors.green[100]
                                : Colors.orange[100],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            payment['status'] == 'paid'
                                ? Icons.check_circle_outline
                                : Icons.pending_outlined,
                            color: payment['status'] == 'paid'
                                ? Colors.green[800]
                                : Colors.orange[800],
                            size: 24.sp,
                          ),
                        ),
                        title: Text(
                          payment['type'] == 'regular'
                              ? 'Regular Payment'
                              : 'Extra Payment',
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          DateFormat('MMMM d, yyyy').format(payment['date'] as DateTime),
                          style: GoogleFonts.outfit(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        trailing: Text(
                          currencyFormat.format(payment['amount']),
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 24.h),
                
                // Make a payment button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _makePayment();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Make a Payment',
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      _makeExtraPayment();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      side: BorderSide(color: AppColors.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Make Extra Payment',
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Documents Tab
          SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Important Documents',
                  style: GoogleFonts.outfit(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16.h),
                _buildDocumentCard(
                  'Mortgage Agreement',
                  'PDF',
                  '2.4 MB',
                  Icons.description_outlined,
                  Colors.blue,
                ),
                SizedBox(height: 12.h),
                _buildDocumentCard(
                  'Closing Disclosure',
                  'PDF',
                  '1.8 MB',
                  Icons.receipt_long_outlined,
                  Colors.green,
                ),
                SizedBox(height: 12.h),
                _buildDocumentCard(
                  'Property Deed',
                  'PDF',
                  '3.1 MB',
                  Icons.home_outlined,
                  Colors.purple,
                ),
                SizedBox(height: 12.h),
                _buildDocumentCard(
                  'Insurance Policy',
                  'PDF',
                  '1.2 MB',
                  Icons.security_outlined,
                  Colors.orange,
                ),
                SizedBox(height: 24.h),
                
                Text(
                  'Tax Documents',
                  style: GoogleFonts.outfit(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16.h),
                _buildDocumentCard(
                  'Annual Tax Statement 2023',
                  'PDF',
                  '0.9 MB',
                  Icons.receipt_outlined,
                  Colors.teal,
                ),
                SizedBox(height: 24.h),
                
                // Upload document button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Upload document
                    },
                    icon: Icon(
                      Icons.upload_file_outlined,
                      color: AppColors.primaryColor,
                      size: 20.sp,
                    ),
                    label: Text(
                      'Upload Document',
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
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSummaryRow(String label, String value, {bool isHighlighted = false}) {
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
  
  Widget _buildProgressLegend(String label, String value, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12.sp,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
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
  
  Widget _buildEscrowRow(String label, String value, {bool isHighlighted = false}) {
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
  
  Widget _buildEscrowItem(String title, String amount, String subtitle, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            color: AppColors.primaryColor,
            size: 24.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: GoogleFonts.outfit(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Text(
          amount,
          style: GoogleFonts.outfit(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
  
  Widget _buildDocumentCard(String title, String format, String size, IconData icon, Color color) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.w),
        leading: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24.sp,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          '$format • $size',
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.download_outlined,
            color: Colors.grey[700],
            size: 24.sp,
          ),
          onPressed: () {
            // Download document
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Downloading $title...'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        ),
        onTap: () {
          // View document
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Viewing $title...'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }
  
  double _calculateMonthlyPayment() {
    // P = L[c(1 + c)^n]/[(1 + c)^n - 1]
    // where L = loan amount, c = monthly interest rate, n = number of payments
    double monthlyRate = widget.interestRate / 100 / 12;
    int totalPayments = widget.loanTerm * 12;
    
    double monthlyPayment = widget.loanAmount * 
        (monthlyRate * pow(1 + monthlyRate, totalPayments)) / 
        (pow(1 + monthlyRate, totalPayments) - 1);
    
    return monthlyPayment;
  }
  
  double _calculateRemainingBalance() {
    // Calculate months elapsed since start date
    final now = DateTime.now();
    final monthsElapsed = (now.year - widget.startDate.year) * 12 + 
                          now.month - widget.startDate.month;
    
    // Calculate remaining balance based on amortization
    double monthlyRate = widget.interestRate / 100 / 12;
    int totalPayments = widget.loanTerm * 12;
    double monthlyPayment = _calculateMonthlyPayment();
    
    double balance = widget.loanAmount * 
        (pow(1 + monthlyRate, totalPayments) - pow(1 + monthlyRate, monthsElapsed)) / 
        (pow(1 + monthlyRate, totalPayments) - 1);
    
    return balance;
  }
  
  double _calculatePaidInterest() {
    // Calculate months elapsed since start date
    final now = DateTime.now();
    final monthsElapsed = (now.year - widget.startDate.year) * 12 + 
                          now.month - widget.startDate.month;
    
    double monthlyPayment = _calculateMonthlyPayment();
    double totalPaid = monthlyPayment * monthsElapsed;
    double remainingBalance = _calculateRemainingBalance();
    double paidPrincipal = widget.loanAmount - remainingBalance;
    
    return totalPaid - paidPrincipal;
  }
  
  void _makePayment() {
    final double monthlyPayment = _calculateMonthlyPayment();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Make a Payment',
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
              'Select payment amount:',
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Regular Payment:',
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        currencyFormat.format(monthlyPayment),
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Due Date:',
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        DateFormat('MMMM d, yyyy').format(
                          DateTime.now().add(const Duration(days: 15)),
                        ),
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Extra Payment:',
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Text(
                        currencyFormat.format(monthlyPayment * 0.1),
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Extra payments reduce your principal balance and can help you pay off your mortgage faster.',
                    style: GoogleFonts.outfit(
                      fontSize: 12.sp,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Payment:',
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    currencyFormat.format(monthlyPayment * 1.1),
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
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
              
              // Show payment success dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  title: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 24.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Payment Successful',
                        style: GoogleFonts.outfit(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Your payment of ${currencyFormat.format(monthlyPayment * 1.1)} has been processed successfully.',
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.receipt_long_outlined,
                              color: AppColors.primaryColor,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Transaction ID:',
                                  style: GoogleFonts.outfit(
                                    fontSize: 12.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  'TXN-${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 13)}',
                                  style: GoogleFonts.outfit(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
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
                        'Close',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Download receipt
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Downloading payment receipt...'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Text(
                        'Download Receipt',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
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
              'Make Payment',
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
  
  void _showAmortizationSchedule() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AmortizationScheduleScreen(
          loanAmount: widget.loanAmount,
          interestRate: widget.interestRate,
          loanTerm: widget.loanTerm,
          startDate: widget.startDate,
          monthlyPayment: _calculateMonthlyPayment(),
        ),
      ),
    );
  }
  
  void _makeExtraPayment() {
    final double monthlyPayment = _calculateMonthlyPayment();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Make Extra Payment',
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
              'Extra payments reduce your principal balance and help you pay off your mortgage faster.',
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Payment Amount',
                prefixText: 'ETB ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Extra payment processed successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            child: Text('Submit Payment'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoanBreakdownChart() {
    final double remainingBalance = _calculateRemainingBalance();
    final double paidPrincipal = widget.loanAmount - remainingBalance;
    final double paidInterest = _calculatePaidInterest();
    
    return Card(
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
              'Loan Breakdown',
              style: GoogleFonts.outfit(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: _buildProgressIndicator(
                    'Principal Paid',
                    paidPrincipal,
                    widget.loanAmount,
                    AppColors.primaryColor,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildProgressIndicator(
                    'Interest Paid',
                    paidInterest,
                    paidInterest + (widget.loanAmount * widget.interestRate / 100 * widget.loanTerm - paidInterest),
                    Colors.orange,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildSummaryRow('Paid Principal:', currencyFormat.format(paidPrincipal)),
            SizedBox(height: 4.h),
            _buildSummaryRow('Remaining Principal:', currencyFormat.format(remainingBalance)),
            SizedBox(height: 4.h),
            _buildSummaryRow('Paid Interest:', currencyFormat.format(paidInterest)),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(String label, double value, double total, Color color) {
    final percentage = (value / total * 100).toStringAsFixed(1);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        Stack(
          children: [
            Container(
              height: 16.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            FractionallySizedBox(
              widthFactor: value / total,
              child: Container(
                height: 16.h,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          '$percentage%',
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}