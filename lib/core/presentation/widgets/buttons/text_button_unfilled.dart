
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextButtonUnfilled extends StatelessWidget {
  const TextButtonUnfilled({
    required this.text, required this.onPressed, super.key,
  });
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(color: const Color(0xFFFFD700), width: 1.w),
        ),
        minimumSize: Size(double.infinity, 48.h),
      ),
      child: Text(
        text,
        style: GoogleFonts.outfit(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurface,
      
    ),
      ),
    );
  }
}
