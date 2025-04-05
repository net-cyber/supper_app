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
          body: const SafeArea(
            child: RegistrationBody(),
          ),
        ),
      );
    } catch (e) {
      // If GetIt is not initialized yet, show an error message
      return Scaffold(
        body: Center(
          child: Text(
            'Dependency initialization error: $e',
            style: const TextStyle(color: Colors.red),
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
    
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
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
        previous.verificationSent != current.verificationSent ||
        previous.isRegistrationError != current.isRegistrationError,
      listener: (context, state) {
        if (state.verificationSent && state.verificationResponse != null) {
          // Navigate to OTP verification screen
          context.pushNamed(
            RouteName.otpVerification,
            extra: {
              'phoneNumber': state.phoneNumber.value.getOrElse(() => ''),
              'expiresAt': state.verificationResponse!.expires_at,
            },
          );
        } else if (state.isRegistrationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
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
                  children: [
                    SizedBox(height: 30.h),
                    
                    // Logo with animation
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.8, end: 1),
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
                            errorText: RegistrationFormValidator.validatePassword(context.read<RegistrationBloc>().state),
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
                            errorText: RegistrationFormValidator.validateConfirmPassword(context.read<RegistrationBloc>().state),
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
                      child: state.isLoading 
                          ? const Center(child: CircularProgressIndicator())
                          : _ProfessionalButton(
                              onPressed: () {
                                context.read<RegistrationBloc>().add(
                                  const RegistrationSubmitted(),
                                );
                              },
                              label: 'Register',
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
            fillColor: isDarkMode ? colorScheme.surfaceContainerHighest : colorScheme.surfaceContainerHighest,
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
                  Icons.app_registration,
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