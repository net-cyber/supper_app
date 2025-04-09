import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/core/utils/local_storage.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_event.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_state.dart';
import 'package:super_app/features/transf/application/transfer/bloc/transfer_bloc.dart';
import 'package:super_app/features/transf/presentation/widget/continue_button.dart';
import 'dart:developer';

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
  late final TransferBloc _transferBloc;
  late final AccountsBloc _accountsBloc;
  String? _userFullName;

  @override
  void initState() {
    super.initState();
    _transferBloc = getIt<TransferBloc>();
    _accountsBloc = getIt<AccountsBloc>();
    _loadUserData();

    // Initialize reason if it exists in transfer data
    if (widget.transferData.containsKey('reason') &&
        widget.transferData['reason'] != null &&
        widget.transferData['reason'].toString().isNotEmpty) {
      _reasonController.text = widget.transferData['reason'].toString();
    }

    // Check if accounts data is loaded
    if (_accountsBloc.state.accounts.isEmpty &&
        !_accountsBloc.state.isLoading) {
      _accountsBloc.add(const FetchAccounts());
    }

    // Set transfer details in the bloc
    final double amount = (widget.transferData['amount'] as num).toDouble();
    final int toAccountId =
        int.tryParse(widget.transferData['accountNumber'].toString()) ?? 0;

    // We'll set fromAccountId to 0 and let the bloc get it from AccountsBloc
    _transferBloc.add(
      TransferEvent.transferDetailsChanged(
        fromAccountId: 0, // Will be resolved from AccountsBloc
        toAccountId: toAccountId,
        amount: amount,
        currency: 'ETB', // Default currency for internal transfers
      ),
    );
  }

  void _loadUserData() {
    final userData = LocalStorage.instance.getUserData();
    if (userData != null) {
      setState(() {
        _userFullName = userData['full_name'] as String? ?? 'Account Holder';
      });
    }
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the transfer amount
    final double amount = (widget.transferData['amount'] as num).toDouble();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _transferBloc),
        BlocProvider.value(value: _accountsBloc),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<TransferBloc, TransferState>(
            listener: (context, state) {
              if (state.isTransferred && state.transferResponse != null) {
                // Show success dialog when transfer is complete
                _showSuccessDialog(
                  context,
                  state.transferId ?? state.transferResponse!.transferId,
                );
              }

              if (state.transferError && state.errorMessage.isNotEmpty) {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: 'Dismiss',
                      textColor: Colors.white,
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<AccountsBloc, AccountsState>(
            builder: (context, accountsState) {
          // Get sender account info
          final senderAccount = accountsState.accounts.isNotEmpty
              ? accountsState.accounts.firstWhere(
                  (account) =>
                      account.currency.toLowerCase() == 'etb' ||
                      account.currency.toLowerCase() == 'birr',
                  orElse: () => accountsState.accounts.first,
                )
              : null;

          // Create sender info from account data
          final sender = {
            'name': _userFullName ?? 'Account Holder',
            'accountNumber': senderAccount?.id.toString() ?? 'Loading...',
            'bank': 'Goh Betoch Bank',
          };

          return BlocBuilder<TransferBloc, TransferState>(
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
                                      color:
                                          Theme.of(context).colorScheme.primary,
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
                                    'Transaction ID: ${state.transferId ?? "Pending"}',
                                    style: GoogleFonts.outfit(
                                      fontSize: 12.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),

                                  // Goh Betoch Bank badge
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 16.h),
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
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
                                  _buildDetailRow('Name', sender['name']!),
                                  _buildDetailRow('Account Number',
                                      sender['accountNumber']!),
                                  _buildDetailRow('Bank', sender['bank']!),

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

                                  // Amount
                                  _buildSectionLabel('Amount'),
                                  SizedBox(height: 8.h),
                                  _buildDetailRow(
                                    'Transfer Amount',
                                    'ETB ${amount.toStringAsFixed(2)}',
                                    valueStyle: GoogleFonts.outfit(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),

                                  // Fee information
                                  Container(
                                    margin: EdgeInsets.only(top: 8.h),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 6.h),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20.r),
                                      border: Border.all(
                                        color: Colors.green.withOpacity(0.3),
                                      ),
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
                                  hintText:
                                      'Enter reason for transfer (optional)',
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
                    state.isTransferring
                        ? _buildLoadingButton(context)
                        : ContinueButton(
                            onPressed: () => _processTransfer(context),
                            isEnabled:
                                !state.isTransferring && !state.isTransferred,
                            color: Theme.of(context).colorScheme.primary,
                            text: 'Confirm Transfer',
                          ),
                  ],
                ),
              ),
            );
          });
        }),
      ),
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
    // Log the beginning of the transfer process
    log('Starting transfer process');

    // Get transfer state from bloc
    final transferState = _transferBloc.state;
    log('Current transfer state: fromAccountId=${transferState.fromAccountId}, toAccountId=${transferState.toAccountId}, amount=${transferState.amount}');

    // Prevent multiple submissions
    if (transferState.isTransferring || transferState.isTransferred) {
      log('Transfer already in progress or completed, skipping');
      return;
    }

    // Get the ETB account from AccountsBloc
    final accountsState = _accountsBloc.state;
    log('AccountsBloc state: hasAccounts=${accountsState.accounts.isNotEmpty}, isLoading=${accountsState.isLoading}');

    if (accountsState.accounts.isEmpty) {
      log('No accounts available, showing error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No accounts available. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Find the ETB account
    final etbAccount = accountsState.accounts.firstWhere(
      (account) =>
          account.currency.toLowerCase() == 'etb' ||
          account.currency.toLowerCase() == 'birr',
      orElse: () => accountsState.accounts.first,
    );
    log('Selected source account: id=${etbAccount.id}, currency=${etbAccount.currency}, balance=${etbAccount.balance}');

    // Update transfer details with the correct source account ID
    log('Updating transfer details with source account ID: ${etbAccount.id}');
    _transferBloc.add(
      TransferEvent.transferDetailsChanged(
        fromAccountId: etbAccount.id,
        toAccountId: transferState.toAccountId,
        amount: transferState.amount,
        currency: transferState.currency,
      ),
    );

    // Submit transfer request after a delay to ensure the details are updated
    log('Scheduling transfer submission after delay');
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        log('Submitting transfer request');
        _transferBloc.add(const TransferEvent.createTransferSubmitted());
      } else {
        log('Widget no longer mounted, cannot submit transfer');
      }
    });
  }

  void _showSuccessDialog(BuildContext context, String transactionId) {
    final amount = (widget.transferData['amount'] as num).toDouble();
    final recipientName = widget.transferData['accountHolderName'].toString();

    // Store the navigation context to ensure we can navigate from the dialog
    final navigatorContext = context;

    // Show success dialog with internal transfer branding
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => WillPopScope(
        // Prevent back button from closing dialog
        onWillPop: () async => false,
        child: AlertDialog(
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
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.3),
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
                'ETB ${amount.toStringAsFixed(2)} has been transferred to $recipientName',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Transaction ID: $transactionId',
                style: GoogleFonts.outfit(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 24.h),

              // Done button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Close dialog
                    Navigator.of(dialogContext).pop();

                    // Navigate back to home screen using the stored context
                    Future.microtask(() {
                      GoRouter.of(navigatorContext)
                          .goNamed(RouteName.mainScreen);
                    });
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
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.8),
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
                  // Close dialog
                  Navigator.of(dialogContext).pop();

                  // Navigate to transaction history using the stored context
                  Future.microtask(() {
                    GoRouter.of(navigatorContext).goNamed(RouteName.history);
                  });
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
      ),
    );
  }

  Widget _buildLoadingButton(BuildContext context) {
    final buttonColor = Theme.of(context).colorScheme.primary;

    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              buttonColor,
              buttonColor.withOpacity(0.8),
            ],
            stops: const [0.3, 1.0],
          ),
          borderRadius: BorderRadius.circular(28.r),
          boxShadow: [
            BoxShadow(
              color: buttonColor.withOpacity(0.25),
              blurRadius: 15,
              offset: const Offset(0, 6),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
                width: 20.h,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.w,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Processing...',
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
