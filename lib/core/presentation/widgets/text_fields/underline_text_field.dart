import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UnderlineTextField extends StatelessWidget {

  const UnderlineTextField({
    required this.label, super.key,
    this.suffixIcon,
    this.obscure,
    this.onChanged,
    this.textController,
    this.inputType,
    this.descriptionText,
    this.readOnly = false,
    this.isError = false,
    this.isSuccess = false,
    this.textCapitalization,
    this.textInputAction,
    this.validator,
    this.onTap,
    this.prefixText,
    this.width,
  });
  final String label;
  final Widget? suffixIcon;
  final bool? obscure;
  final String? prefixText;
  final TextEditingController? textController;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? inputType;
  final String? descriptionText;
  final bool readOnly;
  final bool isError;
  final bool isSuccess;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final VoidCallback? onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: isError
                    ? Theme.of(context).colorScheme.error
                    : isSuccess
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[300]!,
              ),
            ),
          ),
          child: TextFormField(
            validator: validator,
            onChanged: onChanged,
            obscureText: obscure ?? false,
            obscuringCharacter: '*',
            controller: textController,
            style: GoogleFonts.outfit(
              fontSize: 20.sp,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            cursorWidth: 1,
            keyboardType: inputType,
            readOnly: readOnly,
            textCapitalization:
                textCapitalization ?? TextCapitalization.sentences,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              prefixText: prefixText,
              hintText: label,
              hintStyle: GoogleFonts.outfit(
                fontSize: 20.sp,
                color: const Color(0xFFCCCCCC),
                fontWeight: FontWeight.w400,
              ),
              suffixIcon: suffixIcon,
              contentPadding: EdgeInsets.symmetric(vertical: 8.h),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              filled: false,
            ),
            onTap: onTap,
          ),
        ),
        if (descriptionText != null)
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              4.verticalSpace,
              Text(
                descriptionText!,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: isError
                      ? Theme.of(context).colorScheme.error
                      : isSuccess
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
      ],
    );
  }
} 