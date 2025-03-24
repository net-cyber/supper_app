import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:super_app/features/auth/application/signup/bloc/signup_bloc.dart';
import 'package:super_app/features/auth/application/signup/bloc/signup_event.dart';
import 'package:super_app/core/constants/app_constants.dart';
import 'package:super_app/core/presentation/widgets/buttons/text_elevated_button.dart';
import 'package:super_app/core/presentation/widgets/text_fields/outline_bordered_text_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  bool termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => SignupBloc(),
        child: const SignupBody(),
      ),
    );
  }
}

class SignupBody extends StatelessWidget {
  const SignupBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40.h),
              // Back Button
              IconButton(
                alignment: Alignment.centerLeft,
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),

              // Logo
              Image.asset(
                AppConstants.gohbetochLogoHorizontal,
                width: 150.w,
                height: 150.h,
              ),

              SizedBox(height: 30.h),
              Form(
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Form Fields
                      Text(
                        'Country',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.w,
                          ),
                        ),
                        child: CountryCodePicker(
                          onChanged: (country) {
                            context.read<SignupBloc>().add(SignupEvent.countryChanged(country.name ?? ''));
                          },
                          initialSelection: 'ET', // Ethiopia as default
                          favorite: const ['ET', 'US'],
                          showCountryOnly: true,
                          showOnlyCountryWhenClosed: true,
                          alignLeft: true,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          dialogSize: Size(
                              MediaQuery.of(context).size.width * 0.9,
                              MediaQuery.of(context).size.height * 0.8,),
                          searchDecoration: InputDecoration(
                            hintText: 'Search country',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 10.h,),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),
                      Text(
                        'Full Name',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      OutlinedBorderTextField(
                        label: 'Enter your full name',
                        onChanged: (value) =>
                            context.read<SignupBloc>().add(SignupEvent.fullNameChanged(value)),
                        validator: (_) =>
                            context.read<SignupBloc>().state.fullName.value.fold(
                                  (failure) => failure.maybeWhen(
                                    empty: (msg) => msg,
                                    invalidName: (msg) => msg,
                                    orElse: () => 'Invalid full name',
                                  ),
                                  (success) => null,
                                ),
                      ),

                      SizedBox(height: 20.h),
                      Text(
                        'Email Address',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      OutlinedBorderTextField(
                        label: 'Enter your email',
                        onChanged: (value) =>
                            context.read<SignupBloc>().add(SignupEvent.emailChanged(value)),
                        validator: (_) =>
                            context.read<SignupBloc>().state.email.value.fold(
                                  (failure) => failure.maybeWhen(
                                    empty: (msg) => msg,
                                    invalidEmail: (msg) => msg,
                                    multiline: (msg) => msg,
                                    orElse: () => 'Invalid email',
                                  ),
                                  (success) => null,
                                ),
                      ),

                      SizedBox(height: 20.h),
                      Text(
                        'Password',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      OutlinedBorderTextField(
                        label: 'Enter password',
                        obscure: !context.read<SignupBloc>().state.showPassword,
                        onChanged: (value) =>
                            context.read<SignupBloc>().add(SignupEvent.passwordChanged(value)),
                        validator: (_) =>
                            context.read<SignupBloc>().state.password.value.fold(
                                  (failure) => failure.maybeWhen(
                                    empty: (msg) => msg,
                                    shortPassword: (msg) => msg,
                                    orElse: () => 'Invalid password',
                                  ),
                                  (success) => null,
                                ),
                      ),

                      SizedBox(height: 20.h),
                      Text(
                        'Confirm Password',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      OutlinedBorderTextField(
                        label: 'Confirm password',
                        obscure: true,
                        onChanged: (value) =>
                            context.read<SignupBloc>().add(SignupEvent.confirmPasswordChanged(value)),
                        validator: (_) => context.read<SignupBloc>().state.confirmPassword.value.fold(
                            (failure) => failure.maybeWhen(
                              empty: (msg) => msg,
                              passwordMismatch: (msg) => msg,
                              orElse: () => 'Invalid confirm password',
                              ),
                              (success) => null,
                            ),
                      ),

                      SizedBox(height: 20.h),
                      // Terms and Conditions Checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: context.read<SignupBloc>().state.termsAccepted,
                            onChanged: (value) =>
                                context.read<SignupBloc>().add(SignupEvent.termsAcceptedChanged(value ?? false)),
                            activeColor: Colors.black,
                          ),
                          Expanded(
                            child: Text(
                              'By checking this checkbox i agree with the term and conditions of Kacha.',
                              style: GoogleFonts.outfit(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],),
              ),
              SizedBox(height: 30.h),
              // Signup Button
              TextElevatedButton(
                text: 'Signup',
                onPressed: () => context.read<SignupBloc>().add(const SignupEvent.signupSubmitted()),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
