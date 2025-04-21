import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/core/utils/local_storage.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_event.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_state.dart';
import 'package:super_app/features/transf/application/external_transfer/bloc/external_transfer_bloc.dart';
import 'package:super_app/features/transf/presentation/widget/continue_button.dart';
import 'package:super_app/features/transf/presentation/widget/success_dialog.dart';
import 'package:super_app/features/transf/presentation/widget/receipt_widget.dart';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class ConfirmTransferScreen extends StatelessWidget {
  final Map<String, dynamic> transferData;

  const ConfirmTransferScreen({
    super.key,
    required this.transferData,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ExternalTransferBloc>()),
        BlocProvider(create: (context) => getIt<AccountsBloc>()),
      ],
      child: _ConfirmTransferScreenContent(transferData: transferData),
    );
  }
}

class _ConfirmTransferScreenContent extends StatefulWidget {
  final Map<String, dynamic> transferData;

  const _ConfirmTransferScreenContent({
    required this.transferData,
  });

  @override
  State<_ConfirmTransferScreenContent> createState() =>
      _ConfirmTransferScreenContentState();
}

class _ConfirmTransferScreenContentState
    extends State<_ConfirmTransferScreenContent> {
  final TextEditingController _reasonController = TextEditingController();
  bool _isLoading = false;
  bool _isTransactionComplete = false;
  String? _transactionId;
  String? _errorMessage;
  bool _isDataLoading = false;
  String? _userFullName;
  Map<String, dynamic>? _senderAccount;

  // Variables for receipt generation
  String? _generatedReceiptPath;
  String? _generatedReceiptName;
  final GlobalKey _successDialogKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    // Check if data was preloaded from previous screen
    if (widget.transferData.containsKey('preloaded') &&
        widget.transferData['preloaded'] == true) {
      // Use preloaded data
      _userFullName =
          widget.transferData['senderName'] as String? ?? 'Account Holder';
      _senderAccount =
          widget.transferData['senderAccount'] as Map<String, dynamic>?;

      // We don't generate a placeholder transaction ID anymore
      // to ensure "Pending" shows up correctly

      // If for some reason preloaded data is incomplete, fall back to loading
      if (_userFullName == null || _senderAccount == null) {
        _isDataLoading = true;
        _loadUserData();
        final accountsBloc = context.read<AccountsBloc>();
        if (accountsBloc.state.accounts.isEmpty) {
          accountsBloc.add(const FetchAccounts());
        } else {
          _setSenderAccount();
          setState(() {
            _isDataLoading = false;
          });
        }
      }
    } else {
      // Fall back to original loading behavior if data wasn't preloaded
      _isDataLoading = true;
      _loadUserData();

      // Check if accounts data is loaded
      final accountsBloc = context.read<AccountsBloc>();
      if (accountsBloc.state.accounts.isEmpty &&
          !accountsBloc.state.isLoading) {
        accountsBloc.add(const FetchAccounts());
      } else if (accountsBloc.state.accounts.isNotEmpty) {
        _setSenderAccount();
        setState(() {
          _isDataLoading = false;
        });
      }
    }

    if (widget.transferData.containsKey('reason') &&
        widget.transferData['reason'] != null &&
        widget.transferData['reason'].toString().isNotEmpty) {
      _reasonController.text = widget.transferData['reason'].toString();
    }
  }

  void _loadUserData() {
    final userData = LocalStorage.instance.getUserData();
    if (userData != null) {
      setState(() {
        _userFullName = userData['full_name'] as String? ?? 'Account Holder';
      });
    }
  }

  void _setSenderAccount() {
    final accountsBloc = context.read<AccountsBloc>();
    if (accountsBloc.state.accounts.isNotEmpty) {
      final firstAccount = accountsBloc.state.accounts.first;
      setState(() {
        _senderAccount = {
          'accountNumber': firstAccount.id,
          'bank': 'Gohe Betoch Bank'
        };
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
    final double amount = (widget.transferData['amount'] as num).toDouble();
    final double fee = widget.transferData.containsKey('fee')
        ? (widget.transferData['fee'] as num).toDouble()
        : 0.0;
    final double totalAmount = amount + fee;

    // Show loading indicator if data is not ready
    if (_isDataLoading || _userFullName == null || _senderAccount == null) {
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
            'Confirm Transfer',
            style: GoogleFonts.outfit(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: 16.h),
              Text(
                'Loading transfer details...',
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<AccountsBloc, AccountsState>(
          listener: (context, state) {
            if (state.accounts.isNotEmpty) {
              _setSenderAccount();
              setState(() {
                _isDataLoading = false;
              });
            }
          },
        ),
        BlocListener<ExternalTransferBloc, ExternalTransferState>(
          listener: (context, state) {
            setState(() {
              _isLoading = state.isTransferring;
            });

            if (state.transferError) {
              setState(() {
                _errorMessage = state.errorMessage;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }

            if (state.isTransferred && state.transferResponse != null) {
              setState(() {
                _isTransactionComplete = true;
                _transactionId = state.transferResponse?.id?.toString() ??
                    "ETX${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}";
              });

              // Generate receipt automatically before showing success dialog
              _generateReceiptAutomatically(state).then((_) {
                // After receipt is generated, show success dialog
                _showSuccessDialog(
                  context,
                  _transactionId!,
                );
              }).catchError((error) {
                log('Error generating receipt automatically: $error');
                // Still show success dialog even if receipt generation fails
                _showSuccessDialog(
                  context,
                  _transactionId!,
                );
              });
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Confirm External Transfer',
            style: GoogleFonts.outfit(
              fontSize: 18.sp,
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
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Please verify all details before confirming the transfer',
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 24.h),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Transfer details card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey[300]!),
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
                            // Header with transfer icon
                            Container(
                              width: 64.w,
                              height: 64.h,
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.swap_horiz_rounded,
                                color: Theme.of(context).colorScheme.primary,
                                size: 32.sp,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'Transfer Details',
                              style: GoogleFonts.outfit(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 6.h),
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
                                    'Goh Betoch Bank External',
                                    style: GoogleFonts.outfit(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 24.h),

                            // From (Sender)
                            _buildSectionLabel('From'),
                            SizedBox(height: 8.h),
                            _buildDetailRow(
                                'Name', _userFullName ?? 'Account Holder'),
                            _buildDetailRow(
                                'Account Number',
                                _senderAccount?['id']?.toString() ??
                                    _senderAccount?['accountNumber']
                                        ?.toString() ??
                                    ''),
                            _buildDetailRow('Bank', 'Gohe Betoch Bank'),

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
                            _buildDetailRow(
                                'Bank', widget.transferData['name'].toString()),

                            SizedBox(height: 24.h),
                            Divider(height: 1, color: Colors.grey[300]),
                            SizedBox(height: 24.h),

                            // Amount Details
                            _buildSectionLabel('Amount'),
                            SizedBox(height: 8.h),
                            _buildDetailRow('Transfer Amount',
                                '${amount.toStringAsFixed(2)} ETB'),
                            _buildDetailRow('Service Charge',
                                '${fee.toStringAsFixed(2)} ETB'),
                            SizedBox(height: 16.h),
                            _buildDetailRow(
                              'Total Amount',
                              '${totalAmount.toStringAsFixed(2)} ETB',
                              valueStyle: GoogleFonts.outfit(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),

                            SizedBox(height: 24.h),
                            Divider(height: 1, color: Colors.grey[300]),
                            SizedBox(height: 24.h),

                            // Date and Time
                            _buildDetailRow(
                                'Date & Time', _formatDateTime(DateTime.now())),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Reason for transfer
                      Text(
                        'Reason for Transfer',
                        style: GoogleFonts.outfit(
                          fontSize: 18.sp,
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
                          maxLines: 1,
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            color: Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter reason for transfer (optional)',
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

                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // Confirm button
              SizedBox(height: 16.h),
              BlocBuilder<ExternalTransferBloc, ExternalTransferState>(
                builder: (context, state) {
                  return ContinueButton(
                    onPressed: () => _processTransfer(context),
                    isEnabled: !state.isTransferring && !state.isTransferred,
                    isLoading: state.isTransferring || _isLoading,
                    color: Theme.of(context).colorScheme.primary,
                    text: state.isTransferring
                        ? 'Processing...'
                        : 'Confirm Transfer',
                  );
                },
              ),
            ],
          ),
        ),
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
                  fontWeight: FontWeight.w500,
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
    if (_isLoading || _isTransactionComplete) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    int senderAccountId;

    // Check if we have preloaded account data
    if (_senderAccount != null && _senderAccount!.containsKey('id')) {
      // Use preloaded account ID
      senderAccountId = _senderAccount!['id'] as int;
    } else {
      // Fall back to getting account from state
      final accountsBloc = context.read<AccountsBloc>();
      final accountsState = accountsBloc.state;

      if (accountsState.accounts.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No accounts available. Please try again.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Get the first available account or ETB account
      final senderAccount = accountsState.accounts.firstWhere(
        (account) =>
            account.currency.toLowerCase() == 'etb' ||
            account.currency.toLowerCase() == 'birr',
        orElse: () => accountsState.accounts.first,
      );

      senderAccountId = senderAccount.id;
    }

    final bankCode = widget.transferData['code']?.toString() ?? '';
    final toAccountNumber =
        widget.transferData['accountNumber']?.toString() ?? '';
    final double amount = (widget.transferData['amount'] as num).toDouble();
    final description = _reasonController.text;

    // Update transfer details in the bloc
    final transferBloc = context.read<ExternalTransferBloc>();
    transferBloc.add(
      ExternalTransferEvent.transferDetailsChanged(
        fromAccountId: senderAccountId,
        toBankCode: bankCode,
        toAccountNumber: toAccountNumber,
        amount: amount,
        currency: 'ETB',
        description: description,
      ),
    );

    // Submit the transfer
    transferBloc.add(
      const ExternalTransferEvent.createTransferSubmitted(),
    );
  }

  // Update the success dialog to use the shared success dialog widget
  void _showSuccessDialog(BuildContext context, String transactionId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SuccessDialog(
        transactionId: transactionId,
        amount: (widget.transferData['amount'] as num).toDouble(),
        recipientName: widget.transferData['accountHolderName'].toString(),
        receiptPath: _generatedReceiptPath,
        receiptName: _generatedReceiptName,
        routeName: RouteName.mainScreen,
        transactionType: 'External Bank Transfer',
        currency: 'ETB',
        primaryColor: Theme.of(context).colorScheme.primary,
        successColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  // Helper method to automatically generate the receipt after a successful transfer
  Future<void> _generateReceiptAutomatically(
      ExternalTransferState state) async {
    try {
      if (!state.isTransferred || state.transferResponse == null) {
        throw Exception('Cannot generate receipt: Transfer data not available');
      }

      // Get transfer data from the bloc state
      final transferResponse = state.transferResponse!;
      final transactionId = _transactionId ?? transferResponse.id.toString();

      log('Automatically generating PDF receipt for transaction: $transactionId');

      // Get current date and time for the receipt
      final now = DateTime.now();
      final formattedDate =
          '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
      final formattedTime =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

      // Generate the PDF using the shared ReceiptWidget
      final pdf = await ReceiptWidget.generateReceipt(
        transactionId: transactionId,
        amount: transferResponse.amount,
        fromAccountId: transferResponse.fromAccountId.toString(),
        toAccountId: transferResponse.toAccountNumber,
        fromName: _userFullName ?? 'Account Holder',
        toName:
            widget.transferData['accountHolderName']?.toString() ?? 'Recipient',
        fromBank: 'Gohe Betoch Bank',
        toBank: transferResponse.toBankCode,
        currency: 'ETB',
        status: transferResponse.status,
        timestamp: '$formattedDate | $formattedTime',
        transactionRef: transferResponse.reference,
        transactionType: 'External Bank Transfer',
        primaryColor: Theme.of(context).colorScheme.primary,
        secondaryColor: Theme.of(context).colorScheme.secondary,
        accentColor: Theme.of(context).colorScheme.primary,
        lightAccent: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderColor: Colors.grey.shade300,
        backgroundColor: Colors.grey.shade100,
      );

      // Get the path to save the PDF
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'NekaPayTransfer_$transactionId.pdf';
      final filePath = '${directory.path}/$fileName';

      // Save the PDF
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      // Store the generated receipt path for later use
      _generatedReceiptPath = filePath;
      _generatedReceiptName = fileName;

      log('PDF receipt automatically generated and saved at: $filePath');
    } catch (e) {
      log('Error in automatic receipt generation: $e');
      // Reset path variables in case of error
      _generatedReceiptPath = null;
      _generatedReceiptName = null;
      // Re-throw to be caught by the caller
      throw e;
    }
  }
}
