import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/mobileTopup/application/mobile_topup/bloc/mobile_topup.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  void _handleBackNavigation(BuildContext context) {
    try {
      context.pop();
    } catch (e) {
      // Navigate back to amount selection screen
      context.goNamed(RouteName.mobileTopupAmount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MobileTopupBloc, MobileTopupState>(
      builder: (context, state) {
        // Mock user data
        final senderName = 'Jhon Wick';
        final senderAccount = '2991083724811';
        final currentDate = DateTime.now();
        final formattedDate =
            DateFormat('MMM dd, yyyy hh:mm a').format(currentDate);

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
                        '${state.amount.toStringAsFixed(2)}',
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
                        _buildDetailRow('Sender Name:', senderName),
                        _buildDetailRow('Sender Account:', senderAccount),
                        _buildDetailRow('Recipient Number:', state.phoneNumber),
                        _buildDetailRow('Budget:', 'Off Budget'),
                        _buildDetailRow('Date:', formattedDate),
                        _buildDetailRow('Service-Charge:', '0.00 ETB'),
                        _buildDetailRow('VAT(15%):', '0.00 ETB'),
                        _buildDetailRow(
                          'Status',
                          'Unpaid',
                          valueColor: Colors.red,
                        ),
                        _buildDetailRow(
                          'Total:',
                          '${state.amount.toStringAsFixed(2)} ETB',
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
                              // Submit the topup request
                              context
                                  .read<MobileTopupBloc>()
                                  .add(const SubmitTopupRequest());

                              // Navigate to success screen
                              context.goNamed(RouteName.mobileTopupSuccess);
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
                            onPressed: () {
                              _handleBackNavigation(context);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.outfit(
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
      },
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
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
