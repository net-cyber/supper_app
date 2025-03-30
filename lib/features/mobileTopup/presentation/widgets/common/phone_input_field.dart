import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;
  final String countryCode;
  final String flagAssetPath;
  final Function()? onContactsTap;
  final ValueChanged<String>? onChanged;

  const PhoneInputField({
    Key? key,
    required this.controller,
    required this.countryCode,
    required this.flagAssetPath,
    this.onContactsTap,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 60.h,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              children: [
                // Country flag and code
                SizedBox(
                  width: 80.w,
                  child: Row(
                    children: [
                      SizedBox(width: 10.w),
                      Image.asset(
                        flagAssetPath,
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        countryCode,
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Phone number input field
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.phone,
                    style: GoogleFonts.outfit(fontSize: 16.sp),
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '9 00000000',
                      hintStyle: GoogleFonts.outfit(
                        color: Colors.grey,
                        fontSize: 16.sp,
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(9),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Contacts button (if provided)
        if (onContactsTap != null) ...[
          SizedBox(width: 10.w),
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.indigo[900],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.contacts_outlined,
                color: Colors.white,
              ),
              onPressed: onContactsTap,
            ),
          ),
        ],
      ],
    );
  }
}
