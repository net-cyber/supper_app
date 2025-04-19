import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/transf/application/wallet_transfer/wallet_transfer_bloc.dart';
import 'package:super_app/features/transf/application/wallet_transfer/wallet_transfer_event.dart';
import 'package:super_app/features/transf/application/wallet_transfer/wallet_transfer_state.dart';
import 'package:super_app/features/transf/presentation/widget/continue_button.dart';

class WalletConfirmationScreen extends StatefulWidget {
  const WalletConfirmationScreen({super.key});

  @override
  State<WalletConfirmationScreen> createState() =>
      _WalletConfirmationScreenState();
}

class _WalletConfirmationScreenState extends State<WalletConfirmationScreen> {
  final TextEditingController _reasonController = TextEditingController();

  // Mock data for sender (in a real app, this would come from user profile/auth)
  final Map<String, String> _sender = {
    'name': 'Bereket Tefera',
    'accountNumber': '1234567890',
    'bank': 'Goh Betoch Bank',
  };

  @override
  void initState() {
    super.initState();
    // Initialize the reason controller with the current value from the BLoC
    final reason = context.read<WalletTransferBloc>().state.reasonInput;
    if (reason.isNotEmpty) {
      _reasonController.text = reason;
    }

    // Add listener for reason changes
    _reasonController.addListener(_onReasonChanged);
  }

  @override
  void dispose() {
    _reasonController.removeListener(_onReasonChanged);
    _reasonController.dispose();
    super.dispose();
  }

