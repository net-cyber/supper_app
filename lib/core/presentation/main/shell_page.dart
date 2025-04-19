import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class ShellPage extends StatelessWidget {
  const ShellPage({
    required this.navigationShell, super.key,
  });
  final StatefulNavigationShell navigationShell;

  void _onNavigationItemSelected(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.shadow.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  context,
                  HugeIcons.strokeRoundedHome01,
                  HugeIcons.strokeRoundedHome01,
                  'Home',
                  0,
                ),
                _buildNavItem(
                  context,
                  HugeIcons.strokeRoundedTransaction,
                  HugeIcons.strokeRoundedTransaction,
                  'History',
                  1,
                ),
                
                
                _buildNavItem(
                  context,
                  HugeIcons.strokeRoundedAccountSetting01,
                  HugeIcons.strokeRoundedAccountSetting01,
                  'Profile',
                  2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    IconData selectedIcon,
    String label,
    int index,
  ) {
    final theme = Theme.of(context);
    final isSelected = navigationShell.currentIndex == index;
    
    return InkWell(
      onTap: () => _onNavigationItemSelected(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(isSelected ? 12.w : 8.w),
            decoration: BoxDecoration(
              color: isSelected 
                ? theme.colorScheme.primary.withOpacity(0.1) 
                : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isSelected ? selectedIcon : icon,
              color: isSelected 
                ? theme.colorScheme.primary 
                : theme.colorScheme.onSurfaceVariant,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected 
                ? theme.colorScheme.primary 
                : theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}