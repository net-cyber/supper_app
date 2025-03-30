import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/mobileTopup/application/mobile_topup/bloc/mobile_topup.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MobileTopupBloc, MobileTopupState>(
      builder: (context, state) {
        // Mock transaction data
        final senderName = 'Sorawak Abeya Bayisa';
        final senderAccount = '2991******811';
        final currentDate = DateTime.now();
        final formattedDate =
            DateFormat('MMM dd, yyyy hh:mm a').format(currentDate);
        final ftRef = 'J10ETAI250870002';
        final transactionRef = 'ETAI595104043493384854557';

        return Scaffold(
          backgroundColor: Colors.grey[50],
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Receipt card
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(20.w),
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Column(
                      children: [
                        // Bank logo and QR Code row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Bank logo
                            Container(
                              width: 50.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Colors.indigo[900],
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: Text(
                                  'GOH',
                                  style: GoogleFonts.notoSansEthiopic(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            // QR Code button
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.indigo[900]!,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.qr_code,
                                    color: Colors.indigo[900],
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    'QR Code',
                                    style: GoogleFonts.outfit(
                                      color: Colors.indigo[900],
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 30.h),

                        // Success icon
                        Container(
                          width: 80.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 48.sp,
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // Success message
                        Text(
                          'Top-Up Successful!',
                          style: GoogleFonts.outfit(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 10.h),

                        Text(
                          'Your mobile top-up was completed successfully. Thank you for using our service!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),

                        SizedBox(height: 20.h),

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
                              '(ETB)',
                              style: GoogleFonts.outfit(
                                fontSize: 18.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Transaction details
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        _buildDetailRow('Payer Name:', senderName),
                        _buildDetailRow('Payer Account:', senderAccount),
                        _buildDetailRow('Recipient Number:', state.phoneNumber),
                        _buildDetailRow('Budget:', 'Off Budget'),
                        _buildDetailRow('Date:', formattedDate),
                        _buildDetailRow('FT Ref:', ftRef),
                        _buildDetailRow('Transaction Ref:', transactionRef),
                        _buildDetailRow('Service-Charge:', '0.00 ETB'),
                        _buildDetailRow('VAT(15%):', '0.00 ETB'),
                        _buildDetailRow(
                          'Total:',
                          '${state.amount.toStringAsFixed(2)} ETB',
                          isBold: true,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Back to home button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton(
                        onPressed: () {
                          // Reset the topup state
                          context
                              .read<MobileTopupBloc>()
                              .add(const ResetTopupState());

                          // Navigate back to main screen
                          context.goNamed(RouteName.mainScreen);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Back To Home',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
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

  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
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
            ),
          ),
        ],
      ),
    );
  }
}
