import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/di/dependency_injection.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/transf/application/internal_transfer/internal_transfer_bloc.dart';
import 'package:super_app/features/transf/application/internal_transfer/internal_transfer_event.dart';
import 'package:super_app/features/transf/application/internal_transfer/internal_transfer_state.dart';

class InternalBankAmountScreen extends StatelessWidget {
  final Map<String, dynamic> transferData;

  const InternalBankAmountScreen({
    super.key,
    required this.transferData,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure the InternalTransferBloc is available in this screen
    return BlocProvider<InternalTransferBloc>(
      create: (context) => getIt<InternalTransferBloc>(),
      child: _InternalBankAmountScreenContent(transferData: transferData),
    );
  }
}

class _InternalBankAmountScreenContent extends StatefulWidget {
  final Map<String, dynamic> transferData;

  const _InternalBankAmountScreenContent({
    required this.transferData,
  });

  @override
  State<_InternalBankAmountScreenContent> createState() =>
      _InternalBankAmountScreenContentState();
}

class _InternalBankAmountScreenContentState
    extends State<_InternalBankAmountScreenContent> {
  final TextEditingController _amountController = TextEditingController();
  bool _hasInput = false;
  bool _isProcessing = false; // Track if we're processing an action
  bool _accountValidated = false; // Track if the account has been validated

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_onAmountChanged);

    // Set preloading flag
    setState(() {
      _isProcessing = true;
    });

    // Initialize the BLoC with account data from transferData
    if (widget.transferData != null &&
        widget.transferData.containsKey('accountNumber')) {
      String accountNumber = widget.transferData['accountNumber'].toString();

      // Use post frame callback to ensure the widget is fully built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Set account number in the BLoC
        context.read<InternalTransferBloc>().add(
              InternalTransferEvent.accountNumberChanged(accountNumber),
            );
        // Validate the account when screen loads
        context.read<InternalTransferBloc>().add(
              const InternalTransferEvent.validateAccount(),
            );
      });
    }
  }

  @override
  void dispose() {
    _amountController.removeListener(_onAmountChanged);
    _amountController.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    final text = _amountController.text;
    final hasInput = text.isNotEmpty;

    if (hasInput != _hasInput) {
      setState(() {
        _hasInput = hasInput;
      });
    }

    // Update amount in BLoC
    context.read<InternalTransferBloc>().add(
          InternalTransferEvent.amountChanged(_amountController.text),
        );
  }

  void _continueToConfirmation() {
    // Prevent multiple submissions
    if (_isProcessing) return;

    // Check amount validity
    final double? amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid amount'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    // Add amount to transfer data and navigate to confirmation screen
    final completeTransferData = {
      ...widget.transferData,
      'amount': amount,
      'name': 'Goh Betoch Bank',
    };

    // Use a short delay to avoid UI jumping
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _isProcessing = false;
      });

      // Navigate to internal confirmation screen
      context.pushNamed(RouteName.internalConfirmTransfer,
          extra: completeTransferData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternalTransferBloc, InternalTransferState>(
      listenWhen: (previous, current) {
        // Listen for validation status changes or errors
        return previous.status != current.status ||
            previous.errorMessage != current.errorMessage;
      },
      listener: (context, state) {
        // Update processing state when loading completes
        if (state.status == InternalTransferStatus.accountValidated) {
          setState(() {
            _accountValidated = true;
            _isProcessing = false;
          });
        }

        // Show error messages if any
        if (state.errorMessage != null) {
          setState(() {
            _isProcessing = false;
          });

          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              behavior: SnackBarBehavior.floating,
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
              'Enter Transfer Amount',
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
                // Account verification section with Goh Betoch Bank branding
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 24.sp,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Goh Betoch Bank Account',
                            style: GoogleFonts.outfit(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      _buildDetailRow('Account Number',
                          widget.transferData['accountNumber'].toString()),
                      SizedBox(height: 8.h),
                      _buildDetailRow('Account Holder',
                          widget.transferData['accountHolderName'].toString()),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                // Amount input section
                Text(
                  'Enter Amount',
                  style: GoogleFonts.outfit(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Enter the amount you want to transfer',
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16.h),
                _buildAmountInput(),

                const Spacer(),

                // Continue button - display when inputs are valid
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed:
                        (_hasInput && !_isProcessing && _accountValidated)
                            ? _continueToConfirmation
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      disabledBackgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                    ),
                    child: _isProcessing
                        ? SizedBox(
                            height: 24.h,
                            width: 24.h,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.w,
                            ),
                          )
                        : Text(
                            'Continue',
                            style: GoogleFonts.outfit(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildAmountInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
            ),
            child: Text(
              'ETB',
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: _amountController,
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                color: Colors.black87,
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                hintText: 'Enter amount',
                hintStyle: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  color: Colors.grey[500],
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 16.h,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
