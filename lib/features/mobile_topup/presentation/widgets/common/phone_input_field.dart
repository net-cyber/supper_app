import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;
  final String countryCode;
  final String flagAssetPath;
  final String? operatorName;
  final VoidCallback? onContactsTap;
  final ValueChanged<String>? onChanged;

  const PhoneInputField({
    Key? key,
    required this.controller,
    required this.countryCode,
    required this.flagAssetPath,
    this.operatorName,
    this.onContactsTap,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String hintDigit =
        operatorName?.toLowerCase().contains('safaricom') == true ? '7' : '9';
    final contactsButton = _buildContactsButton();

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 56.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                _buildCountrySection(),
                _buildPhoneTextField(hintDigit),
              ],
            ),
          ),
        ),
        if (contactsButton != null) ...[
          SizedBox(width: 12.w),
          contactsButton,
        ],
      ],
    );
  }

  Widget _buildCountrySection() {
    return Container(
      width: 88.w,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey.shade200,
            width: 1.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                flagAssetPath,
                width: 24.w,
                height: 24.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.flag,
                    size: 20.sp,
                    color: Colors.grey.shade600,
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            countryCode,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneTextField(String hintDigit) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            color: Colors.black87,
          ),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '$hintDigit 00000000',
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey.shade400,
              fontSize: 16.sp,
            ),
            contentPadding: EdgeInsets.zero,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(9),
            _PhoneNumberFormatter(),
          ],
        ),
      ),
    );
  }

  Widget? _buildContactsButton() {
    if (onContactsTap == null) return null;

    return Container(
      width: 56.w,
      height: 56.h,
      decoration: BoxDecoration(
        color: const Color(0xFF4263EB).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: IconButton(
        icon: Icon(
          Icons.contacts_outlined,
          color: const Color(0xFF4263EB),
          size: 24.sp,
        ),
        onPressed: onContactsTap,
        tooltip: 'Select from contacts',
      ),
    );
  }
}

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Skip formatting if no changes or if text is empty
    if (oldValue.text == newValue.text || newValue.text.isEmpty) {
      return newValue;
    }

    // Strip any existing spaces to normalize the input
    final String rawText = newValue.text.replaceAll(' ', '');

    // If we only have one digit or less, return as is
    if (rawText.length <= 1) {
      return TextEditingValue(
        text: rawText,
        selection: TextSelection.collapsed(offset: rawText.length),
      );
    }

    // Add space after the first digit
    final String formattedText =
        '${rawText.substring(0, 1)} ${rawText.substring(1)}';

    // Calculate new cursor position
    final int cursorPosition =
        newValue.selection.end + (formattedText.length - newValue.text.length);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}
