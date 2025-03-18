// lib/presentation/auth/pages/login/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/application/auth/login/bloc/login_bloc.dart';
import 'package:super_app/application/auth/login/bloc/login_event.dart';
import 'package:super_app/core/constants/app_constants.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/presentation/widgets/buttons/text_button_unfilled.dart';
import 'package:super_app/presentation/widgets/buttons/text_elevated_button.dart';
import 'package:super_app/presentation/widgets/text_fields/outline_bordered_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: LoginBody(),
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 60.h),
                // Logo
                Image.asset(
                  AppConstants.gohbetochLogoHorizontal,
                  width: 210.w,
                  height: 78.h,
                ),
    
                SizedBox(height: 50.h),
                Form(
                  //autovalidateMode: loginState.showErrorMessages ? AutovalidateMode.always : AutovalidateMode.disabled,
                  autovalidateMode: AutovalidateMode.always,
                  child:
                      // Email Field
                      Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email Address',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      OutlinedBorderTextField(
                        label: 'Email',
                        onChanged: (value) =>
                            context.read<LoginBloc>().add(EmailChanged(value)),
                        validator: (_) =>
                            context.read<LoginBloc>().state.email.value.fold(
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
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      OutlinedBorderTextField(
                        label: 'Password',
                        obscure: context.read<LoginBloc>().state.showPassword,
                        onChanged: (value) =>
                            context.read<LoginBloc>().add(PasswordChanged(value)),
                        validator: (_) =>
                            context.read<LoginBloc>().state.password.value.fold(
                                  (failure) => failure.maybeWhen(
                                    empty: (msg) => msg,
                                    shortPassword: (msg) => msg,
                                    orElse: () => 'Invalid password',
                                  ),
                                  (success) => null,
                                ),
                      ),
                    ],
                  ),
                ),
    
                SizedBox(height: 52.h),
    
                // Login Button
                TextElevatedButton(
                  text: 'Login',
                  onPressed: () {
                    context.read<LoginBloc>().add(const LoginSubmitted());
                  },
                ),
    
                const Spacer(),
    
                // Sign up section
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.w),
                  child: Column(
                    children: [
                      Text(
                        "Or if you don't have account",
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextButtonUnfilled(
                        text: 'Signup',
                        onPressed: () =>
                            context.pushNamed(RouteName.signup),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
