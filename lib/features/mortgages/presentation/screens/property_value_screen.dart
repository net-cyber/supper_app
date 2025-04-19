import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:super_app/core/theme/app_colors.dart';


class PropertyValueScreen extends StatefulWidget {

  const PropertyValueScreen({
    Key? key,
    required this.purchasePrice,
    required this.purchaseDate,
    required this.currentLoanBalance,
  }) : super(key: key);
  final double purchasePrice;
  final DateTime purchaseDate;
  final double currentLoanBalance;

  @override
  State<PropertyValueScreen> createState() => _PropertyValueScreenState();
}

class _PropertyValueScreenState extends State<PropertyValueScreen> {
  final currencyFormat = NumberFormat.currency(
    locale: 'en_ET',
    symbol: 'ETB ',
    decimalDigits: 0,
  );
  
  // Mock data for property value history
  late List<Map<String, dynamic>> _valueHistory;
  late double _currentValue;
  
  @override
  void initState() {
    super.initState();
    _generateValueHistory();
  }
  
  void _generateValueHistory() {
    // Generate mock property value history with some appreciation
    final now = DateTime.now();
    final monthsSincePurchase = (now.year - widget.purchaseDate.year) * 12 + 
                               now.month - widget.purchaseDate.month;
    
    // Assume 5% annual appreciation (approximately 0.4% monthly)
    _currentValue = widget.purchasePrice * (1 + (0.004 * monthsSincePurchase));
    
    _valueHistory = [];
    var date = widget.purchaseDate;
    var value = widget.purchasePrice;
    
    while (date.isBefore(now) || date.isAtSameMomentAs(now)) {
      _valueHistory.add({
        'date': date,
        'value': value,
      });
      
      // Move to next quarter
      date = DateTime(date.year, date.month + 3, date.day);
      
      // Add some randomness to the appreciation rate (between 0.8% and 1.4% per quarter)
      final quarterlyRate = 0.008 + (0.006 * (DateTime.now().millisecondsSinceEpoch % 100) / 100);
      value = value * (1 + quarterlyRate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final equity = _currentValue - widget.currentLoanBalance;
    final equityPercentage = equity / _currentValue * 100;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Property Value',
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
            // Current value card
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
                      'Current Property Value',
                      style: GoogleFonts.outfit(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      currencyFormat.format(_currentValue),
                      style: GoogleFonts.outfit(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Purchase Price: ${currencyFormat.format(widget.purchasePrice)}',
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildValueCard(
                            'Appreciation',
                            currencyFormat.format(_currentValue - widget.purchasePrice),
                            '${((_currentValue / widget.purchasePrice - 1) * 100).toStringAsFixed(1)}%',
                            Colors.green[700]!,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _buildValueCard(
                            'Your Equity',
                            currencyFormat.format(equity),
                            '${equityPercentage.toStringAsFixed(1)}%',
                            AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            
            // Equity breakdown
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
                      'Equity Breakdown',
                      style: GoogleFonts.outfit(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _buildEquityProgressBar(equity, widget.currentLoanBalance),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildLegendItem('Your Equity', AppColors.primaryColor),
                        _buildLegendItem('Loan Balance', Colors.grey[300]!),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            
            // Value history
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
                      'Value History',
                      style: GoogleFonts.outfit(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      height: 200.h,
                      child: _buildValueHistoryList(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            
            // Neighborhood trends
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
                      'Neighborhood Trends',
                      style: GoogleFonts.outfit(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Recent sales in your area',
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _buildNeighborhoodSale(
                      'Modern Apartment',
                      '2 bed, 2 bath',
                      5200000,
                      DateTime.now().subtract(const Duration(days: 15)),
                    ),
                    SizedBox(height: 12.h),
                    _buildNeighborhoodSale(
                      'Luxury Condo',
                      '3 bed, 2 bath',
                      6800000,
                      DateTime.now().subtract(const Duration(days: 30)),
                    ),
                    SizedBox(height: 12.h),
                    _buildNeighborhoodSale(
                      'Family Home',
                      '4 bed, 3 bath',
                      8500000,
                      DateTime.now().subtract(const Duration(days: 45)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildValueCard(String label, String value, String percentage, Color color) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            value,
            style: GoogleFonts.outfit(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            percentage,
            style: GoogleFonts.outfit(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEquityProgressBar(double equity, double loanBalance) {
    final total = equity + loanBalance;
    final equityPercentage = equity / total;
    
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 24.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            FractionallySizedBox(
              widthFactor: equityPercentage,
              child: Container(
                height: 24.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              currencyFormat.format(equity),
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
            Text(
              currencyFormat.format(loanBalance),
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildLegendItem(String label, Color color) {
    return Row(
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
    );
  }
  
  Widget _buildValueHistoryList() {
    return ListView.builder(
      itemCount: _valueHistory.length,
      itemBuilder: (context, index) {
        final item = _valueHistory[index];
        final date = item['date'] as DateTime;
        final value = item['value'] as double;
        
        // Calculate percentage change from purchase price
        final percentChange = ((value / widget.purchasePrice) - 1) * 100;
        
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Row(
            children: [
              SizedBox(
                width: 100.w,
                child: Text(
                  DateFormat('MMM yyyy').format(date),
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  currencyFormat.format(value),
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(
                width: 80.w,
                child: Text(
                  '+${percentChange.toStringAsFixed(1)}%',
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.green[700],
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildNeighborhoodSale(String title, String details, double price, DateTime saleDate) {
    return Row(
      children: [
        Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.home_outlined,
            color: Colors.grey[700],
            size: 30.sp,
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
              Text(
                details,
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              currencyFormat.format(price),
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              DateFormat('MMM d').format(saleDate),
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
} 