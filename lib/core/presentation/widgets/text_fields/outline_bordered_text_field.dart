import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';




class OutlinedBorderTextField extends StatelessWidget {

  const   OutlinedBorderTextField({
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

  @override
  Widget build(BuildContext context) {
    // final bool isDarkMode = LocalStorage.instance.getAppThemeMode();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            // Removing the border from here since we're using InputDecoration border
          ),
          child: TextFormField(  // Removed ClipRRect
            validator: validator,
            onChanged: onChanged,
            obscureText: obscure ?? false,
            obscuringCharacter: '*',
            controller: textController,
            style: GoogleFonts.k2d(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              letterSpacing: -14 * 0.01,
            ),
            cursorWidth: 1,
            keyboardType: inputType,
            readOnly: readOnly,
            textCapitalization:
                textCapitalization ?? TextCapitalization.sentences,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              prefixText: prefixText,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: isError
                    ? Theme.of(context).colorScheme.error
                    : isSuccess
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: isError
                    ? Theme.of(context).colorScheme.error
                    : isSuccess
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                ),
              ),
              suffixIcon: suffixIcon,
              labelText: label,
              contentPadding:
                  REdgeInsets.symmetric(horizontal: 15, vertical: 13),
              floatingLabelStyle: GoogleFonts.k2d(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                letterSpacing: -14 * 0.01,
              ),
              filled: true,
              errorBorder: InputBorder.none,
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
                style: GoogleFonts.k2d(
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.3,
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
