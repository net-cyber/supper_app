import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';

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
    final String name = bank['name'] as String;
    final String logo = bank['logo'] as String? ?? '';
    final Color color = Color(bank['color'] as int? ?? Colors.blue[700]!.value);

    String getInitials() {
      final nameParts = name.trim().split(' ');
      if (nameParts.length > 1 && nameParts[0].isNotEmpty && nameParts[1].isNotEmpty) {
        return '${nameParts[0][0]}${nameParts[1][0]}';
      } else if (nameParts.isNotEmpty && nameParts[0].isNotEmpty) {
        return nameParts[0].length > 1 
            ? nameParts[0].substring(0, 2).toUpperCase() 
            : nameParts[0][0].toUpperCase();
      }
      return 'B';
    }

    Widget buildLogoOrInitials() {
      // Check if logo is a URL (starts with http:// or https://)
      final isNetworkImage = logo.startsWith('http://') || logo.startsWith('https://');
      final isAssetImage = logo.startsWith('assets/');
      
      if (isNetworkImage) {
        return Image.network(
          logo,
          width: 30.w,
          height: 30.h,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
              width: 30.w,
              height: 30.h,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: color.withOpacity(0.5),
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / 
                        loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            log('Failed to load bank logo from network: $logo. Error: $error');
            return Text(
              getInitials(),
              style: GoogleFonts.outfit(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            );
          },
        );
      } else if (isAssetImage) {
        return Image.asset(
          logo,
          width: 30.w,
          height: 30.h,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            log('Failed to load bank logo from assets: $logo. Error: $error');
            return Text(
              getInitials(),
              style: GoogleFonts.outfit(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            );
          },
        );
      } else {
        // If logo is neither a valid URL nor asset path, show initials
        log('Invalid bank logo path format: $logo. Using initials instead.');
        return Text(
          getInitials(),
          style: GoogleFonts.outfit(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        );
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: buildLogoOrInitials(),
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              constraints: BoxConstraints(minHeight: 40.h),
              child: Text(
                name,
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
