import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/constants/app_constants.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_event.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_state.dart';
import 'package:super_app/features/accounts/domain/entities/account.dart';
import 'dart:math' as Math;

import 'package:super_app/features/auth/domain/user/user_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  bool _isBalanceVisible = false;
  bool _isGohBetochLoading = false;
  int _currentAccountIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildBalanceCard(),
            SizedBox(height: 1.h),
            _buildPageIndicator(),
            SizedBox(height: 24.h),
            _buildQuickActions(),
            SizedBox(height: 32.h),
            _buildServiceCategories(),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 2,
      title: Row(
        children: [
          Image.asset(
            AppConstants.gohbetochLogoVertical,
            width: 58.w,
            height: 58.h,
          ),
          SizedBox(width: 12.w),
          Text(
            'GOH Supper App',
            style: GoogleFonts.outfit(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon:
              Icon(Icons.refresh_rounded, color: Colors.grey[800], size: 22.sp),
          onPressed: () {},
        ),
        IconButton(
          icon: Badge(
            label: Text('2'),
            child: Icon(Icons.notifications_none_rounded,
                color: Colors.grey[800], size: 22.sp),
          ),
          onPressed: () {},
        ),
        SizedBox(width: 8.w),
      ],
    );
  }

  Widget _buildBalanceCard() {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          height: 290.h,
          child: Stack(
            children: [
              // PageView for horizontal scrolling of account cards
              PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentAccountIndex = index;
                  });
                },
                itemCount: state.accounts.isEmpty ? 1 : state.accounts.length,
                itemBuilder: (context, index) {
                  // When accounts are loaded, display account data
                  if (state.accounts.isNotEmpty) {
                    final account = state.accounts[index];
                    return _buildAccountCard(account, _currentAccountIndex);
                  } 
                  // When loading or no accounts, display placeholder
                  return _buildAccountCardPlaceholder(state);
                },
              ),
              
              // Account page indicator (dots)
              if (state.accounts.length > 1)
                Positioned(
                  bottom: 8.h,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      state.accounts.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: index == _currentAccountIndex ? 24.w : 8.w,
                        height: 8.h,
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        decoration: BoxDecoration(
                          color: index == _currentAccountIndex
                              ? Colors.white
                              : Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAccountCard(Account account, int currentAccountIndex) {
    // Set color to match SOL card's black background
    final Color cardBaseColor =currentAccountIndex % 2 == 1 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary;
    final userDetail = getIt<UserService>().getCurrentUser();
    return Container(
      decoration: BoxDecoration(
        color: cardBaseColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background branding "SOL" as large faded text
          Positioned(
            right: 0,
            top: 20.h,
            bottom: 20.h,
            child: Opacity(
              opacity: 0.07,
              child: CustomPaint(
                painter: CardPatternPainter(),
              ),
            ),
          ),

          // Decorative elements
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    Theme.of(context).colorScheme.secondary.withOpacity(0.15),
              ),
            ),
          ),

          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          // Card content
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SOL Card branding and Virtual label
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppConstants.gohbetochLogoVertical,
                          width: 24.w,
                          height: 24.h,
                          color: Colors.white,
                        ),
                        SizedBox(width: 12.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            account.currency,
                            style: GoogleFonts.outfit(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                   
                  ],
                ),

                const Spacer(),

                // Card number
                Text(
                  _isBalanceVisible
                      ? '1288 7068 2260 2640'
                      : '•••• •••• •••• ••••',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),

                SizedBox(height: 16.h),

                // Cardholder name and expiry date
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'ACCOUNT HOLDER',
                            style: GoogleFonts.outfit(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.7),
                              letterSpacing: 0.8,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            _isBalanceVisible
                                ? account.owner.toUpperCase()
                                : '••••••••••',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // GOH logo (replacing VISA)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        'GOH',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
                
            
                
               
              ],
            ),
          ),

          // Tap to show/hide button
          Positioned(
            top: 12.h,
            right: 12.w,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isBalanceVisible = !_isBalanceVisible;
                });
              },
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  ),
                  SizedBox(height: 3.h),
                   Text(
                     _isBalanceVisible ? 'Hide' : 'Show' ,
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountCardPlaceholder(AccountsState state) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          // Background pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: CustomPaint(
                painter: CardPatternPainter(),
              ),
            ),
          ),
          
          // Card content
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Bank logo/loading indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AppConstants.gohbetochLogoVertical,
                          width: 24.w,
                          height: 24.h,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'ACCOUNT',
                            style: GoogleFonts.outfit(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Balance indicator
                    if (state.isLoading)
                      SizedBox(
                        width: 16.w,
                        height: 16.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.w,
                          color: Colors.white,
                        ),
                      )
                    else if (state.hasError)
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Icon(
                          Icons.refresh_rounded, 
                          color: Colors.white,
                          size: 16.sp,
                        ),
                        onPressed: () {
                          context.read<AccountsBloc>().add(
                            const AccountsEvent.refreshAccounts(),
                          );
                        },
                      )
                  ],
                ),
                
                // Placeholder content - middle section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Card number placeholder
                    Text(
                      '•••• •••• •••• ••••',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    
                    SizedBox(height: 8.h),
                    
                    Text(
                      'AVAILABLE BALANCE',
                      style: GoogleFonts.outfit(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.7),
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      state.hasError ? 'Error loading' : '••••••',
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                
                // Placeholder for account holder - bottom section
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'CARDHOLDER',
                          style: GoogleFonts.outfit(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.7),
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          '••••••••••',
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return BlocBuilder<AccountsBloc, AccountsState>(
      builder: (context, state) {
        // If no accounts, don't show any indicators
        if (state.accounts.isEmpty) {
          return SizedBox(height: 34.h);
        }

        // Get current account and next/previous account if available
        final currentAccount = state.accounts[_currentAccountIndex];
        final prevAccountIndex = (_currentAccountIndex - 1).clamp(0, state.accounts.length - 1);
        final nextAccountIndex = (_currentAccountIndex + 1).clamp(0, state.accounts.length - 1);
        
        // Get the alternate account (either prev or next, depending on which side is selected)
        final alternateAccount = _currentAccountIndex % 2 == 0 
            ? state.accounts[nextAccountIndex] 
            : state.accounts[prevAccountIndex];
        
        // Selected option (0 = left, 1 = right)
        final bool isRightSelected = _currentAccountIndex % 2 == 1;

        return Container(
          height: 42.h,
          margin: EdgeInsets.symmetric(vertical: 10.h),
          child: Center(
            child: Container(
              width: 0.72.sw,
              height: 36.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E8E8),
                borderRadius: BorderRadius.circular(18.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    offset: const Offset(0, 1),
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
              ),
              padding: EdgeInsets.all(3.w),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Left button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (isRightSelected && state.accounts.isNotEmpty) {
                          // Switch to the account shown on left
                          _pageController.animateToPage(
                            prevAccountIndex,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutCubic,
                          );
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: !isRightSelected 
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(15.r),
                          boxShadow: !isRightSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                    spreadRadius: 0,
                                  ),
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            isRightSelected 
                                ? alternateAccount.currency
                                : currentAccount.currency,
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[700],
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Right button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (!isRightSelected && state.accounts.isNotEmpty) {
                          // Switch to the account shown on right
                          _pageController.animateToPage(
                            nextAccountIndex,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutCubic,
                          );
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: isRightSelected 
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(15.r),
                          boxShadow: isRightSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                    spreadRadius: 0,
                                  ),
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            isRightSelected 
                                ? currentAccount.currency
                                : alternateAccount.currency,
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[700],
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {
        'icon': Icons.account_balance_rounded,
        'label': 'Send To\nGoh Betoch',
        'color': Theme.of(context).colorScheme.primary,
        'route': RouteName.internalBankAccount,
      },
      {
        'icon': Icons.swap_horiz_rounded,
        'label': 'Send To\nOther Bank',
        'color': Theme.of(context).colorScheme.primary,
        'route': RouteName.bankSelection,
      },
      {
        'icon': Icons.home_work_rounded,
        'label': 'My\nMortgages',
        'color': Theme.of(context).colorScheme.primary,
        'route': RouteName.mortgageDashboard,
      },
      {
        'icon': Icons.account_balance_wallet_rounded,
        'label': 'Send To\nWallet',
        'color': Theme.of(context).colorScheme.primary,
        'route': RouteName.walletSelection,
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: actions.map((action) {
          return _buildActionItem(
            icon: action['icon']! as IconData,
            label: action['label']! as String,
            color: action['color']! as Color,
            route: action['route']! as String,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String label,
    required Color color,
    required String route,
  }) {
    final bool isGohBetoch = label.contains('Goh Betoch');
    final bool isLoading = isGohBetoch && _isGohBetochLoading;

    return GestureDetector(
      onTap: () {
        // Prevent multiple taps during loading
        if (_isGohBetochLoading) return;

        // Special handling for Goh Betoch button
        if (isGohBetoch) {
          setState(() {
            _isGohBetochLoading = true;
          });

          // Add a small delay to show loading state
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              context.pushNamed(route).then((_) {
                // Reset loading state when navigation completes or user returns
                if (mounted) {
                  setState(() {
                    _isGohBetochLoading = false;
                  });
                }
              });
            }
          });
        } else {
          // Normal navigation for other buttons
          context.pushNamed(route);
        }
      },
      child: Column(
        children: [
          Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color,
                  color.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(22.r),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                  spreadRadius: 0.5,
                ),
              ],
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.w,
                      ),
                    )
                  : Icon(
                      icon,
                      color: Colors.white,
                      size: 26.sp,
                    ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            isLoading ? 'Loading...' : label,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCategories() {
    final services = [
      {
        'icon': Icons.home_rounded,
        'label': 'Mortgage Loans',
        'color': Color(0xFF4A6FE5),
        'route': RouteName.availableProperties,
      },
      {
        'icon': Icons.account_balance_rounded,
        'label': 'Deposits',
        'color': Color(0xFF2EC4B6),
        'route': RouteName.availableProperties,
      },
      {
        'icon': Icons.person_rounded,
        'label': 'Personal Loans',
        'color': Color(0xFFFF9F1C),
        'route': RouteName.availableProperties,
      },
      {
        'icon': Icons.directions_car_rounded,
        'label': 'Vehicle Loans',
        'color': Color(0xFFE71D36),
        'route': RouteName.availableProperties,
      },
      {
        'icon': Icons.home_repair_service_rounded,
        'label': 'Home Equity',
        'color': Color(0xFF8338EC),
        'route': RouteName.availableProperties,
      },
      {
        'icon': Icons.chair_rounded,
        'label': 'Furniture Loans',
        'color': Color(0xFF3A86FF),
        'route': RouteName.availableProperties,
      },
      {
        'icon': Icons.apartment_rounded,
        'label': 'Construction',
        'color': Color(0xFFFF006E),
        'route': RouteName.availableProperties,
      },
      {
        'icon': Icons.business_rounded,
        'label': 'Commercial',
        'color': Color(0xFF06D6A0),
        'route': RouteName.availableProperties,
      },
      {
        'icon': Icons.public_rounded,
        'label': 'International',
        'color': Color(0xFFFFBE0B),
        'route': RouteName.availableProperties,
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.w, bottom: 16.h),
            child: Row(
              children: [
                Text(
                  'Bank Services',
                  style: GoogleFonts.outfit(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'View All',
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(Icons.arrow_forward_rounded, size: 16.sp),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.88,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 20.h,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              return _buildServiceItem(
                  icon: services[index]['icon'] as IconData,
                  label: services[index]['label'] as String,
                  color: services[index]['color'] as Color,
                  route: services[index]['route'] as String);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem({
    required IconData icon,
    required String label,
    required Color color,
    required String route,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.pushNamed(route);
        },
        borderRadius: BorderRadius.circular(24.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color,
                      color.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18.r),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChipPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.amber.shade800.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Draw horizontal lines
    for (var i = 0; i < 6; i++) {
      final y = i * size.height / 5;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }

    // Draw vertical lines
    for (var i = 0; i < 8; i++) {
      final x = i * size.width / 7;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Draw diagonal lines for circuit-like pattern
    paint.strokeWidth = 0.7;
    canvas.drawLine(
      Offset(size.width * 0.2, 0),
      Offset(size.width * 0.8, size.height),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.8, 0),
      Offset(size.width * 0.2, size.height),
      paint,
    );

    // Draw small rectangles to simulate chip contacts
    paint.style = PaintingStyle.fill;
    paint.color = Colors.amber.shade900.withOpacity(0.3);

    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.1, size.height * 0.2, size.width * 0.3,
          size.height * 0.2),
      paint,
    );

    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.6, size.height * 0.6, size.width * 0.3,
          size.height * 0.2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CardPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Draw subtle grid lines
    for (var i = 0; i < 10; i++) {
      // Horizontal lines
      canvas.drawLine(
        Offset(0, i * size.height / 9),
        Offset(size.width, i * size.height / 9),
        paint,
      );

      // Vertical lines
      canvas.drawLine(
        Offset(i * size.width / 9, 0),
        Offset(i * size.width / 9, size.height),
        paint,
      );
    }

    // Draw decorative circles
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 0.8;

    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.2),
      size.width * 0.15,
      paint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.8),
      size.width * 0.1,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
