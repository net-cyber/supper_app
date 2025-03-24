import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/theme/app_colors.dart';

class TextElevatedButton extends StatelessWidget {
  const TextElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isDisabled = false,
  });
  final String text;
  final VoidCallback onPressed;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14.w),
      child: SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.r),
                        ),
                      ),
        child: Text(
          text,
          style: GoogleFonts.outfit(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}