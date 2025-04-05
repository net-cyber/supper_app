import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Profile',
          style: GoogleFonts.outfit(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: theme.textTheme.titleLarge?.color,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings_outlined, 
              color: theme.iconTheme.color?.withOpacity(0.6), 
              size: 24.sp
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              _buildProfileHeader(context),
              SizedBox(height: 40.h),
              _buildSectionTitle(context, 'Account'),
              SizedBox(height: 16.h),
              _buildMenuSection(context),
              SizedBox(height: 32.h),
              _buildSectionTitle(context, 'Preferences'),
              SizedBox(height: 16.h),
              _buildPreferencesSection(context),
              SizedBox(height: 32.h),
              _buildSectionTitle(context, 'About'),
              SizedBox(height: 16.h),
              _buildAboutSection(context),
              SizedBox(height: 40.h),
              _buildLogoutButton(context),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.primary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Center(
          child: Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'NS',
                style: GoogleFonts.outfit(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        Center(
          child: Text(
            'Natnael Seyoum',
            style: GoogleFonts.outfit(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: theme.textTheme.titleLarge?.color,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Center(
          child: Text(
            'natnael@gmail.com',
            style: GoogleFonts.outfit(
              fontSize: 14.sp,
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.colorScheme.primary,
                side: BorderSide(color: theme.colorScheme.primary.withOpacity(0.5)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                minimumSize: Size(120.w, 36.h),
              ),
              child: Text(
                'Edit Profile',
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Column(
      children: [
        _buildSimpleMenuItem(
          context,
          Icons.person_outline,
          'Personal Information',
          onTap: () {},
        ),
        _buildSimpleMenuItem(
          context,
          Icons.lock_outline,
          'Security',
          onTap: () {},
        ),
        _buildSimpleMenuItem(
          context,
          Icons.payment_outlined,
          'Payment Methods',
          onTap: () {},
        ),
      ],
    );
  }
  
  Widget _buildPreferencesSection(BuildContext context) {
    return Column(
      children: [
        _buildSimpleMenuItem(
          context,
          Icons.notifications_outlined,
          'Notifications',
          onTap: () {},
        ),
        _buildSimpleMenuItem(
          context,
          Icons.language_outlined,
          'Language',
          onTap: () {},
        ),
        _buildSimpleMenuItem(
          context,
          Icons.dark_mode_outlined,
          'Theme',
          onTap: () {},
        ),
      ],
    );
  }
  
  Widget _buildAboutSection(BuildContext context) {
    return Column(
      children: [
        _buildSimpleMenuItem(
          context,
          Icons.help_outline,
          'Help & Support',
          onTap: () {},
        ),
        _buildSimpleMenuItem(
          context,
          Icons.privacy_tip_outlined,
          'Privacy Policy',
          onTap: () {},
        ),
        _buildSimpleMenuItem(
          context,
          Icons.description_outlined,
          'Terms of Service',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSimpleMenuItem(
    BuildContext context, 
    IconData icon, 
    String title,
    {required VoidCallback onTap}
  ) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22.sp,
              color: theme.iconTheme.color?.withOpacity(0.7),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: theme.textTheme.titleMedium?.color,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14.sp,
              color: theme.iconTheme.color?.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(
          Icons.logout_rounded,
          size: 18.sp,
          color: theme.colorScheme.error,
        ),
        label: Text(
          'Log out',
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.error,
          ),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
        ),
      ),
    );
  }
}
