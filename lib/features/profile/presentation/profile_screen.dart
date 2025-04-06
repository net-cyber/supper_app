import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/features/auth/domain/user/user_service.dart';
import 'package:super_app/core/application/app/bloc/app_bloc.dart';
import 'package:super_app/core/application/app/bloc/app_event.dart';
import 'package:super_app/core/application/app/bloc/app_state.dart';
import 'package:super_app/features/auth/domain/login/entities/login_response.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => previous.isDarkMode != current.isDarkMode,
      builder: (context, appState) {
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
      },
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
    final userService = getIt<UserService>();
    final LoginUser? user = userService.getCurrentUser();
    
    // Default values in case user data is not available
    final String displayName = user?.full_name ?? 'Guest User';
    final String username = user?.username ?? 'username';
    final String initials = _getInitials(displayName);
    
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
                initials,
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
            displayName,
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
            username,
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

  /// Get initials from full name (e.g. "John Doe" -> "JD")
  String _getInitials(String fullName) {
    if (fullName.isEmpty) return '';
    
    final nameParts = fullName.trim().split(' ');
    if (nameParts.isEmpty) return '';
    
    if (nameParts.length == 1) {
      return nameParts[0].isNotEmpty ? nameParts[0][0].toUpperCase() : '';
    }
    
    return '${nameParts[0][0]}${nameParts.last[0]}'.toUpperCase();
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
        _buildThemeToggleItem(context),
      ],
    );
  }
  
  Widget _buildThemeToggleItem(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => previous.isDarkMode != current.isDarkMode,
      builder: (context, state) {
        return InkWell(
          onTap: () {
            // Toggle theme directly when tapping the row
            final newThemeMode = !state.isDarkMode;
            context.read<AppBloc>().add(
              AppEvent.changeTheme(isDarkMode: newThemeMode),
            );
            
            // Show a feedback message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  newThemeMode ? 'Dark theme enabled' : 'Light theme enabled',
                  style: GoogleFonts.outfit(),
                ),
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: theme.colorScheme.primary,
              ),
            );
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
            child: Row(
              children: [
                Icon(
                  state.isDarkMode 
                    ? Icons.dark_mode
                    : Icons.light_mode_outlined,
                  size: 22.sp,
                  color: theme.iconTheme.color?.withOpacity(0.7),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dark Mode',
                        style: GoogleFonts.outfit(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: theme.textTheme.titleMedium?.color,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        state.isDarkMode ? 'On' : 'Off',
                        style: GoogleFonts.outfit(
                          fontSize: 12.sp,
                          color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: state.isDarkMode,
                  activeColor: theme.colorScheme.primary,
                  onChanged: (value) {
                    context.read<AppBloc>().add(
                      AppEvent.changeTheme(isDarkMode: value),
                    );
                    
                    // Show a feedback message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          value ? 'Dark theme enabled' : 'Light theme enabled',
                          style: GoogleFonts.outfit(),
                        ),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: theme.colorScheme.primary,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
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
        onPressed: () async {
          // Show confirmation dialog
          final shouldLogout = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Logout',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: Text(
                'Are you sure you want to logout?',
                style: GoogleFonts.outfit(),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.outfit(
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    'Logout',
                    style: GoogleFonts.outfit(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
          ) ?? false;

          if (shouldLogout) {
            // Get UserService from dependency injection and logout
            final userService = getIt<UserService>();
            await userService.logout();
            
            // Navigate to login screen
            if (context.mounted) {
              context.goNamed(RouteName.login);
            }
          }
        },
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
