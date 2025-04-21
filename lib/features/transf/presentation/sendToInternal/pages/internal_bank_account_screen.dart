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

// Helper function to show messages at the top in a fixed position
void showTopSnackBar(
  BuildContext context, {
  required String message,
  Color backgroundColor = Colors.red,
  Duration duration = const Duration(seconds: 4),
  SnackBarAction? action,
}) {
  // Dismiss any previous overlays first
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  // Use OverlayEntry for fixed position notification
  final overlayState = Overlay.of(context);
  OverlayEntry? overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).viewPadding.top + 10,
      left: 20.w,
      right: 20.w,
      child: Material(
        elevation: 6.0,
        borderRadius: BorderRadius.circular(8.r),
        color: backgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              if (action != null)
                InkWell(
                  onTap: () {
                    overlayEntry?.remove();
                    action.onPressed.call();
                  },
                  child: Text(
                    action.label,
                    style: TextStyle(
                      color: action.textColor ?? Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                )
              else
                InkWell(
                  onTap: () => overlayEntry?.remove(),
                  child: Text(
                    'Dismiss',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
  );

  // Insert the overlay and remove after duration
  overlayState.insert(overlayEntry);

  // Auto-remove after duration
  Future.delayed(duration, () {
    if (overlayEntry?.mounted ?? false) {
      overlayEntry?.remove();
    }
  });
}

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
  String _previousText = '';

  late final AccountVerificationBloc _verificationBloc;

  @override
  void initState() {
    super.initState();
    _verificationBloc = getIt<AccountVerificationBloc>();
    _accountNumberController.addListener(_onInputChanged);
    _previousText = _accountNumberController.text;
  }

  @override
  void dispose() {
    _accountNumberController.removeListener(_onInputChanged);
    _accountNumberController.dispose();
    super.dispose();
  }

  void _onInputChanged() {
    // Update local state to trigger button activation
    final text = _accountNumberController.text.trim();
    final hasText = text.isNotEmpty;

    // Check if there's an actual text change
    final textChanged = text != _previousText;
    _previousText = text;

    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }

    // Only reset verification if the account was verified AND text actually changed
    if (textChanged && _verificationBloc.state.isVerified) {
      try {
        final newAccountId = int.parse(text);
        // Only reset if the new account ID is different from the verified one
        if (newAccountId != _verificationBloc.state.accountId) {
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
    if (textChanged && text.isNotEmpty) {
      try {
        final accountId = int.parse(text);
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
      showTopSnackBar(
        context,
        message: 'Your session has expired. Please login again.',
        duration: const Duration(seconds: 3),
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
      showTopSnackBar(
        context,
        message: 'Please enter a valid account number',
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
      showTopSnackBar(
        context,
        message: 'Account number must be numeric',
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

            // Show error as SnackBar
            showTopSnackBar(
              context,
              message: errorMessage,
              backgroundColor: Colors.red,
              action: SnackBarAction(
                label: 'Dismiss',
                onPressed: () {},
                textColor: Colors.white,
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
                  fontSize: 16.sp,
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
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Enter recipient account number',
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // Account input field
                  AccountInputField(
                    label: 'Account Number',
                    controller: _accountNumberController,
                    hintText: 'Enter account number',
                    errorMessage: null,
                    enabled: !state.isVerifying,
                  ),

                  SizedBox(height: 24.h),

                  // Account information section (visible only after verification)
                  if (state.isVerified) ...[
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _navigateToAmountScreen(state.fullName),
                        borderRadius: BorderRadius.circular(12.r),
                        child: Ink(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            children: [
                              // Profile circle with initials
                              Container(
                                width: 50.w,
                                height: 50.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.2),
                                ),
                                child: Center(
                                  child: Text(
                                    _getInitials(state.fullName),
                                    style: GoogleFonts.outfit(
                                      fontSize: 20.sp,
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
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
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
                                    Row(
                                      children: [
                                        Text(
                                          'Tap to continue',
                                          style: GoogleFonts.outfit(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                        Icon(
                                          Icons.touch_app,
                                          size: 16.sp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      ],
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
                    ),
                  ],

                  const Spacer(),

                  // Continue button - show when not verified or during verification
                  if (!state.isVerified || state.isVerifying) ...[
                    ContinueButton(
                      onPressed: _verifyAccount,
                      isEnabled: _hasText && !state.isVerifying,
                      isLoading: state.isVerifying,
                      text: state.isVerifying ? 'Processing...' : 'Continue',
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