  void _onReasonChanged() {
    // Update reason in BLoC
    context.read<WalletTransferBloc>().add(
          WalletTransferEvent.reasonChanged(_reasonController.text),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletTransferBloc, WalletTransferState>(
      listener: (context, state) {
        // Show success dialog when transaction is successful
        if (state.status == WalletTransferStatus.success && state.isSuccess) {
          _showSuccessDialog(context, state);
        }

        // Show error message
        if (state.status == WalletTransferStatus.failure &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      builder: (context, state) {
        final walletProvider = state.selectedProvider?['name'] as String? ?? '';
        final phoneNumber = state.phoneNumberInput;
        final wallet = state.validatedWallet;
        final amount = state.amountInput;
        final serviceFee = state.calculatedFee ?? 0.0;

        // Calculate total amount with service charge
        final double amountValue = double.tryParse(amount) ?? 0.0;
        final double totalAmount = amountValue + serviceFee;

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
              'Confirm Wallet Load',
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
                  'Review Transaction',
                  style: GoogleFonts.outfit(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Please verify all details before confirming your wallet load',
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 24.h),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Single receipt-like card with all transfer details
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.3),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Header with wallet branding
                              Container(
                                width: 64.w,
                                height: 64.h,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.account_balance_wallet_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 32.sp,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'Wallet Load Details',
                                style: GoogleFonts.outfit(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                'Transaction ID: ${state.transactionId ?? "Pending"}',
                                style: GoogleFonts.outfit(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),

                              // Wallet badge
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 16.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.wallet_rounded,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      size: 16.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'Load to $walletProvider Wallet',
                                      style: GoogleFonts.outfit(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 24.h),

                              // From (Sender)
                              _buildSectionLabel('From'),
                              SizedBox(height: 8.h),
                              _buildDetailRow('Name', _sender['name']!),
                              _buildDetailRow(
                                  'Account Number', _sender['accountNumber']!),
                              _buildDetailRow('Bank', _sender['bank']!),

                              SizedBox(height: 24.h),
                              Divider(height: 1, color: Colors.grey[300]),
                              SizedBox(height: 24.h),

                              // To (Receiver)
                              _buildSectionLabel('To'),
                              SizedBox(height: 8.h),
                              if (wallet?.accountHolderName != null)
                                _buildDetailRow(
                                    'Name', wallet!.accountHolderName!),
                              _buildDetailRow(
                                  'Wallet Provider', walletProvider),
                              if (phoneNumber.isNotEmpty)
                                _buildDetailRow('Phone Number', phoneNumber),

                              SizedBox(height: 24.h),
                              Divider(height: 1, color: Colors.grey[300]),
                              SizedBox(height: 24.h),

                              // Amount Details with service charge
                              _buildSectionLabel('Amount'),
                              SizedBox(height: 8.h),
                              _buildDetailRow(
                                'Transfer Amount',
                                'ETB ${amountValue.toStringAsFixed(2)}',
                              ),
                              _buildDetailRow(
                                'Service Charge',
                                'ETB ${serviceFee.toStringAsFixed(2)}',
                              ),
                              SizedBox(height: 16.h),
                              _buildDetailRow(
                                'Total Amount',
                                'ETB ${totalAmount.toStringAsFixed(2)}',
                                valueStyle: GoogleFonts.outfit(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),

                              SizedBox(height: 24.h),
                              Divider(height: 1, color: Colors.grey[300]),
                              SizedBox(height: 24.h),

                              // Date and Time
                              _buildDetailRow(
                                'Date & Time',
                                _formatDateTime(DateTime.now()),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Reason for loading wallet
                        Text(
                          'Reason for Loading Wallet',
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: TextField(
                            controller: _reasonController,
                            maxLines: 1,
                            style: GoogleFonts.outfit(
                              fontSize: 16.sp,
                              color: Colors.black87,
                            ),
                            decoration: InputDecoration(
                              hintText:
                                  'Enter reason for loading wallet (optional)',
                              hintStyle: GoogleFonts.outfit(
                                fontSize: 14.sp,
                                color: Colors.grey[500],
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 8.h),
                            ),
                          ),
                        ),

                        SizedBox(height: 16.h),
                        Text(
                          'By confirming this transaction, you agree to the terms and conditions.',
                          style: GoogleFonts.outfit(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                ),

                // Confirm button
                SizedBox(height: 16.h),
                ContinueButton(
                  onPressed: () => _processTransaction(context),
                  isEnabled: !state.isLoading,
                  color: Theme.of(context).colorScheme.primary,
                  text: state.isLoading ? 'Processing...' : 'Confirm Load',
                ),

                // Show loading indicator if processing
                if (state.isLoading) ...[
                  SizedBox(height: 16.h),
                  Center(
                    child: LinearProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.2),
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

  Widget _buildSectionLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: GoogleFonts.outfit(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    TextStyle? valueStyle,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
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
            style: valueStyle ??
                GoogleFonts.outfit(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final date =
        '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
    final time =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    return '$date at $time';
  }

  void _processTransaction(BuildContext context) {
    // Submit transfer to BLoC
    context.read<WalletTransferBloc>().add(
          const WalletTransferEvent.submitTransfer(),
        );
  }

  void _showSuccessDialog(BuildContext context, WalletTransferState state) {
    final walletProvider = state.selectedProvider?['name'] as String? ?? '';
    final amountValue = double.tryParse(state.amountInput) ?? 0.0;

    // Show success dialog with wallet load branding
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        contentPadding: EdgeInsets.all(24.w),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success animation
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 64.sp,
              ),
            ),
            SizedBox(height: 24.h),

            // Wallet load badge
            Container(
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.bolt,
                    color: Theme.of(context).colorScheme.primary,
                    size: 14.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Instant Wallet Load',
                    style: GoogleFonts.outfit(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              'Transaction Successful!',
              style: GoogleFonts.outfit(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12.h),

            Text(
              'Your wallet load of ETB ${amountValue.toStringAsFixed(2)} to $walletProvider has been processed successfully.',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8.h),

            // Receipt number
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 16.h),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: [
                  Text(
                    'Receipt Number',
                    style: GoogleFonts.outfit(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    state.transactionId ?? "Transaction pending",
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Reset BLoC state
                  context.read<WalletTransferBloc>().add(
                        const WalletTransferEvent.reset(),
                      );

                  // Close dialog and navigate back to home screen
                  Navigator.of(context).pop();
                  context.goNamed(RouteName.mainScreen);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.r),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      ],
                      stops: const [0.3, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(28.r),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.25),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 56.h,
                    alignment: Alignment.center,
                    child: Text(
                      'Done',
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.h),
            TextButton(
              onPressed: () {
                // Reset BLoC state
                context.read<WalletTransferBloc>().add(
                      const WalletTransferEvent.reset(),
                    );

                // Close dialog and navigate to transaction history
                Navigator.of(context).pop();
                context.goNamed(RouteName.history);
              },
              child: Text(
                'View Transaction History',
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
