import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isEnabled;
  final bool isLoading;
  final Color? color;
  final String text;

  const ContinueButton({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
    this.color,
    this.text = 'Continue',
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? Theme.of(context).colorScheme.primary;
    
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: (isEnabled && !isLoading) ? onPressed : null,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.r),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: (isEnabled || isLoading)
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      buttonColor,
                      buttonColor.withOpacity(0.8),
                    ],
                    stops: const [0.3, 1.0],
                  )
                : null,
            color: (isEnabled || isLoading) ? null : Colors.grey[400],
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: (isEnabled || isLoading)
                ? [
                    BoxShadow(
                      color: buttonColor.withOpacity(0.25),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: Container(
            width: double.infinity,
            height: 56.h,
            alignment: Alignment.center,
            child: isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                        width: 20.h,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.w,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Processing...',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                : Text(
                    text,
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
} 