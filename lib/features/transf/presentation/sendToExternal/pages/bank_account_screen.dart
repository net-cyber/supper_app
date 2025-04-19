import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/transf/application/external_transfer/external_transfer_bloc.dart';
import 'package:super_app/features/transf/application/external_transfer/external_transfer_event.dart';
import 'package:super_app/features/transf/application/external_transfer/external_transfer_state.dart';
import 'package:super_app/features/transf/presentation/widget/account_input_field.dart';

class BankAccountScreen extends StatefulWidget {
  final Map<String, dynamic> bank;

  const BankAccountScreen({
    super.key,
    required this.bank,
  });

  @override
  State<BankAccountScreen> createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  final TextEditingController _accountNumberController =
      TextEditingController();
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

      // Update the account number in the BLoC
      context.read<ExternalTransferBloc>().add(
            ExternalTransferEvent.accountNumberChanged(
                _accountNumberController.text),
          );
    }
  }

  void _verifyAccount() {
    // Dispatch event to validate account in the BLoC
    context.read<ExternalTransferBloc>().add(
          const ExternalTransferEvent.validateAccount(),
        );
  }

  void _continueToNextScreen() {
    final state = context.read<ExternalTransferBloc>().state;

    if (state.status != ExternalTransferStatus.accountValidated) {
      _verifyAccount();
      return;
    }

    _navigateToAmountScreen();
  }

  void _navigateToAmountScreen() {
    final state = context.read<ExternalTransferBloc>().state;

    // Create transfer data object to pass to the next screen
    final transferData = {
      ...widget.bank,
      'accountNumber': _accountNumberController.text.isEmpty
          ? '158040484'
          : _accountNumberController.text,
      'accountHolderName': state.validatedAccount?.accountHolderName ?? '',
    };

    context.pushNamed(RouteName.bankAmount, extra: transferData);
  }

  String _getInitials(String name) {
    List<String> parts = name.split(' ');
    if (parts.length > 1) {
      return parts[0][0].toUpperCase() +
          (parts.length > 2
              ? parts[2][0].toUpperCase()
              : parts[1][0].toUpperCase());
    } else if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExternalTransferBloc, ExternalTransferState>(
      listener: (context, state) {
        // Handle error messages
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      builder: (context, state) {
        final isAccountValidated =
            state.status == ExternalTransferStatus.accountValidated;

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
              'Transfer to ${widget.bank['name']}',
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
                  'Enter recipient bank account number.',
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
                          ExternalTransferStatus.accountValidationFailed
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
                                  state.validatedAccount!.accountHolderName,
                                  style: GoogleFonts.outfit(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  state.accountNumberInput.isEmpty
                                      ? "158040484"
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

                // Loading indicator when validating account
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
                        backgroundColor: _hasInput
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[300],
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
                SizedBox(height: 16.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
