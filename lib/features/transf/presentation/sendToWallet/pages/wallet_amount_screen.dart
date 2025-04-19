import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/transf/application/wallet_transfer/wallet_transfer_bloc.dart';
import 'package:super_app/features/transf/application/wallet_transfer/wallet_transfer_event.dart';
import 'package:super_app/features/transf/application/wallet_transfer/wallet_transfer_state.dart';

class WalletAmountScreen extends StatefulWidget {
  const WalletAmountScreen({super.key});

  @override
  State<WalletAmountScreen> createState() => _WalletAmountScreenState();
}

class _WalletAmountScreenState extends State<WalletAmountScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_onAmountChanged);
    _reasonController.addListener(_onReasonChanged);
  }

  @override
  void dispose() {
    _amountController.removeListener(_onAmountChanged);
    _reasonController.removeListener(_onReasonChanged);
    _amountController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    // Dispatch amount changed event to BLoC
    context.read<WalletTransferBloc>().add(
          WalletTransferEvent.amountChanged(_amountController.text),
        );
  }

  void _onReasonChanged() {
    // Dispatch reason changed event to BLoC
    context.read<WalletTransferBloc>().add(
          WalletTransferEvent.reasonChanged(_reasonController.text),
        );
  }

  void _calculateFee() {
    // Dispatch calculate fee event to BLoC
    context.read<WalletTransferBloc>().add(
          const WalletTransferEvent.calculateFee(),
        );
  }

  void _continueToConfirmation() {
    // Navigate to confirmation screen
    context.pushNamed(RouteName.walletConfirmation);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletTransferBloc, WalletTransferState>(
      listener: (context, state) {
        // Handle error messages
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }

        // Navigate to confirmation when fee is calculated
        if (state.status == WalletTransferStatus.feeCalculated) {
          _continueToConfirmation();
        }
      },
      builder: (context, state) {
        final walletProvider = state.selectedProvider?['name'] as String? ?? '';
        final phoneNumber = state.phoneNumberInput;
        final validatedWallet = state.validatedWallet;
        final bool isCalculatingFee =
            state.status == WalletTransferStatus.calculatingFee;
        final bool canCalculateFee = state.amountInput.isNotEmpty &&
            state.phoneNumber != null &&
            state.validatedWallet != null;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Enter Load Amount',
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
                // Wallet information section with branded container
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: 24.sp,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            '$walletProvider Wallet',
                            style: GoogleFonts.outfit(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      if (phoneNumber.isNotEmpty)
                        _buildDetailRow('Phone Number', phoneNumber),
                      if (validatedWallet?.accountHolderName != null) ...[
                        SizedBox(height: 8.h),
                        _buildDetailRow('Account Holder',
                            validatedWallet!.accountHolderName!),
                      ],
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
                  'Enter the amount you want to load to wallet',
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16.h),
                _buildAmountInput(),

                SizedBox(height: 24.h),

                // Reason input section
                Text(
                  'Reason (Optional)',
                  style: GoogleFonts.outfit(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                _buildReasonInput(),

                // Fee display if calculated
                if (state.calculatedFee != null) ...[
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.blue[700],
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'Service fee: ${state.calculatedFee!.toStringAsFixed(2)} ETB',
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              color: Colors.blue[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const Spacer(),

                // Continue button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: isCalculatingFee || !canCalculateFee
                        ? null
                        : _calculateFee,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      disabledBackgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                    ),
                    child: isCalculatingFee
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.w,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'Calculating Fee...',
                                style: GoogleFonts.outfit(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
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

  Widget _buildReasonInput() {
    return Container(
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
          hintText: 'What is this for? (optional)',
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
        maxLength: 100,
        maxLines: 1,
        buildCounter: (context,
                {required currentLength, required isFocused, maxLength}) =>
            null,
      ),
    );
  }
}
