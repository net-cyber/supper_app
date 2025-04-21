import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isNumeric;
  final String? errorMessage;
  final bool enabled;

  const AccountInputField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.isNumeric = true,
    this.errorMessage,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorMessage != null && errorMessage!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: enabled ? Colors.grey[200] : Colors.grey[100],
            borderRadius: BorderRadius.circular(12.r),
            border: hasError ? Border.all(color: Colors.red, width: 1.5) : null,
          ),
          child: TextField(
            controller: controller,
            enabled: enabled,
            style: GoogleFonts.outfit(
              fontSize: 16.sp,
              color: enabled ? Colors.black87 : Colors.grey[600],
            ),
            keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
            inputFormatters:
                isNumeric ? [FilteringTextInputFormatter.digitsOnly] : null,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.outfit(
                fontSize: 16.sp,
                color: Colors.grey[500],
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 16.h,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 4.w),
            child: Text(
              errorMessage!,
              style: GoogleFonts.outfit(
                fontSize: 12.sp,
                color: Colors.red[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
