import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/constants/app_constants.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/core/utils/app_helpers.dart';
import 'package:super_app/core/presentation/widgets/app_button.dart';
import 'package:super_app/core/presentation/widgets/app_text_field.dart';
import 'package:super_app/features/auth/application/login/bloc/login_bloc.dart';
import 'package:super_app/features/auth/application/login/bloc/login_event.dart';
import 'package:super_app/features/auth/application/login/bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginBloc>(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Scroll controller for layout
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Scroll listener
    _scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.isLoginError != current.isLoginError,
      listener: (context, state) {
        if (!state.isLoading && !state.isLoginError) {
          context.go('/${RouteName.mainScreen}');
        } else if (!state.isLoading && state.isLoginError) {
          AppHelpers.showCheckFlash(
            context,
            'Login failed. Please check your credentials and try again.',
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: colorScheme.surface,
          body: Stack(
            children: [
              // Decorative background elements - subtle patterns
              Positioned(
                top: -100,
                right: -50,
                child: Container(
                  height: 200.h,
                  width: 200.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.primary.withOpacity(0.05),
                  ),
                ),
              ),
              Positioned(
                bottom: 100,
                left: -70,
                child: Container(
                  height: 180.h,
                  width: 180.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.secondary.withOpacity(0.07),
                  ),
                ),
              ),

              // Main content
              SafeArea(
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 60.h),
                            // Logo
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 80.h,
                                    width: 80.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        AppConstants.gohbetochLogoVertical,
                                        height: 70.h,
                                        width: 70.w,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  // Logo text
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "GOH BETOCH BANK",
                                        style: GoogleFonts.outfit(
                                          color: colorScheme.onBackground,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.5,
                                          height: 1.2,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Container(
                                        width: 120.w,
                                        height: 2.h,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              colorScheme.primary,
                                              colorScheme.primary
                                                  .withOpacity(0.5),
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        "Bank of the Generation",
                                        style: GoogleFonts.outfit(
                                          color: colorScheme.onSurfaceVariant,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 60.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome back',
                                  style: GoogleFonts.outfit(
                                    fontSize:
                                        theme.textTheme.headlineSmall?.fontSize,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.5,
                                    color: colorScheme.onBackground,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'Sign in to continue',
                                  style: GoogleFonts.outfit(
                                    fontSize:
                                        theme.textTheme.bodyLarge?.fontSize,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 40.h),

                            // Form fields
                            AppTextField(
                              controller: usernameController,
                              hintText: 'Username',
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) =>
                                  context.read<LoginBloc>().add(
                                        LoginEvent.usernameChanged(value),
                                      ),
                              errorText: state.showErrorMessages &&
                                      !state.username.isValid()
                                  ? 'Please enter a valid username'
                                  : null,
                            ),
                            SizedBox(height: 16.h),
                            AppTextField(
                              controller: passwordController,
                              hintText: 'Password',
                              obscureText: !state.showPassword,
                              onChanged: (value) =>
                                  context.read<LoginBloc>().add(
                                        LoginEvent.passwordChanged(value),
                                      ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.showPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: colorScheme.onSurfaceVariant,
                                  size: 20.sp,
                                ),
                                onPressed: () => context.read<LoginBloc>().add(
                                      const LoginEvent.toggleShowPassword(),
                                    ),
                              ),
                              errorText: state.showErrorMessages &&
                                      !state.password.isValid()
                                  ? 'Password must be at least 6 characters'
                                  : null,
                            ),
                            SizedBox(height: 16.h),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  // Navigate to forgot password screen
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: colorScheme.primary,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  minimumSize: Size(0, 36.h),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.outfit(
                                    fontSize:
                                        theme.textTheme.bodyMedium?.fontSize,
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 40.h),

                            // Sign in button
                            SizedBox(
                              width: double.infinity,
                              height: 56.h,
                              child: state.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : _ProfessionalButton(
                                      onPressed: () {
                                        context.read<LoginBloc>().add(
                                              const LoginEvent.loginSubmitted(),
                                            );
                                      },
                                      label: 'Sign In',
                                    ),
                            ),

                            SizedBox(height: 60.h),

                            // Sign up option
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: GoogleFonts.outfit(
                                    fontSize:
                                        theme.textTheme.bodyMedium?.fontSize,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.pushNamed(
                                        RouteName.registrationScreen);
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: colorScheme.primary,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 0),
                                    minimumSize: Size(0, 30.h),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    'Sign Up',
                                    style: GoogleFonts.outfit(
                                      fontSize:
                                          theme.textTheme.bodyMedium?.fontSize,
                                      color: colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 30.h),

                            // Security notice
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    colorScheme.surfaceVariant.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: colorScheme.outlineVariant,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.security_outlined,
                                    size: 18.sp,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      'Secure banking with end-to-end encryption',
                                      style: GoogleFonts.outfit(
                                        fontSize:
                                            theme.textTheme.bodySmall?.fontSize,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 40.h),

                            // Professional footer with banking details
                            Column(
                              children: [
                                Divider(
                                  color: colorScheme.outlineVariant,
                                  thickness: 1,
                                ),
                                SizedBox(height: 16.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildFooterItem(
                                      context: context,
                                      title: 'SWIFT CODE',
                                      value: 'GOBTETAA',
                                    ),
                                    Container(
                                      height: 24.h,
                                      width: 1,
                                      color: colorScheme.outlineVariant,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                    ),
                                    _buildFooterItem(
                                      context: context,
                                      title: 'CUSTOMER SERVICE',
                                      value: '+251-116-687967',
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  "© 2024 Goh Betoch Bank. All rights reserved.",
                                  style: GoogleFonts.outfit(
                                    fontSize: 10.sp,
                                    color: colorScheme.onSurfaceVariant
                                        .withOpacity(0.5),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                // Sign in to chat option
                                GestureDetector(
                                  onTap: () {
                                    // Navigate to chat screen or show chat dialog
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colorScheme.primaryContainer
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                        color: colorScheme.primary
                                            .withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.chat_outlined,
                                          size: 16.sp,
                                          color: colorScheme.primary,
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          "Sign in to chat",
                                          style: GoogleFonts.outfit(
                                            fontSize: 12.sp,
                                            color: colorScheme.primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Professional button without animations
class _ProfessionalButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const _ProfessionalButton({
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14.r),
        splashColor: Colors.white.withOpacity(0.1),
        highlightColor: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primary,
                colorScheme.primary.withBlue(colorScheme.primary.blue + 15),
                colorScheme.primary.withRed(colorScheme.primary.red + 10),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
                spreadRadius: -5,
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 12.w),
                Text(
                  label,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(width: 12.w),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white.withOpacity(0.8),
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Helper method to build footer item
Widget _buildFooterItem(
    {required BuildContext context,
    required String title,
    required String value}) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: theme.textTheme.bodySmall?.fontSize,
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
      ),
      Text(
        value,
        style: GoogleFonts.outfit(
          fontSize: theme.textTheme.bodySmall?.fontSize,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    ],
  );
}
