import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/transf/application/internal_transfer/internal_transfer_bloc.dart';
import 'package:super_app/features/transf/application/internal_transfer/internal_transfer_event.dart';
import 'package:super_app/features/transf/application/internal_transfer/internal_transfer_state.dart';
import 'package:super_app/features/transf/presentation/widget/account_input_field.dart';

class InternalBankAccountScreen extends StatelessWidget {
  const InternalBankAccountScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('🏦 Building InternalBankAccountScreen root');
    return BlocProvider<InternalTransferBloc>(
      create: (context) => getIt<InternalTransferBloc>(),
      child: const _InternalBankAccountScreenContent(),
    );
  }
}

class _InternalBankAccountScreenContent extends StatefulWidget {
  const _InternalBankAccountScreenContent();

  @override
  State<_InternalBankAccountScreenContent> createState() =>
      _InternalBankAccountScreenContentState();
}

class _InternalBankAccountScreenContentState
    extends State<_InternalBankAccountScreenContent> {
  final TextEditingController _accountNumberController =
      TextEditingController();
  bool _hasInput = false;
  bool _isValidating = false; // Track validation in progress
  bool _validationTimedOut = false; // Track if validation timed out
  bool _debugTestRun = false;

  @override
  void initState() {
    super.initState();
    print('🏦 Internal Account Screen: initState');
    _accountNumberController.addListener(_onInputChanged);

    // Reset any previous state when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('🏦 Internal Account Screen: post-frame callback, resetting state');
      context.read<InternalTransferBloc>().add(
            const InternalTransferEvent.reset(),
          );
    });
  }

  @override
  void dispose() {
    print('🏦 Internal Account Screen: dispose');
    _accountNumberController.removeListener(_onInputChanged);
    _accountNumberController.dispose();
    super.dispose();
  }

  void _onInputChanged() {
    final text = _accountNumberController.text;
    final hasInput = text.isNotEmpty;
    print('🏦 Account input changed: "$text"');

    if (hasInput != _hasInput) {
      setState(() {
        _hasInput = hasInput;
      });
    }

    // Update the account number in the BLoC
    context.read<InternalTransferBloc>().add(
          InternalTransferEvent.accountNumberChanged(
              _accountNumberController.text),
        );
  }

  void _verifyAccount() {
    print('🏦 _verifyAccount called');
    // Prevent multiple validations at once
    if (_isValidating) {
      print('🏦 Validation already in progress, ignoring request');
      return;
    }

    // Clear any existing snackbars first before verification
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // Get account number from controller
    final accountNumber = _accountNumberController.text.trim();
    print(
        '🏦 DEBUG: About to verify account number: "$accountNumber" (length: ${accountNumber.length})');

    // Check if account number is empty or invalid format before sending to bloc
    if (accountNumber.isEmpty) {
      print('🏦 Empty account number, showing error');
      // Manually show snackbar for empty account
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a valid account number'),
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
      return;
    }

    // Show a brief verification message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Verifying account...'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );

    print('🏦 Account number validation started for: $accountNumber');

    // Reset timeout flag
    _validationTimedOut = false;

    // Mark validation as in progress
    setState(() {
      _isValidating = true;
    });

    print('🏦 Setting validation state and dispatching event to BLoC');

    // Make sure the BLoC has the most current account number
    context.read<InternalTransferBloc>().add(
          InternalTransferEvent.accountNumberChanged(accountNumber),
        );

    print('🏦 Updated BLoC with account number: $accountNumber');

    // Dispatch event to validate account in the BLoC
    context.read<InternalTransferBloc>().add(
          const InternalTransferEvent.validateAccount(),
        );

    print('🏦 Validation event dispatched, waiting for response');

    // Add a safety timeout to prevent UI getting stuck in loading state
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted && _isValidating) {
        print('🏦 Validation timeout reached, resetting loading state');
        setState(() {
          _isValidating = false;
          _validationTimedOut = true;
        });

        // Show timeout error if we're still in loading state
        final currentState = context.read<InternalTransferBloc>().state;
        print('🏦 DEBUG: After timeout, state is: ${currentState.status}');
        if (currentState.isLoading ||
            currentState.status == InternalTransferStatus.validatingAccount) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Validation is taking longer than expected. Please try again.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    });
  }

  void _continueToNextScreen() {
    print('🏦 _continueToNextScreen called');
    final state = context.read<InternalTransferBloc>().state;

    // Debug information
    print('🏦 Current state status: ${state.status}');
    print('🏦 Is loading: ${state.isLoading}');
    print('🏦 Has validated account: ${state.validatedAccount != null}');
    if (state.validatedAccount != null) {
      print(
          '🏦 Account holder name: ${state.validatedAccount!.accountHolderName}');
      print(
          '🏦 Account number: ${state.validatedAccount!.accountNumber.getOrElse('')}');
    } else {
      print('🏦 Validated account is NULL');
    }

    // Prevent actions during loading
    if (state.isLoading || _isValidating) {
      print('🏦 Still loading, ignoring continue request');
      return;
    }

    if (state.status != InternalTransferStatus.accountValidated) {
      print('🏦 Account not validated yet, triggering validation');
      _verifyAccount();
      return;
    }

    print('🏦 Account validated, navigating to amount screen');
    _navigateToAmountScreen();
  }

  void _navigateToAmountScreen() {
    print('🏦 _navigateToAmountScreen called');
    final state = context.read<InternalTransferBloc>().state;

    // More detailed debug info
    print('🏦 Navigation state check:');
    print('🏦 - Status: ${state.status}');
    print('🏦 - Has validated account: ${state.validatedAccount != null}');

    if (state.validatedAccount == null) {
      print('🏦 validatedAccount is null, cannot navigate');
      return;
    }

    print(
        '🏦 Account holder name: ${state.validatedAccount!.accountHolderName}');

    // Create transfer data
    final transferData = {
      'bank': 'Goh Betoch Bank',
      'logo': 'assets/banks/gohbetoch_bank.png',
      'accountNumber': _accountNumberController.text.isEmpty
          ? '1234567890'
          : _accountNumberController.text,
      'isInternal': true,
      'accountHolderName': state.validatedAccount!.accountHolderName,
    };

    // Debug the transfer data
    print('🏦 Transfer data being sent: $transferData');

    // Navigate to the amount entry screen
    print('🏦 Navigating to amount screen with data: $transferData');
    context.pushNamed(RouteName.internalBankAmount, extra: transferData);
  }

  String _getInitials(String name) {
    List<String> parts = name.split(' ');
    if (parts.length > 1) {
      return parts[0][0].toUpperCase() + parts[1][0].toUpperCase();
    } else if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    print('🏦 Building account screen content');

    return BlocConsumer<InternalTransferBloc, InternalTransferState>(
      listenWhen: (previous, current) {
        // Print state changes for debugging
        print('🏦 State change: ${previous.status} -> ${current.status}');
        print(
            '🏦 Loading change: ${previous.isLoading} -> ${current.isLoading}');

        // Debug the validated account
        print(
            '🏦 DEBUG Previous validatedAccount: ${previous.validatedAccount?.accountHolderName ?? 'NULL'}');
        print(
            '🏦 DEBUG Current validatedAccount: ${current.validatedAccount?.accountHolderName ?? 'NULL'}');

        // Listen for any important state changes
        return previous.status != current.status ||
            previous.isLoading != current.isLoading ||
            previous.errorMessage != current.errorMessage ||
            previous.validatedAccount != current.validatedAccount;
      },
      listener: (context, state) {
        print(
            '🏦 DEBUG: Listener called with state: ${state.status}, isLoading: ${state.isLoading}');
        print(
            '🏦 DEBUG: Has validated account? ${state.validatedAccount != null}');
        if (state.validatedAccount != null) {
          print(
              '🏦 DEBUG: Account holder name: ${state.validatedAccount!.accountHolderName}');
        }

        // Reset validation flag when state changes from loading to not loading
        if (_isValidating && !state.isLoading) {
          print('🏦 Resetting validation flag as loading completed');
          setState(() {
            _isValidating = false;
          });
        }

        // Show error messages if any
        if (state.errorMessage != null) {
          print('🏦 Showing error: ${state.errorMessage}');
          // Clear any existing snackbars first
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          // Show snackbar with proper duration and action
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              duration: const Duration(seconds: 4),
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: 'Dismiss',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        }

        // Log and show confirmation when account validation succeeds
        if (state.status == InternalTransferStatus.accountValidated &&
            state.validatedAccount != null) {
          print(
              '🏦 Validated account received: ${state.validatedAccount!.accountHolderName}');
          print('🏦 DEBUG: Account validated successfully, updating UI');

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Account verified: ${state.validatedAccount!.accountHolderName}'),
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.green,
            ),
          );
        } else if (state.status == InternalTransferStatus.accountValidated &&
            state.validatedAccount == null) {
          print(
              '🏦 DEBUG: Strange state - accountValidated but account is NULL');
        }
      },
      builder: (context, state) {
        // Print current state for debugging purposes
        print(
            '🏦 Builder called with state: ${state.status}, isLoading: ${state.isLoading}');

        // Check if account has been validated
        final isAccountValidated =
            state.status == InternalTransferStatus.accountValidated;
        print('🏦 isAccountValidated: $isAccountValidated');

        // Also check if the validated account data is available
        final hasValidatedAccount = state.validatedAccount != null;
        print('🏦 hasValidatedAccount: $hasValidatedAccount');

        // If validation timed out, force reset the loading state
        final isLoading = _validationTimedOut ? false : state.isLoading;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'Transfer to Goh Betoch Bank',
              style: GoogleFonts.outfit(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter Account Number',
                  style: GoogleFonts.outfit(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Enter recipient Goh Betoch Bank account number.',
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 32.h),
                AccountInputField(
                  label: 'Account Number',
                  controller: _accountNumberController,
                  hintText: 'Enter account number',
                  errorMessage: state.status ==
                          InternalTransferStatus.accountValidationFailed
                      ? state.errorMessage
                      : null,
                ),
                SizedBox(height: 24.h),

                // Account information section (visible only after verification)
                if (isAccountValidated && hasValidatedAccount) ...[
                  GestureDetector(
                    onTap: _navigateToAmountScreen,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.blue.withOpacity(0.3)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Account verification status header
                          Row(
                            children: [
                              Icon(Icons.check_circle,
                                  color: Colors.green, size: 20.sp),
                              SizedBox(width: 8.w),
                              Text(
                                'Account Verified',
                                style: GoogleFonts.outfit(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),

                          // Account holder information with initials
                          Row(
                            children: [
                              // Profile circle with initials
                              Container(
                                width: 60.w,
                                height: 60.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.1),
                                  border: Border.all(
                                      color: Colors.grey[300]!, width: 1),
                                ),
                                child: Center(
                                  child: Text(
                                    _getInitials(state
                                        .validatedAccount!.accountHolderName),
                                    style: GoogleFonts.outfit(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),

                              // Name and account number
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.validatedAccount!.accountHolderName
                                          .toUpperCase(),
                                      style: GoogleFonts.outfit(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      'Account: ${state.accountNumberInput}',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      'Goh Betoch Bank',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 16.h),

                          // "Tap to Continue" instruction
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Tap to continue',
                                  style: GoogleFonts.outfit(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 16.sp,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],

                const Spacer(),

                // Loading indicator for account verification
                if (isLoading) ...[
                  Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16.h),
                        Text(
                          'Verifying account...',
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Continue button - simplified as requested
                if (!isAccountValidated && !isLoading) ...[
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: _hasInput ? _continueToNextScreen : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        disabledBackgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.r),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: GoogleFonts.outfit(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
