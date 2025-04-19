import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/auth/application/verification/bloc/otp_verification_bloc.dart';

class OTPVerificationScreen extends StatelessWidget {

  const OTPVerificationScreen({
    super.key, 
    required this.phoneNumber,
    this.expiresAt,
  });
  final String phoneNumber;
  final DateTime? expiresAt;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OtpVerificationBloc>()
        ..add(PhoneNumberSet(phoneNumber)),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: Text(
            'Verify Your Number',
            style: GoogleFonts.outfit(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: const SafeArea(
          child: OTPVerificationBody(),
        ),
      ),
    );
  }
}

class OTPVerificationBody extends StatefulWidget {
  const OTPVerificationBody({super.key});

  @override
  State<OTPVerificationBody> createState() => _OTPVerificationBodyState();
}

class _OTPVerificationBodyState extends State<OTPVerificationBody> {
  final TextEditingController _otpController = TextEditingController();
  Timer? _resendTimer;
  int _secondsRemaining = 60;
  bool _timerActive = true;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    setState(() {
      _timerActive = true;
      _secondsRemaining = 60;
    });
    
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _timerActive = false;
        });
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return BlocConsumer<OtpVerificationBloc, OtpVerificationState>(
      listenWhen: (previous, current) => 
        previous.isVerified != current.isVerified ||
        previous.resendSuccess != current.resendSuccess,
      listener: (context, state) {
        if (state.isVerified) {
          // Navigate to success or home
          context.goNamed(RouteName.login);
        }
        
        if (state.resendSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Verification code resent successfully'),
              backgroundColor: Colors.green,
            ),
          );
          _startResendTimer();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Verification Code',
                style: GoogleFonts.outfit(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'We have sent a 6-digit verification code to your mobile number ${state.phoneNumber}',
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 32.h),
              
              // OTP input field
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: _otpController,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8.r),
                  fieldHeight: 56.h,
                  fieldWidth: 48.w,
                  activeFillColor: colorScheme.surfaceContainerHighest,
                  inactiveFillColor: colorScheme.surfaceContainerHighest,
                  selectedFillColor: colorScheme.surfaceContainerHighest,
                  activeColor: colorScheme.primary,
                  inactiveColor: colorScheme.outline,
                  selectedColor: colorScheme.primary,
                ),
                cursorColor: colorScheme.primary,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  context.read<OtpVerificationBloc>().add(OtpCodeChanged(value));
                },
              ),
              
              // Error message
              if (state.verificationError)
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    state.errorMessage,
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      color: Colors.red,
                    ),
                  ),
                ),
              
              SizedBox(height: 32.h),
              
              // Verify button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: state.isVerifying
                      ? null
                      : () => context.read<OtpVerificationBloc>().add(
                            const VerifyOtpSubmitted(),
                          ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: state.isVerifying
                      ? SizedBox(
                          height: 24.h,
                          width: 24.h,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : Text(
                          'Verify',
                          style: GoogleFonts.outfit(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              
              SizedBox(height: 24.h),
              
              // Resend button with timer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code? ",
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (_timerActive) Text(
                          "Resend in $_secondsRemaining sec",
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            color: colorScheme.primary.withOpacity(0.7),
                          ),
                        ) else GestureDetector(
                          onTap: state.isResending
                              ? null
                              : () => context.read<OtpVerificationBloc>().add(
                                    const ResendOtpRequested(),
                                  ),
                          child: Text(
                            state.isResending ? "Sending..." : "Resend",
                            style: GoogleFonts.outfit(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary,
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
} 