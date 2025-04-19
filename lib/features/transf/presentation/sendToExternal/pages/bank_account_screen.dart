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

  @override
  void initState() {
    super.initState();
    _accountNumberController.addListener(_onInputChanged);
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
      
      // Reset validation when input changes
      if (_hasInput) {
        context.read<BankAccountValidationBloc>().add(
          const ResetBankAccountValidation(),
        );
      }
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
    final bankCode = widget.bank['code'] as String;
    
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
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocConsumer<BankAccountValidationBloc, BankAccountValidationState>(
        listener: (context, state) {
          // Handle API errors if needed
          if (state.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Failed to validate account'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bank info header
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.grey[300]!),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: widget.bank['logoUrl'] != null
                              ? Image.network(
                                  widget.bank['logoUrl'] as String,
                                  width: 32.w,
                                  height: 32.w,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Text(
                                      bankCode,
                                      style: GoogleFonts.outfit(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    );
                                  },
                                )
                              : Text(
                                  bankCode,
                                  style: GoogleFonts.outfit(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          bankName,
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 24.h),
                
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
                  'Enter $bankName account number',
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 24.h),

                AccountInputField(
                  label: 'Account Number',
                  controller: _accountNumberController,
                  hintText: 'Enter account number',
                  errorMessage: state.hasError ? state.errorMessage : null,
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
                        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
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
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  _getInitials(state.validationResult!.accountName),
                                  style: GoogleFonts.outfit(
                                    fontSize: 24.sp,
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

                // Loading indicator when validating account
                if (state.isLoading) ...[
                  Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
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
                if (!state.isValid && !state.isLoading) ...[
                  ContinueButton(
                    onPressed: _verifyAccount,
                    isEnabled: _hasInput,
                    isLoading: false,
                    text: 'Continue',
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
