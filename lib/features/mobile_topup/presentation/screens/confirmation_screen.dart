import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  // Data from previous screen
  late String _phoneNumber;
  late String _operatorName;
  late String _operatorLogo;
  late double _amount;

  // Mock user data
  final String _senderName = 'Sorawak Abeya Bayisa';
  final String _senderAccount = '2991******811';
  final String _formattedDate =
      DateFormat('MMM dd, yyyy hh:mm a').format(DateTime.now());
  final TextEditingController _reasonController = TextEditingController();

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
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _handleBackNavigation(BuildContext context) {
    try {
      context.pop();
    } catch (e) {
      // Navigate back to amount selection screen
      context.goNamed(
        RouteName.mobileTopupAmount,
        extra: {
          'phoneNumber': _phoneNumber,
          'operatorName': _operatorName,
          'operatorLogo': _operatorLogo,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => _handleBackNavigation(context),
        ),
        title: Text(
          'Confirm Transfer',
          style: GoogleFonts.outfit(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),

              // Warning icon
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/icons/warning.png',
                    width: 48.w,
                    height: 48.h,
                    // If asset is not available, use Icon instead
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.warning_amber_rounded,
                        size: 48.sp,
                        color: Colors.amber,
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // Confirm transfer title
              Text(
                'Confirm Transfer',
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
                    // Sender info
                    _buildDetailRow('Sender Name:', _senderName),
                    _buildDetailRow('Sender Account:', _senderAccount),
                    _buildDetailRow('Recipient Number:', _phoneNumber),
                    _buildDetailRow('Operator:', _operatorName),
                    _buildDetailRow('Budget:', 'Off Budget'),
                    _buildDetailRow('Date:', _formattedDate),
                    _buildDetailRow('Service-Charge:', '0.00 ETB'),
                    _buildDetailRow('VAT(15%):', '0.00 ETB'),
                    _buildDetailRow(
                      'Status',
                      'Unpaid',
                      valueColor: Colors.red,
                    ),
                    _buildDetailRow(
                      'Total:',
                      '${_amount.toStringAsFixed(2)} ETB',
                      isBold: true,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              // Reason field
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reason (Optional)',
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextField(
                      controller: _reasonController,
                      decoration: InputDecoration(
                        hintText: 'Enter Reason',
                        hintStyle: GoogleFonts.outfit(
                          color: Colors.grey,
                          fontSize: 16.sp,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 15.h,
                        ),
                      ),
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                      ),
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
                    // Confirm button
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to success screen
                          context.goNamed(
                            RouteName.mobileTopupSuccess,
                            extra: {
                              'phoneNumber': _phoneNumber,
                              'operatorName': _operatorName,
                              'operatorLogo': _operatorLogo,
                              'amount': _amount,
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Confirm',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 15.h),

                    // Cancel button
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: TextButton(
                        onPressed: () => _handleBackNavigation(context),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            side: BorderSide(
                              color: Colors.indigo[900]!,
                              width: 1.5,
                            ),
                          ),
                        ),
                        child: Text(
                          'Cancel',
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

              SizedBox(height: 30.h),
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
              color: Colors.grey[700],
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
