import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/transf/application/internal_transfer/internal_transfer_bloc.dart';
import 'package:super_app/features/transf/application/internal_transfer/internal_transfer_event.dart';
import 'package:super_app/features/transf/application/internal_transfer/internal_transfer_state.dart';
import 'package:super_app/features/transf/presentation/widget/continue_button.dart';

class InternalConfirmTransferScreen extends StatefulWidget {
  final Map<String, dynamic> transferData;

  const InternalConfirmTransferScreen({
    super.key,
    required this.transferData,
  });

  @override
  State<InternalConfirmTransferScreen> createState() =>
      _InternalConfirmTransferScreenState();
}

class _InternalConfirmTransferScreenState
    extends State<InternalConfirmTransferScreen> {
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

    // Initialize reason in BLoC if it exists in transfer data
    if (widget.transferData.containsKey('reason') &&
        widget.transferData['reason'] != null &&
        widget.transferData['reason'].toString().isNotEmpty) {
      _reasonController.text = widget.transferData['reason'].toString();

      // Update reason in BLoC
      context.read<InternalTransferBloc>().add(
            InternalTransferEvent.reasonChanged(_reasonController.text),
          );
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
    context.read<InternalTransferBloc>().add(
          InternalTransferEvent.reasonChanged(_reasonController.text),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternalTransferBloc, InternalTransferState>(
      listener: (context, state) {
        // Handle success state
        if (state.status == InternalTransferStatus.success) {
          _showSuccessDialog(context, state);
        }

        // Handle error state
        if (state.status == InternalTransferStatus.failure &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      builder: (context, state) {
        // Get the transfer amount
        final double amount = (widget.transferData['amount'] as num).toDouble();

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
              'Confirm Internal Transfer',
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
                  'Review Transfer',
                  style: GoogleFonts.outfit(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Please verify all details before confirming your internal transfer',
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
                                    .withOpacity(0.3)),
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
                              // Header with Goh Betoch Bank branding
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
                                  Icons.account_balance_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 32.sp,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'Transfer Details',
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

                              // Goh Betoch Bank badge
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
                                      Icons.verified_rounded,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      size: 16.sp,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'Goh Betoch Bank Internal',
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
                              _buildDetailRow(
                                  'Name',
                                  widget.transferData['accountHolderName']
                                      .toString()),
                              _buildDetailRow(
                                  'Account Number',
                                  widget.transferData['accountNumber']
                                      .toString()),
                              _buildDetailRow('Bank',
                                  widget.transferData['name'].toString()),

                              SizedBox(height: 24.h),
                              Divider(height: 1, color: Colors.grey[300]),
                              SizedBox(height: 24.h),

                              // Amount Details with zero fee highlighted
                              _buildSectionLabel('Amount'),
                              SizedBox(height: 8.h),
                              _buildDetailRow(
                                'Transfer Amount',
                                '${amount.toStringAsFixed(2)} ETB',
                                valueStyle: GoogleFonts.outfit(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),

                              // Add fee-free badge instead of showing service charge row
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 8.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                      color: Colors.green.withOpacity(0.3)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                      size: 14.sp,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      'Fee-Free Internal Transfer',
                                      style: GoogleFonts.outfit(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
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

                        // Reason for transfer
                        Text(
                          'Reason for Transfer',
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
                              hintText: 'Enter reason for transfer (optional)',
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
                          'By confirming this transfer, you agree to the terms and conditions.',
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
                  onPressed: () => _processTransfer(context),
                  isEnabled: !state.isLoading,
                  color: Theme.of(context).colorScheme.primary,
                  text: state.isLoading ? 'Processing...' : 'Confirm Transfer',
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

  void _processTransfer(BuildContext context) {
    // Dispatch submit transfer event to BLoC
    context.read<InternalTransferBloc>().add(
          const InternalTransferEvent.submitTransfer(),
        );
  }

  void _showSuccessDialog(BuildContext context, InternalTransferState state) {
    final amount = (widget.transferData['amount'] as num).toDouble();

    // Show success dialog with internal transfer branding
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

            // Internal transfer badge
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
                    'Instant Internal Transfer',
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
              'Transfer Successful!',
              style: GoogleFonts.outfit(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12.h),

            Text(
              'Your transfer of ${amount.toStringAsFixed(2)} ETB to ${widget.transferData['accountHolderName'].toString()} has been processed successfully.',
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
                  context.read<InternalTransferBloc>().add(
                        const InternalTransferEvent.reset(),
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
                context.read<InternalTransferBloc>().add(
                      const InternalTransferEvent.reset(),
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
