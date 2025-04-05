import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
  
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) => 
        previous.isLoading != current.isLoading || 
        previous.isLoginError != current.isLoginError,
      listener: (context, state) {
        if (!state.isLoading && !state.isLoginError) {
          // Login successful, navigate to main app
          context.goNamed(RouteName.home);
        } else if (!state.isLoading && state.isLoginError) {
          // Show error message
          AppHelpers.showCheckFlash(
            context,
            'Login failed. Please check your credentials and try again.',
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60.h),
                  Text(
                    'Welcome Back',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Log in to your account',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  AppTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => context.read<LoginBloc>().add(
                      LoginEvent.emailChanged(value),
                    ),
                    errorText: state.showErrorMessages && !state.email.isValid()
                        ? 'Please enter a valid username'
                        : null,
                  ),
                  SizedBox(height: 16.h),
                  AppTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: !state.showPassword,
                    onChanged: (value) => context.read<LoginBloc>().add(
                      LoginEvent.passwordChanged(value),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.showPassword ? Icons.visibility_off : Icons.visibility,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      onPressed: () => context.read<LoginBloc>().add(
                        const LoginEvent.toggleShowPassword(),
                      ),
                    ),
                    errorText: state.showErrorMessages && !state.password.isValid()
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
                      child: Text(
                        'Forgot Password?',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  AppButton(
                    onPressed: state.isLoading
                        ? null
                        : () {
                            context.read<LoginBloc>().add(
                              const LoginEvent.loginSubmitted(),
                            );
                          },
                    label: 'Login',
                    isLoading: state.isLoading,
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: theme.textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () {
                          context.pushNamed(RouteName.registrationScreen);
                        },
                        child: Text(
                          'Sign Up',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
} 