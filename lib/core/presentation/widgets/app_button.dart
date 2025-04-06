import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {

  const AppButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? theme.colorScheme.primary,
          foregroundColor: textColor ?? theme.colorScheme.onPrimary,
          disabledBackgroundColor: theme.colorScheme.primary.withOpacity(0.6),
          disabledForegroundColor: theme.colorScheme.onPrimary.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: isLoading 
          ? SizedBox(
              width: 24.w,
              height: 24.h,
              child: CircularProgressIndicator(
                color: theme.colorScheme.onPrimary,
                strokeWidth: 2.5,
              ),
            )
          : Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: textColor ?? theme.colorScheme.onPrimary,
              ),
            ),
      ),
    );
  }
} 