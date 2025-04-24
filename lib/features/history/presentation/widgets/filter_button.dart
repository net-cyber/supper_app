import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const FilterButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40.w,
        height: 40.w,
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Icon(
          icon,
          color: primaryColor,
          size: 20.sp,
        ),
      ),
    );
  }
} 