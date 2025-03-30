import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/constants/app_constants.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/core/theme/app_colors.dart';
import 'package:super_app/features/auth/presentation/pages/terms/terms_and_conditions_screen.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: const RegistrationBody(),
      ),
    );
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
  
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _referralCodeController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _termsAccepted = false;
  bool _isLoading = false;
  
  double _passwordStrength = 0.0;
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
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _referralCodeController.dispose();
    super.dispose();
  }

  void _updatePasswordStrength(String password) {
    double strength = 0.0;
    
    // Simple password strength calculation
    if (password.length >= 8) strength += 0.25;
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.25;
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.25;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.25;
    
    setState(() {
      _passwordStrength = strength;
    });
  }

  Color _getStrengthColor() {
    if (_passwordStrength <= 0.25) return Colors.red;
    if (_passwordStrength <= 0.5) return Colors.orange;
    if (_passwordStrength <= 0.75) return Colors.yellow;
    return Colors.green;
  }

  String _getStrengthText() {
    if (_passwordStrength <= 0.25) return 'Weak';
    if (_passwordStrength <= 0.5) return 'Medium';
    if (_passwordStrength <= 0.75) return 'Good';
    return 'Strong';
  }

  @override
  Widget build(BuildContext context) {
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
                      // Full Name field
                      _buildTextField(
                        controller: _fullNameController,
                        label: 'User Name',
                        hint: 'Enter Your user name',
                        icon: Icons.person_outline,
                      ),
                      
                      SizedBox(height: 20.h),
                      // Full Name field
                      _buildTextField(
                        controller: _fullNameController,
                        label: 'Full Name',
                        hint: 'Enter your full name',
                        icon: Icons.person_outline,
                      ),
                      
                      SizedBox(height: 20.h),
                      
                      // Phone Number field
                      _buildTextField(
                        controller: _phoneController,
                        label: 'Phone Number',
                        hint: 'Enter your phone number',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                      
                     
                      SizedBox(height: 20.h),
                      
                      // Password field with strength indicator
                      _buildTextField(
                        controller: _passwordController,
                        label: 'Password',
                        hint: 'Enter a strong password',
                        icon: Icons.lock_outlined,
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        onChanged: (value) {
                          _updatePasswordStrength(value);
                        },
                      ),
                      
                      // Password strength indicator
                      if (_passwordController.text.isNotEmpty) ...[
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.r),
                                child: LinearProgressIndicator(
                                  value: _passwordStrength,
                                  backgroundColor: colorScheme.outlineVariant,
                                  color: _getStrengthColor(),
                                  minHeight: 5.h,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              _getStrengthText(),
                              style: GoogleFonts.outfit(
                                fontSize: 12.sp,
                                color: _getStrengthColor(),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                      ],
                      
                      // Confirm Password field
                      _buildTextField(
                        controller: _confirmPasswordController,
                        label: 'Confirm Password',
                        hint: 'Re-enter your password',
                        icon: Icons.check_circle_outline,
                        obscureText: _obscureConfirmPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      
                      SizedBox(height: 20.h),
                      

                    ],
                  ),
                ),
                
                SizedBox(height: 20.h),
                
                // Terms and Conditions switch
                Row(
                  children: [
                    Switch(
                      value: _termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          _termsAccepted = value;
                        });
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
                
                SizedBox(height: 30.h),
                
                // Register Button with gradient
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: _termsAccepted ? () {
                      setState(() {
                        _isLoading = !_isLoading;
                      });
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                    ),
                    child: _isLoading
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
                    Text(
                      'Log in',
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
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
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    void Function(String)? onChanged,
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
          controller: controller,
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
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
} 