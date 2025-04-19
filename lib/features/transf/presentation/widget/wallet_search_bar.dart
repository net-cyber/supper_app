import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:developer';

class WalletSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  final String hintText;
  final double height;
  final EdgeInsets? margin;

  const WalletSearchBar({
    Key? key,
    required this.onSearch,
    this.hintText = 'Search wallet',
    this.height = 50,
    this.margin,
  }) : super(key: key);

  @override
  State<WalletSearchBar> createState() => _WalletSearchBarState();
}

class _WalletSearchBarState extends State<WalletSearchBar> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      log('Search query: ${_controller.text}');
      widget.onSearch(_controller.text);
    });
  }

  void _clearText() {
    _controller.clear();
    widget.onSearch('');
    if (_debounce?.isActive ?? false) _debounce!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height.h,
      margin: widget.margin ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        style: GoogleFonts.poppins(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(
            color: Colors.grey.shade400,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey.shade400,
            size: 20.sp,
          ),
          suffixIcon: _controller.text.isNotEmpty
              ? GestureDetector(
                  onTap: _clearText,
                  child: Icon(
                    Icons.close,
                    color: Colors.grey.shade400,
                    size: 20.sp,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        ),
        // Allow more characters for searching different types of wallets
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s\-._]')),
        ],
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          log('Search submitted: $value');
          widget.onSearch(value);
        },
      ),
    );
  }
} 