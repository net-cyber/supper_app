import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  // Data from previous screen
  late String _phoneNumber;
  late String _operatorName;
  late String _operatorLogo;
  late double _amount;

  // Mock transaction data
  final String _transactionId = 'TRX-${DateTime.now().millisecondsSinceEpoch}';
  final String _formattedDate =
      DateFormat('MMM dd, yyyy hh:mm a').format(DateTime.now());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get data passed from previous screen
    final Map<String, dynamic>? extraData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            GoRouterState.of(context).extra as Map<String, dynamic>?;

    if (extraData != null) {
      _phoneNumber = extraData['phoneNumber'] as String? ?? '';
      _operatorName = extraData['operatorName'] as String? ?? '';
      _operatorLogo = extraData['operatorLogo'] as String? ?? '';
      _amount = extraData['amount'] as double? ?? 0.0;
    } else {
      _phoneNumber = '';
      _operatorName = '';
      _operatorLogo = '';
      _amount = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50.h),

              // Success icon
              Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.check_circle_outline,
                    size: 60.sp,
                    color: Colors.green,
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // Success title
              Text(
                'Transfer Successful',
                style: GoogleFonts.outfit(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10.h),

              // Amount
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '${_amount.toStringAsFixed(2)}',
                    style: GoogleFonts.montserrat(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    'Birr',
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30.h),

              // Transaction details card
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildDetailRow('Transaction ID:', _transactionId),
                    _buildDetailRow('Date:', _formattedDate),
                    _buildDetailRow('Recipient:', _phoneNumber),
                    _buildDetailRow('Operator:', _operatorName),
                    _buildDetailRow(
                      'Status',
                      'Completed',
                      valueColor: Colors.green,
                    ),
                    _buildDetailRow(
                      'Amount:',
                      '${_amount.toStringAsFixed(2)} ETB',
                      isBold: true,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              // Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    // Share receipt button
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Implement share receipt functionality
                        },
                        icon: Icon(
                          Icons.share,
                          size: 24.sp,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Share Receipt',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),

                    SizedBox(height: 15.h),

                    // Done button
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: TextButton(
                        onPressed: () {
                          // Navigate back to home screen
                          context.goNamed(RouteName.home);
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        child: Text(
                          'Done',
                          style: GoogleFonts.outfit(
                            color: Colors.indigo[900],
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
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
      ),
    );
  }

  Widget _buildDetailRow(String label, String value,
      {bool isBold = false, Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 16.sp,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
