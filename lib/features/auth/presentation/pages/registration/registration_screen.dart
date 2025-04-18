import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:super_app/core/constants/app_constants.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/presentation/widgets/app_text_field.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/core/theme/app_colors.dart';
import 'package:super_app/core/utils/permission_handler_util.dart';
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
        child: const RegistrationView(),
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

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  // Use scroll controller like in login screen
  final ScrollController _scrollController = ScrollController();
  
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _referralCodeController = TextEditingController();
  
  final _imagePicker = ImagePicker();
  String? _selectedImagePath;
  
  @override
  void initState() {
    super.initState();
    
    // Add scroll listener
    _scrollController.addListener(() {
      setState(() {});
    });
  }
  
  @override
  void dispose() {
    _usernameController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _referralCodeController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // Function to handle taking a photo with camera
  Future<void> _takePhoto() async {
    final hasPermission = await PermissionHandlerUtil.requestCameraPermission(context);
    
    if (!hasPermission) {
      return;
    }
    
    try {
      final XFile? pickedImage = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      
      // Check if the widget is still mounted before using BuildContext
      if (!mounted) return;
      
      if (pickedImage != null) {
        setState(() {
          _selectedImagePath = pickedImage.path;
        });
        context.read<RegistrationBloc>().add(
          ProfilePhotoChanged(pickedImage.path),
        );
      }
    } catch (e) {
      // Check if the widget is still mounted before using BuildContext
      if (!mounted) return;
      PermissionHandlerUtil.showErrorDialog(
        context,
        'Camera Error',
        'Could not access camera. Please try again.',
      );
    }
  }
  
  // Function to handle choosing from gallery
  Future<void> _chooseFromGallery() async {
    final hasPermission = await PermissionHandlerUtil.requestPhotoLibraryPermission(context);
    
    if (!hasPermission) {
      return;
    }
    
    try {
      final XFile? pickedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );
      
      // Check if the widget is still mounted before using BuildContext
      if (!mounted) return;
      
      if (pickedImage != null) {
        setState(() {
          _selectedImagePath = pickedImage.path;
        });
        context.read<RegistrationBloc>().add(
          ProfilePhotoChanged(pickedImage.path),
        );
      }
    } catch (e) {
      // Check if the widget is still mounted before using BuildContext
      if (!mounted) return;
      PermissionHandlerUtil.showErrorDialog(
        context,
        'Gallery Error',
        'Could not access photo gallery. Please try again.',
      );
    }
  }
  
  // Show image source selection dialog
  void _showImageSourceSelectionDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Select Image Source',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_rounded),
                title: Text('Take a Photo', style: GoogleFonts.outfit()),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_rounded),
                title: Text('Choose from Gallery', style: GoogleFonts.outfit()),
                onTap: () {
                  Navigator.pop(context);
                  _chooseFromGallery();
                },
              ),
              if (_selectedImagePath != null)
                ListTile(
                  leading: const Icon(Icons.delete_outline_rounded, color: Colors.red),
                  title: Text('Remove Photo', style: GoogleFonts.outfit(color: Colors.red)),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedImagePath = null;
                    });
                    context.read<RegistrationBloc>().add(
                      const ProfilePhotoChanged(null),
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
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
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        
        return Scaffold(
          backgroundColor: colorScheme.surface,
          body: Stack(
            children: [
              // Decorative background elements like in login screen
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
                            // Logo with same layout as login screen
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                              colorScheme.primary.withOpacity(0.5),
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
                            
                            // Title and subtitle with similar styling
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create an Account',
                                  style: GoogleFonts.outfit(
                                    fontSize: theme.textTheme.headlineSmall?.fontSize,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.5,
                                    color: colorScheme.onBackground,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'Sign up to continue',
                                  style: GoogleFonts.outfit(
                                    fontSize: theme.textTheme.bodyLarge?.fontSize,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: 30.h),
                            
                            // Profile Photo Selection
                            Center(
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: _showImageSourceSelectionDialog,
                                    child: Container(
                                      width: 120.w,
                                      height: 120.w,
                                      decoration: BoxDecoration(
                                        color: colorScheme.surfaceVariant.withOpacity(0.3),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: colorScheme.primary.withOpacity(0.5),
                                          width: 2,
                                        ),
                                        image: _selectedImagePath != null
                                            ? DecorationImage(
                                                image: FileImage(File(_selectedImagePath!)),
                                                fit: BoxFit.cover,
                                              )
                                            : null,
                                      ),
                                      child: _selectedImagePath == null
                                          ? Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.add_a_photo_outlined,
                                                  size: 40.sp,
                                                  color: colorScheme.primary.withOpacity(0.8),
                                                ),
                                                SizedBox(height: 8.h),
                                                Text(
                                                  'Add Photo',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 14.sp,
                                                    color: colorScheme.primary,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : null,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Profile Photo',
                                    style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  // Error message for profile photo if any
                                  if (RegistrationFormValidator.validateProfilePhoto(state) != null)
                                    Padding(
                                      padding: EdgeInsets.only(top: 4.h),
                                      child: Text(
                                        RegistrationFormValidator.validateProfilePhoto(state)!,
                                        style: GoogleFonts.outfit(
                                          fontSize: 12.sp,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            
                            SizedBox(height: 30.h),
                            
                            // Form fields using AppTextField like login screen
                            AppTextField(
                              controller: _usernameController,
                              hintText: 'Username',
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                context.read<RegistrationBloc>().add(
                                  UserNameChanged(value),
                                );
                              },
                              errorText: RegistrationFormValidator.validateUserName(state),
                            ),
                            SizedBox(height: 16.h),
                            
                            AppTextField(
                              controller: _fullNameController,
                              hintText: 'Full Name',
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                context.read<RegistrationBloc>().add(
                                  FullNameChanged(value),
                                );
                              },
                              errorText: RegistrationFormValidator.validateFullName(state),
                            ),
                            SizedBox(height: 16.h),
                            
                            AppTextField(
                              controller: _phoneController,
                              hintText: 'Phone Number',
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                context.read<RegistrationBloc>().add(
                                  PhoneNumberChanged(value),
                                );
                              },
                              errorText: RegistrationFormValidator.validatePhoneNumber(state),
                            ),
                            
                            SizedBox(height: 16.h),
                            
                            AppTextField(
                              controller: _passwordController,
                              hintText: 'Password',
                              obscureText: !state.showPassword,
                              onChanged: (value) {
                                context.read<RegistrationBloc>().add(
                                  PasswordChanged(value),
                                );
                              },
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                  color: colorScheme.onSurfaceVariant,
                                  size: 20.sp,
                                ),
                                onPressed: () {
                                  context.read<RegistrationBloc>().add(
                                    const ToggleShowPassword(),
                                  );
                                },
                              ),
                              errorText: RegistrationFormValidator.validatePassword(state),
                            ),
                            
                            // Password strength indicator
                            if (state.password.isValid()) ...[
                              SizedBox(height: 8.h),
                              LinearProgressIndicator(
                                value: state.passwordStrength,
                                backgroundColor: Colors.grey[300],
                                color: _getStrengthColor(state.passwordStrength),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Password strength: ${_getStrengthText(state.passwordStrength)}',
                                style: GoogleFonts.outfit(
                                  fontSize: 12.sp,
                                  color: _getStrengthColor(state.passwordStrength),
                                ),
                              ),
                            ],
                            SizedBox(height: 16.h),
                            
                            AppTextField(
                              controller: _confirmPasswordController,
                              hintText: 'Confirm Password',
                              obscureText: !state.showConfirmPassword,
                              onChanged: (value) {
                                context.read<RegistrationBloc>().add(
                                  ConfirmPasswordChanged(value),
                                );
                              },
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.showConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                  color: colorScheme.onSurfaceVariant,
                                  size: 20.sp,
                                ),
                                onPressed: () {
                                  context.read<RegistrationBloc>().add(
                                    const ToggleShowConfirmPassword(),
                                  );
                                },
                              ),
                              errorText: RegistrationFormValidator.validateConfirmPassword(state),
                            ),
                           
                            SizedBox(height: 16.h),
                            
                            // Terms and Conditions with similar formatting
                            Row(
                              children: [
                                Switch(
                                  value: state.termsAcceptance.value.getOrElse(() => false),
                                  onChanged: (value) {
                                    context.read<RegistrationBloc>().add(
                                      TermsAcceptedChanged(value),
                                    );
                                  },
                                  activeColor: colorScheme.primary,
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
                                            color: colorScheme.primary,
                                            fontWeight: FontWeight.w500,
                                            decoration: TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              context.pushNamed(RouteName.termsAndConditionsScreen);
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
                            
                            SizedBox(height: 40.h),
                            
                            // Register Button with same styling as login button
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
                            
                            SizedBox(height: 60.h),
                            
                            // Login option
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: GoogleFonts.outfit(
                                    fontSize: theme.textTheme.bodyMedium?.fontSize,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => context.goNamed(RouteName.login),
                                  style: TextButton.styleFrom(
                                    foregroundColor: colorScheme.primary,
                                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0),
                                    minimumSize: Size(0, 30.h),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    'Sign In',
                                    style: GoogleFonts.outfit(
                                      fontSize: theme.textTheme.bodyMedium?.fontSize,
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
                                color: colorScheme.surfaceVariant.withOpacity(0.3),
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
                                        fontSize: theme.textTheme.bodySmall?.fontSize,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            SizedBox(height: 40.h),
                            
                            // Footer
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
                                      margin: EdgeInsets.symmetric(horizontal: 16.w),
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
                                    color: colorScheme.onSurfaceVariant.withOpacity(0.5),
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
}

// Helper method to build footer item - same as login screen
Widget _buildFooterItem({required BuildContext context, required String title, required String value}) {
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