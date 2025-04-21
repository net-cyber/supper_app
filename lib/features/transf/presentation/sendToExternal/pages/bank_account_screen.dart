import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/transf/application/bank_account_validation/bloc/bank_account_validation_bloc.dart';
import 'package:super_app/features/transf/presentation/widget/account_input_field.dart';
import 'package:super_app/features/transf/presentation/widget/continue_button.dart';

// Helper function to show SnackBar at the top
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

class BankAccountScreen extends StatelessWidget {
  final Map<String, dynamic> bank;

  const BankAccountScreen({
    super.key,
    required this.bank,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BankAccountValidationBloc>(),
      child: _BankAccountScreenContent(bank: bank),
    );
  }
}

class _BankAccountScreenContent extends StatefulWidget {
  final Map<String, dynamic> bank;

  const _BankAccountScreenContent({
    required this.bank,
  });

  @override
  State<_BankAccountScreenContent> createState() => _BankAccountScreenContentState();
}

class _BankAccountScreenContentState extends State<_BankAccountScreenContent> {
  final TextEditingController _accountNumberController = TextEditingController();
  bool _hasInput = false;
  String _previousText = '';

  @override
  void initState() {
    super.initState();
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
    final text = _accountNumberController.text;
    final hasInput = text.isNotEmpty;
    
    // Check if there's an actual text change
    final textChanged = text != _previousText;
    _previousText = text;

    if (hasInput != _hasInput) {
      setState(() {
        _hasInput = hasInput;
      });
    }
    
    // Only reset validation when text actually changes
    if (textChanged) {
      context.read<BankAccountValidationBloc>().add(
        const ResetBankAccountValidation(),
      );
    }
  }

  void _verifyAccount() {
      final bankCode = widget.bank['code'] as String;
    final accountNumber = _accountNumberController.text;
    
    // Dispatch the validation event with bank code and account number
    context.read<BankAccountValidationBloc>().add(
      ValidateBankAccount(
        bankCode: bankCode,
        accountNumber: accountNumber,
      ),
    );
  }

  void _navigateToAmountScreen(final validatedAccount) {
    final transferData = {
      ...widget.bank,
      'accountNumber': _accountNumberController.text,
      'accountHolderName': validatedAccount.accountName,
      'accountType': validatedAccount.accountType ?? 'Bank Account',
      'branch': validatedAccount.branchName ?? 'Unknown',
      'validated': true,
    };

    context.pushNamed(RouteName.bankAmount, extra: transferData);
  }

  String _getInitials(String name) {
    if (name.isEmpty) return '?';
    
    final nameParts = name.trim().split(' ');
    if (nameParts.length > 1 && nameParts[0].isNotEmpty && nameParts[1].isNotEmpty) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    } else if (nameParts.isNotEmpty && nameParts[0].isNotEmpty) {
      return nameParts[0][0].toUpperCase();
    }
    
    return '?';
  }

  @override
  Widget build(BuildContext context) {
    final bankName = widget.bank['name'] as String;
    
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
          'Transfer to $bankName',
          style: GoogleFonts.outfit(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocConsumer<BankAccountValidationBloc, BankAccountValidationState>(
        listener: (context, state) {
          // Handle API errors if needed
          if (state.hasError) {
            showTopSnackBar(
              context,
              message: state.errorMessage ?? 'Failed to validate account',
            );
          }
        },
        builder: (context, state) {
          return Padding(
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
                SizedBox(height: 24.h),

            AccountInputField(
              label: 'Account Number',
              controller: _accountNumberController,
              hintText: 'Enter account number',
              errorMessage: null,
              enabled: !state.isLoading,
            ),

            SizedBox(height: 24.h),

            // Account information section (visible only after verification)
                if (state.isValid && state.validationResult != null) ...[
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _navigateToAmountScreen(state.validationResult!),
                      borderRadius: BorderRadius.circular(12.r),
                      child: Ink(
                  width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
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
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        ),
                        child: Center(
                          child: Text(
                                  _getInitials(state.validationResult!.accountName),
                            style: GoogleFonts.outfit(
                                    fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),

                            // Name and account details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                    state.validationResult!.accountName.toUpperCase(),
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
                                  if (state.validationResult!.accountType?.isNotEmpty ?? false) ...[
                            SizedBox(height: 4.h),
                            Text(
                                      state.validationResult!.accountType!,
                              style: GoogleFonts.outfit(
                                fontSize: 12.sp,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                                  SizedBox(height: 6.h),
                                  Row(
                        children: [
                          Text(
                                        'Tap to continue',
                            style: GoogleFonts.outfit(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                                      SizedBox(width: 4.w),
                                      Icon(
                                        Icons.touch_app,
                                        size: 16.sp,
                                        color: Theme.of(context).colorScheme.primary,
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

                // Continue button - only show when account is not validated or is being validated
                if (!state.isValid || state.isLoading) ...[
              ContinueButton(
                    onPressed: _verifyAccount,
                    isEnabled: _hasInput && !state.isLoading,
                    isLoading: state.isLoading,
                    text: state.isLoading ? 'Processing...' : 'Continue',
              ),
            ],
            SizedBox(height: 16.h),
          ],
        ),
          );
        },
      ),
    );
  }
}
