import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BankItem extends StatelessWidget {
  final Map<String, dynamic> bank;
  final VoidCallback onTap;

  const BankItem({
    super.key,
    required this.bank,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo container with fallback icon
            Container(
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                color: _getBankColor(bank['name']),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.r),
              ),
              // Display a default icon since we don't have the actual logos yet
              child: Center(
                child: Text(
                  _getInitials(bank['name']),
                  style: GoogleFonts.outfit(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              bank['name'],
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
  
  // Generate a color based on the bank name
  Color _getBankColor(String name) {
    // Create a simple hash from the name to get a consistent color
    final int hash = name.length + name.codeUnitAt(0) + (name.length > 1 ? name.codeUnitAt(1) : 0);
    
    // List of bank-like colors
    final bankColors = [
      const Color(0xFF4A6FE5), // Blue
      const Color(0xFF2EC4B6), // Teal
      const Color(0xFFFF9F1C), // Orange
      const Color(0xFFE71D36), // Red
      const Color(0xFF8338EC), // Purple
      const Color(0xFF3A86FF), // Light Blue
      const Color(0xFFFF006E), // Pink
      const Color(0xFF06D6A0), // Green
      const Color(0xFFFFBE0B), // Yellow
    ];
    
    // Use the hash to select a color
    return bankColors[hash % bankColors.length];
  }
  
  // Get the first 2 characters of the bank name
  String _getInitials(String name) {
    final nameParts = name.split(' ');
    if (nameParts.length > 1) {
      // For banks with multiple words, use first letter of first two words
      return (nameParts[0][0] + nameParts[1][0]).toUpperCase();
    } else {
      // For single word banks, use first two letters
      return name.length > 1 ? name.substring(0, 2).toUpperCase() : name[0].toUpperCase();
    }
  }
} 