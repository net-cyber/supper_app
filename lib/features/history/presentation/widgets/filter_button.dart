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

    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF), // Light blue background
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: theme.primaryColor,
          size: 20.w,
        ),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }
} 