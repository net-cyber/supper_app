import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/core/router/router.dart';

class SelectOperatorScreen extends StatelessWidget {
  const SelectOperatorScreen({Key? key}) : super(key: key);

  void _handleBackNavigation(BuildContext context) {
    try {
      // Try to pop the current route
      context.pop();
    } catch (e) {
      // If popping fails, navigate to the main screen
      context.goNamed(RouteName.mainScreen);
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
          'Mobile Top-up',
          style: GoogleFonts.outfit(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Text(
                'Select Your Network Operator',
                style: GoogleFonts.outfit(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),

            // Operators grid
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 15.w,
                  mainAxisSpacing: 15.h,
                  children: [
                    _buildOperatorCard(
                      context,
                      'Ethio-Telecom',
                      'assets/tele-logo.png',
                    ),
                    _buildOperatorCard(
                      context,
                      'Safaricom',
                      'assets/safari-logo.png',
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

  Widget _buildOperatorCard(
      BuildContext context, String name, String logoPath) {
    return GestureDetector(
      onTap: () {
        navigateToMobileTopupPhoneNumber(
          context,
          operatorName: name,
          operatorLogo: logoPath,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              logoPath,
              height: 80.h,
            ),
            SizedBox(height: 15.h),
            Text(
              name,
              style: GoogleFonts.outfit(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
