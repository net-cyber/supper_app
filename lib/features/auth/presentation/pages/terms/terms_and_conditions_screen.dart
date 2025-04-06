import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/theme/app_colors.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: isDarkMode ? colorScheme.surfaceContainerHighest : colorScheme.surface,
        elevation: 0,
        title: Text(
          'Terms & Conditions',
          style: GoogleFonts.outfit(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: GoogleFonts.outfit(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Last Updated: ${DateTime.now().toString().substring(0, 10)}',
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 24.h),
            
            _buildSection(
              context,
              title: '1. Introduction',
              content: 'Welcome to our financial application. These Terms and Conditions govern your use of our application and services. By accessing or using our services, you agree to be bound by these Terms.',
            ),
            
            _buildSection(
              context,
              title: '2. Definitions',
              content: '"App" refers to this financial application.\n"Services" refers to the features and functionalities provided through the App.\n"User," "You," and "Your" refer to the individual accessing or using the App.\n"We," "Us," and "Our" refer to the company operating the App.',
            ),
            
            _buildSection(
              context,
              title: '3. Account Registration',
              content: 'To use certain features of the App, you must register for an account. You agree to provide accurate and complete information during registration and to update such information to keep it accurate and current.\nYou are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.',
            ),
            
            _buildSection(
              context,
              title: '4. Privacy Policy',
              content: 'Our Privacy Policy describes how we handle the information you provide to us when you use our Services. By using our Services, you agree that we can collect, use, and share your information in accordance with our Privacy Policy.',
            ),
            
            _buildSection(
              context,
              title: '5. User Conduct',
              content: 'You agree not to use the App for any illegal or unauthorized purpose.\nYou agree not to disrupt or interfere with the security or accessibility of the App.\nYou agree not to attempt to access accounts or data that you are not authorized to access.',
            ),
            
            _buildSection(
              context,
              title: '6. Financial Services',
              content: 'The financial services offered through our App are subject to additional terms and conditions which will be provided to you before you use such services.\nWe do not guarantee the accuracy of financial information displayed in the App and recommend verifying all information independently.',
            ),
            
            _buildSection(
              context,
              title: '7. Limitation of Liability',
              content: 'To the maximum extent permitted by law, we shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses resulting from your use of the App.',
            ),
            
            _buildSection(
              context,
              title: '8. Changes to Terms',
              content: 'We reserve the right to modify these Terms at any time. We will provide notice of significant changes by posting the new Terms on the App. Your continued use of the App after such modifications constitutes your acceptance of the modified Terms.',
            ),
            
            _buildSection(
              context,
              title: '9. Termination',
              content: 'We reserve the right to terminate or suspend your account and access to the App at our sole discretion, without notice, for conduct that we believe violates these Terms or is harmful to other users, us, or third parties, or for any other reason.',
            ),
            
            _buildSection(
              context,
              title: '10. Governing Law',
              content: 'These Terms shall be governed by and construed in accordance with the laws of the jurisdiction in which we operate, without regard to its conflict of law provisions.',
            ),
            
            SizedBox(height: 30.h),
            
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
                child: Text(
                  'I Understand',
                  style: GoogleFonts.outfit(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSection(BuildContext context, {required String title, required String content}) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            content,
            style: GoogleFonts.outfit(
              fontSize: 16.sp,
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
} 