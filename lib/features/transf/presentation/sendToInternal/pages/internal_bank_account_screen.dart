import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/core/utils/local_storage.dart';
import 'package:super_app/features/transf/application/verification/bloc/account_verification_bloc.dart';
import 'package:super_app/features/transf/presentation/widget/account_input_field.dart';
import 'package:super_app/features/transf/presentation/widget/continue_button.dart';

class InternalBankAccountScreen extends StatefulWidget {
  const InternalBankAccountScreen({
    super.key,
  });

  @override
  State<InternalBankAccountScreen> createState() =>
      _InternalBankAccountScreenState();
}

class _InternalBankAccountScreenState extends State<InternalBankAccountScreen> {
  final TextEditingController _accountNumberController =
      TextEditingController();
  bool _hasText = false;

  late final AccountVerificationBloc _verificationBloc;

  @override
  void initState() {
    super.initState();
    _verificationBloc = getIt<AccountVerificationBloc>();
    _accountNumberController.addListener(_onInputChanged);
  }

  @override
  void dispose() {
    _accountNumberController.removeListener(_onInputChanged);
    _accountNumberController.dispose();
    super.dispose();
  }

  void _onInputChanged() {
    // Update local state to trigger button activation
    final hasText = _accountNumberController.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }

    // Get current verification state and the new text from field
    final currentState = _verificationBloc.state;
    final newAccountIdText = _accountNumberController.text.trim();

    // Only reset verification if the account was verified AND the account ID has actually changed
    if (currentState.isVerified && newAccountIdText.isNotEmpty) {
      try {
        final newAccountId = int.parse(newAccountIdText);
        // Only reset if the new account ID is different from the verified one
        if (newAccountId != currentState.accountId) {
          // Reset verification state
          _verificationBloc.add(
            const AccountVerificationEvent.accountIdChanged(0),
          );
        }
      } catch (e) {
        // If we can't parse the new ID, it's definitely changed
        _verificationBloc.add(
          const AccountVerificationEvent.accountIdChanged(0),
        );
      }
    }

    // Pass the account ID to the bloc if text is not empty
    if (newAccountIdText.isNotEmpty) {
      try {
        final accountId = int.parse(newAccountIdText);
        _verificationBloc.add(
          AccountVerificationEvent.accountIdChanged(accountId),
        );
      } catch (e) {
        // Non-integer input will be handled during verification
      }
    }
  }

  void _handleSessionExpired() async {
    // Clear user session data
    await LocalStorage.instance.clearUserSession();

    // Show message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your session has expired. Please login again.'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );

      // Navigate to login screen
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          context.go('/login');
        }
      });
    }
  }

  void _verifyAccount() {
    // Clear any existing snackbars first before verification
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // Get account number from controller
    final accountNumberText = _accountNumberController.text.trim();

    // Check if account number is empty
    if (accountNumberText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a valid account number'),
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          ),
        ),
      );
      return;
    }

    // Try to parse the account number as an integer
    int accountId;
    try {
      accountId = int.parse(accountNumberText);

      // First ensure the account ID is set in the bloc state
      _verificationBloc.add(
        AccountVerificationEvent.accountIdChanged(accountId),
      );

      // Then send verification event to the bloc after a small delay
      // to ensure the first event is processed
      Future.delayed(Duration(milliseconds: 100), () {
        if (mounted) {
          _verificationBloc.add(
            AccountVerificationEvent.verifyAccountSubmitted(),
          );
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Account number must be numeric'),
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          ),
        ),
      );
      return;
    }
  }

  void _navigateToAmountScreen(String accountHolderName) {
    // Create transfer data with verified information
    final transferData = {
      'bank': 'Goh Betoch Bank',
      'logo': 'assets/banks/gohbetoch_bank.png',
      'accountNumber': _accountNumberController.text,
      'isInternal': true,
      'accountHolderName': accountHolderName,
    };

    // Navigate to the amount entry screen
    context.pushNamed(RouteName.internalBankAmount, extra: transferData);
  }

  String _getInitials(String name) {
    List<String> parts = name.split(' ');
    if (parts.length > 1) {
      return parts[0][0].toUpperCase() + parts[1][0].toUpperCase();
    } else if (parts.length == 1 && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _verificationBloc,
      child: BlocConsumer<AccountVerificationBloc, AccountVerificationState>(
        listener: (context, state) {
          // Handle authentication error / session expired
          if (state.verificationError &&
              state.errorMessage.toLowerCase().contains('unauthorised')) {
            _handleSessionExpired();
            return;
          }

          // Show error message when verification fails
          if (state.verificationError) {
            String errorMessage = state.errorMessage;

            // Check for common null errors and provide friendlier message
            if (errorMessage.contains("type 'Null'") ||
                errorMessage.contains("null is not a subtype") ||
                errorMessage.contains("Unexpected error")) {
              errorMessage =
                  "Unable to verify account. Please try again later.";
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                duration: const Duration(seconds: 4),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Dismiss',
                  onPressed: () =>
                      ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  textColor: Colors.white,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
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
                    'Enter Goh Betoch Bank account number',
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // Account input field
                  AccountInputField(
                    label: 'Account Number',
                    controller: _accountNumberController,
                    hintText: 'Enter account number',
                    errorMessage:
                        state.verificationError ? state.errorMessage : null,
                  ),

                  SizedBox(height: 24.h),

                  // Account information section (visible only after verification)
                  if (state.isVerified) ...[
                    GestureDetector(
                      onTap: () => _navigateToAmountScreen(state.fullName),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
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
                                    .withOpacity(0.2),
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 1),
                              ),
                              child: Center(
                                child: Text(
                                  _getInitials(state.fullName),
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
                                    state.fullName.toUpperCase(),
                                    style: GoogleFonts.outfit(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'Account: ${_accountNumberController.text}',
                                    style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    'Tap to continue',
                                    style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Forward arrow
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20.sp,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],

                  const Spacer(),

                  // Continue button - only shown when not yet verified and not validating
                  if (!state.isVerified) ...[
                    ContinueButton(
                      onPressed: _verifyAccount,
                      isEnabled: _hasText,
                      isLoading: state.isVerifying,
                      text: 'Continue',
                    ),
                  ],
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
