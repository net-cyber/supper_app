import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_state.dart';
import 'package:super_app/features/history/presentation/pages/history_page.dart';

class ShellPage extends StatefulWidget {
  const ShellPage({
    required this.navigationShell, 
    super.key,
  });
  
  final StatefulNavigationShell navigationShell;

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  // This is called when the system puts the app in the background or returns it to the foreground
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // No special handling needed
  }
  
  void _onNavigationItemSelected(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: widget.navigationShell,
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
                // Home tab (index 0)
                _buildNavItem(
                  context,
                  HugeIcons.strokeRoundedHome01,
                  HugeIcons.strokeRoundedHome01,
                  'Home',
                  0,
                ),
                // Mortgage tab (index 1)
                _buildNavItem(
                  context,
                  HugeIcons.strokeRoundedBuilding01,
                  HugeIcons.strokeRoundedBuilding01,
                  'Mortgage',
                  1,
                ),
                
                // Transaction item - Direct navigation
                _buildTransactionNavItem(context),
                
                // Profile tab (index 2)
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
    final isSelected = widget.navigationShell.currentIndex == index;
    
    return InkWell(
      onTap: () {
        _onNavigationItemSelected(index);
      },
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

  Widget _buildTransactionNavItem(BuildContext context) {
    final theme = Theme.of(context);
    
    // Track current location to determine if we're on transaction history
    final currentLocation = GoRouterState.of(context).uri.path;
    final isSelected = currentLocation == '/${RouteName.history}';
    
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, accountsState) {
        // Get account ID from the first account (if available)
        final int accountId = accountsState.accounts.isNotEmpty 
            ? accountsState.accounts[0].id 
            : 0;
            
        return InkWell(
          // Navigate to transactions history screen with account ID
          onTap: () {
            if (accountId > 0) {
              // Pass account ID as extra parameter to history page
              context.pushNamed(
                RouteName.history,
                extra: {'accountId': accountId},
              );
            } else {
              // Show error dialog if no account is available
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('No Account Available'),
                  content: const Text(
                    'Please wait while we load your account information or try again later.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
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
                  Icons.receipt_long,
                  color: isSelected 
                    ? theme.colorScheme.primary 
                    : theme.colorScheme.onSurfaceVariant,
                  size: 24.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Transactions',
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
      },
    );
  }
}