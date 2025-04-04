import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/di/dependency_injection.dart';
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
    return BlocProvider<InternalTransferBloc>(
      create: (context) => getIt<InternalTransferBloc>(),
      child: _InternalBankAccountScreenContent(),
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

  @override
  void initState() {
    super.initState();
    _accountNumberController.addListener(_onInputChanged);

    // Reset any previous state when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InternalTransferBloc>().add(
            const InternalTransferEvent.reset(),
          );
    });
  }

  @override
  void dispose() {
    _accountNumberController.removeListener(_onInputChanged);
    _accountNumberController.dispose();
    super.dispose();
  }

  void _onInputChanged() {
    final text = _accountNumberController.text;
    final hasInput = text.isNotEmpty;

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
    // Prevent multiple validations at once
    if (_isValidating) return;

    // Clear any existing snackbars first before verification
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // Get account number from controller
    final accountNumber = _accountNumberController.text.trim();

    // Check if account number is empty or invalid format before sending to bloc
    if (accountNumber.isEmpty) {
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

    // Mark validation as in progress
    setState(() {
      _isValidating = true;
    });

    // Dispatch event to validate account in the BLoC
    context.read<InternalTransferBloc>().add(
          const InternalTransferEvent.validateAccount(),
        );
  }

  void _continueToNextScreen() {
    final state = context.read<InternalTransferBloc>().state;

    // Prevent actions during loading
    if (state.isLoading || _isValidating) return;

    if (state.status != InternalTransferStatus.accountValidated) {
      _verifyAccount();
      return;
    }

    _navigateToAmountScreen();
  }

  void _navigateToAmountScreen() {
    final state = context.read<InternalTransferBloc>().state;
    if (state.validatedAccount == null) return;

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

    // Navigate to the amount entry screen
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
    return BlocConsumer<InternalTransferBloc, InternalTransferState>(
      listenWhen: (previous, current) {
        // Only trigger the listener when:
        // 1. The status changes from loading to failed state
        // 2. The error message changes and is not null
        // 3. When there's an error message but the status might still be initial
        return (previous.isLoading &&
                !current.isLoading &&
                (current.status ==
                        InternalTransferStatus.accountValidationFailed ||
                    current.errorMessage != null)) ||
            (previous.errorMessage != current.errorMessage &&
                current.errorMessage != null);
      },
      listener: (context, state) {
        // Get previous state
        final previousState = context.read<InternalTransferBloc>().state;

        // Reset validation flag when loading completes
        if (previousState.isLoading && !state.isLoading) {
          setState(() {
            _isValidating = false;
          });
        }

        // Show error messages if any
        if (state.errorMessage != null) {
          // Clear any existing snackbars first
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          // Show snackbar with proper duration and action
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              duration:
                  const Duration(seconds: 4), // Longer duration for readability
              behavior: SnackBarBehavior.floating, // Makes it more visible
              action: SnackBarAction(
                label: 'Dismiss',
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        // Update validation flag based on state
        if (_isValidating && !state.isLoading) {
          _isValidating = false;
        }

        final isAccountValidated =
            state.status == InternalTransferStatus.accountValidated;

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
                if (isAccountValidated && state.validatedAccount != null) ...[
                  GestureDetector(
                    onTap: _navigateToAmountScreen,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          // Profile circle with initials
                          Container(
                            width: 60.w,
                            height: 60.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.grey[300]!, width: 1),
                            ),
                            child: Center(
                              child: Text(
                                _getInitials(
                                    state.validatedAccount!.accountHolderName),
                                style: GoogleFonts.outfit(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
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
                                  state.accountNumberInput.isEmpty
                                      ? "1234567890"
                                      : state.accountNumberInput,
                                  style: GoogleFonts.outfit(
                                    fontSize: 14.sp,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Forward arrow
                          Icon(
                            Icons.chevron_right,
                            size: 24.sp,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],

                const Spacer(),

                // Loading indicator for account verification
                if (state.isLoading) ...[
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

                // Continue button - only shown when account info is not visible
                if (!isAccountValidated && !state.isLoading) ...[
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
