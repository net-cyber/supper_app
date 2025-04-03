import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/constants/app_constants.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/core/theme/app_colors.dart';
import 'package:super_app/features/auth/application/registration/bloc/registration_bloc.dart';
import 'package:super_app/features/auth/application/registration/bloc/registration_event.dart';
import 'package:super_app/features/auth/application/registration/bloc/registration_state.dart';
import 'package:super_app/features/auth/application/registration/registration_form_validator.dart';
import 'package:super_app/features/auth/presentation/pages/terms/terms_and_conditions_screen.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure dependencies are configured
    try {
      return BlocProvider(
        create: (context) => getIt<RegistrationBloc>(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SafeArea(
            child: const RegistrationBody(),
          ),
        ),
      );
    } catch (e) {
      // If GetIt is not initialized yet, show an error message
      return Scaffold(
        body: Center(
          child: Text(
            'Dependency initialization error: $e',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }
}

class RegistrationBody extends StatefulWidget {
  const RegistrationBody({super.key});

  @override
  State<RegistrationBody> createState() => _RegistrationBodyState();
}

class _RegistrationBodyState extends State<RegistrationBody> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getStrengthColor(double strength) {
    if (strength <= 0.25) return Colors.red;
    if (strength <= 0.5) return Colors.orange;
    if (strength <= 0.75) return Colors.yellow;
    return Colors.green;
  }

  String _getStrengthText(double strength) {
    if (strength <= 0.25) return 'Weak';
    if (strength <= 0.5) return 'Medium';
    if (strength <= 0.75) return 'Good';
    return 'Strong';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listenWhen: (previous, current) => 
        previous.isRegistrationError != current.isRegistrationError,
      listener: (context, state) {
        if (state.isRegistrationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        } else if (!state.isLoading && !state.isRegistrationError && state.isFormValid) {
          // Registration successful
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration successful!'),
              backgroundColor: Colors.green,
            ),
          );
          // Navigate to next screen
          context.goNamed(RouteName.login);
        }
      },
      builder: (context, state) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        final colorScheme = Theme.of(context).colorScheme;
        
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30.h),
                    
                    // Logo with animation
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.8, end: 1.0),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Image.asset(
                            AppConstants.gohbetochLogoHorizontal,
                            width: 180.w,
                            height: 120.h,
                          ),
                        );
                      },
                    ),
                    
                    SizedBox(height: 20.h),
                    
                    // Title and subtitle
                    Text(
                      'Create an Account',
                      style: GoogleFonts.outfit(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    
                    SizedBox(height: 8.h),
                    
                    Text(
                      'Secure and fast registration to manage your finances',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    
                    SizedBox(height: 30.h),
                    
                    // Form fields in card layout
                    Container(
                      decoration: BoxDecoration(
                        color: isDarkMode ? colorScheme.surfaceContainerHighest : colorScheme.surface,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        children: [
                          // Username field
                          _buildTextField(
                            label: 'User Name',
                            hint: 'Enter your username',
                            icon: Icons.person_outline,
                            onChanged: (value) {
                              context.read<RegistrationBloc>().add(
                                UserNameChanged(value),
                              );
                            },
                            errorText: RegistrationFormValidator.validateUserName(state),
                          ),
                          
                          SizedBox(height: 20.h),
                          
                          // Full Name field
                          _buildTextField(
                            label: 'Full Name',
                            hint: 'Enter your full name',
                            icon: Icons.person_outline,
                            onChanged: (value) {
                              context.read<RegistrationBloc>().add(
                                FullNameChanged(value),
                              );
                            },
                            errorText: RegistrationFormValidator.validateFullName(state),
                          ),
                          
                          SizedBox(height: 20.h),
                          
                          // Phone Number field
                          _buildTextField(
                            label: 'Phone Number',
                            hint: 'Enter your phone number',
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              context.read<RegistrationBloc>().add(
                                PhoneNumberChanged(value),
                              );
                            },
                            errorText: RegistrationFormValidator.validatePhoneNumber(state),
                          ),
                          
                          SizedBox(height: 20.h),
                          
                          // Email field
                          _buildTextField(
                            label: 'Email Address',
                            hint: 'Enter your email address',
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              context.read<RegistrationBloc>().add(
                                EmailChanged(value),
                              );
                            },
                            errorText: RegistrationFormValidator.validateEmail(state),
                          ),
                          
                          SizedBox(height: 20.h),
                          
                          // Password field with strength indicator
                          _buildTextField(
                            label: 'Password',
                            hint: 'Enter a strong password',
                            icon: Icons.lock_outlined,
                            obscureText: !state.showPassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                state.showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                context.read<RegistrationBloc>().add(
                                  const ToggleShowPassword(),
                                );
                              },
                            ),
                            onChanged: (value) {
                              context.read<RegistrationBloc>().add(
                                PasswordChanged(value),
                              );
                            },
                            errorText: RegistrationFormValidator.validatePassword(state),
                          ),
                          
                          // Password strength indicator
                          if (state.password.isValid()) ...[
                            SizedBox(height: 8.h),
                            LinearProgressIndicator(
                              value: state.passwordStrength,
                              backgroundColor: Colors.grey[300],
                              color: state.passwordStrength < 0.25
                                  ? Colors.red
                                  : state.passwordStrength < 0.5
                                      ? Colors.orange
                                      : state.passwordStrength < 0.75
                                          ? Colors.yellow
                                          : Colors.green,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              state.password.isValid()
                                  ? 'Password strength: ${(state.passwordStrength * 100).toInt()}%'
                                  : 'Enter a valid password',
                              style: TextStyle(
                                color: state.passwordStrength < 0.25
                                    ? Colors.red
                                    : state.passwordStrength < 0.5
                                        ? Colors.orange
                                        : state.passwordStrength < 0.75
                                            ? Colors.yellow
                                            : Colors.green,
                              ),
                            ),
                          ],
                          
                          // Confirm Password field
                          _buildTextField(
                            label: 'Confirm Password',
                            hint: 'Re-enter your password',
                            icon: Icons.check_circle_outline,
                            obscureText: !state.showConfirmPassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                state.showConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                context.read<RegistrationBloc>().add(
                                  const ToggleShowConfirmPassword(),
                                );
                              },
                            ),
                            onChanged: (value) {
                              context.read<RegistrationBloc>().add(
                                ConfirmPasswordChanged(value),
                              );
                            },
                            errorText: RegistrationFormValidator.validateConfirmPassword(state),
                          ),
                          
                          SizedBox(height: 20.h),
                          
                          // Referral Code field (optional)
                          _buildTextField(
                            label: 'Referral Code (Optional)',
                            hint: 'Enter referral code if you have one',
                            icon: Icons.card_giftcard_outlined,
                            onChanged: (value) {
                              context.read<RegistrationBloc>().add(
                                ReferralCodeChanged(value),
                              );
                            },
                            errorText: RegistrationFormValidator.validateReferralCode(state),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 20.h),
                    
                    // Terms and Conditions switch
                    Row(
                      children: [
                        Switch(
                          value: state.termsAcceptance.value.getOrElse(() => false),
                          onChanged: (value) {
                            context.read<RegistrationBloc>().add(
                              TermsAcceptedChanged(value),
                            );
                          },
                          activeColor: AppColors.primaryColor,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: 'I agree to the ',
                              style: GoogleFonts.outfit(
                                fontSize: 14.sp,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Terms & Conditions',
                                  style: GoogleFonts.outfit(
                                    fontSize: 14.sp,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.pushNamed(RouteName.termsAndConditionsScreen);
                                    },
                                ),
                                TextSpan(
                                  text: ' and ',
                                  style: GoogleFonts.outfit(
                                    fontSize: 14.sp,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: GoogleFonts.outfit(
                                    fontSize: 14.sp,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const TermsAndConditionsScreen(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (state.showErrorMessages && !state.termsAcceptance.isValid())
                      Padding(
                        padding: EdgeInsets.only(left: 16.w, top: 4.h),
                        child: Text(
                          RegistrationFormValidator.validateTermsAcceptance(state) ?? '',
                          style: GoogleFonts.outfit(
                            fontSize: 12.sp,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    
                    SizedBox(height: 30.h),
                    
                    // Register Button with gradient
                    SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: state.isLoading 
                          ? null 
                          : () {
                              context.read<RegistrationBloc>().add(
                                const RegistrationSubmitted(),
                              );
                            },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          foregroundColor: colorScheme.onPrimary,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                        ),
                        child: state.isLoading
                            ? SizedBox(
                                height: 24.h,
                                width: 24.h,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : Text(
                                'Register',
                                style: GoogleFonts.outfit(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    
                    SizedBox(height: 24.h),
                    
                    // Login option
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.goNamed(RouteName.login),
                          child: Text(
                            'Log in',
                            style: GoogleFonts.outfit(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    void Function(String)? onChanged,
    String? errorText,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: GoogleFonts.outfit(
            fontSize: 16.sp,
            color: colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.outfit(
              fontSize: 16.sp,
              color: colorScheme.onSurfaceVariant.withOpacity(0.7),
            ),
            prefixIcon: Icon(
              icon,
              color: colorScheme.onSurfaceVariant,
              size: 22.sp,
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: isDarkMode ? colorScheme.surfaceContainerHighest : colorScheme.surfaceVariant,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colorScheme.primary, width: 1.w),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            errorText: errorText,
            errorStyle: GoogleFonts.outfit(
              fontSize: 12.sp,
              color: Colors.red,
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
} 