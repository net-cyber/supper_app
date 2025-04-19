import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/transf/application/external_transfer/external_transfer_bloc.dart';
import 'package:super_app/features/transf/application/external_transfer/external_transfer_event.dart';
import 'package:super_app/features/transf/application/external_transfer/external_transfer_state.dart';

class BankAmountScreen extends StatefulWidget {
  final Map<String, dynamic> transferData;

  const BankAmountScreen({
    super.key,
    required this.transferData,
  });

  @override
  State<BankAmountScreen> createState() => _BankAmountScreenState();
}

class _BankAmountScreenState extends State<BankAmountScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  bool _hasInput = false;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_onAmountChanged);
    _reasonController.addListener(_onReasonChanged);
  }

  @override
  void dispose() {
    _amountController.removeListener(_onAmountChanged);
    _amountController.dispose();
    _reasonController.removeListener(_onReasonChanged);
    _reasonController.dispose();
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

    // Update the amount in the BLoC
    context.read<ExternalTransferBloc>().add(
          ExternalTransferEvent.amountChanged(_amountController.text),
        );
  }

  void _onReasonChanged() {
    // Update the reason in the BLoC
    context.read<ExternalTransferBloc>().add(
          ExternalTransferEvent.reasonChanged(_reasonController.text),
        );
  }

  void _calculateFee() {
    // Dispatch event to calculate fee
    context.read<ExternalTransferBloc>().add(
          const ExternalTransferEvent.calculateFee(),
        );
  }

  void _continueToConfirmation() {
    final state = context.read<ExternalTransferBloc>().state;

    if (state.status != ExternalTransferStatus.feeCalculated) {
      _calculateFee();
      return;
    }

    if (_hasInput && state.fee != null) {
      // Add amount to transfer data and navigate to confirmation screen
      final completeTransferData = {
        ...widget.transferData,
        'amount': double.tryParse(_amountController.text) ?? 0.0,
        'fee': state.calculatedFee ?? 0.0,
        'reason': _reasonController.text,
        'accountHolderName': state.validatedAccount?.accountHolderName ??
            widget.transferData['accountHolderName'],
      };

      // Navigate to confirmation screen
      context.pushNamed(RouteName.confirmTransfer, extra: completeTransferData);
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
                // Account verification section
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
                            'Account Details',
                            style: GoogleFonts.outfit(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      _buildDetailRow(
                          'Bank', widget.transferData['name'].toString()),
                      SizedBox(height: 8.h),
                      _buildDetailRow('Account Number',
                          widget.transferData['accountNumber'].toString()),
                      SizedBox(height: 8.h),
                      _buildDetailRow(
                          'Account Holder',
                          (state.validatedAccount?.accountHolderName ??
                                  widget.transferData['accountHolderName'] ??
                                  "Unknown")
                              .toString()),
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

                // Fee information - show when calculated
                if (state.status == ExternalTransferStatus.feeCalculated &&
                    state.calculatedFee != null) ...[
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.green[700],
                          size: 18.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'Transfer fee: ETB ${state.calculatedFee!.toStringAsFixed(2)}',
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              color: Colors.green[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                SizedBox(height: 24.h),

                // Reason input section
                Text(
                  'Reason (Optional)',
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: TextField(
                    controller: _reasonController,
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter reason for transfer',
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
                    maxLines: 2,
                    minLines: 1,
                  ),
                ),

                const Spacer(),

                // Loading indicator when calculating fee
                if (state.isLoading) ...[
                  Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16.h),
                        Text(
                          'Calculating fee...',
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],

                // Continue button
                if (!state.isLoading) ...[
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: _hasInput ? _continueToConfirmation : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        disabledBackgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.r),
                        ),
                      ),
                      child: Text(
                        state.status == ExternalTransferStatus.feeCalculated
                            ? 'Continue'
                            : 'Calculate Fee',
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
