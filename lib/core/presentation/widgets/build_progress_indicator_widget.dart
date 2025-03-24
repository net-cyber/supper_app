import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_app/core/theme/app_colors.dart';

Widget buildProgressIndicator({required int currentStep, required int totalSteps}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
    child: SizedBox(
      width: double.infinity,
      child: Row(
        children: List.generate(totalSteps, (index) {
          final isActive = index < currentStep;
          return Expanded(
            child: Row(
              children: [
                if (index > 0) SizedBox(width: 4.w),
                Expanded(
                  child: Container(
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: isActive 
                          ? AppColors.primaryColor 
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    ),
  );
}