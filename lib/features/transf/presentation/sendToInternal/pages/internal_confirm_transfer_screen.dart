import 'dart:io';
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
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:result_type/result_type.dart';
// For sharing files
import 'package:share_plus/share_plus.dart';
// For getting Android SDK version
import 'package:device_info_plus/device_info_plus.dart';
// For document directory path
import 'package:path/path.dart' as path;
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:super_app/features/transf/presentation/widget/success_dialog.dart';
import 'package:super_app/features/transf/presentation/widget/receipt_widget.dart';

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
  bool _isDataLoading = false;
  
  // Map to store sender account info from preloaded data
  Map<String, dynamic>? _senderAccount;

  // Add a variable to store the generated receipt path
  String? _generatedReceiptPath;
  String? _generatedReceiptName;
  
  // Add this global key to access the success dialog content for screenshot
  final GlobalKey _successDialogKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _transferBloc = getIt<TransferBloc>();
    _accountsBloc = getIt<AccountsBloc>();
    
    // Check if data was preloaded from previous screen
    if (widget.transferData.containsKey('preloaded') && widget.transferData['preloaded'] == true) {
      // Use preloaded user name if available
      if (widget.transferData.containsKey('senderName')) {
        _userFullName = widget.transferData['senderName'] as String?;
      } else {
    _loadUserData();
      }
      
      // Use preloaded sender account if available
      if (widget.transferData.containsKey('senderAccount')) {
        _senderAccount = widget.transferData['senderAccount'] as Map<String, dynamic>?;
      }
    } else {
      // Fall back to original loading behavior if data wasn't preloaded
      _isDataLoading = true;
      _loadUserData();

    // Check if accounts data is loaded
      if (_accountsBloc.state.accounts.isEmpty && !_accountsBloc.state.isLoading) {
      _accountsBloc.add(const FetchAccounts());
    } else if (_accountsBloc.state.accounts.isNotEmpty) {
      // If accounts already loaded, set loading to false
      setState(() {
        _isDataLoading = false;
      });
      }
    }

    // Initialize reason if it exists in transfer data
    if (widget.transferData.containsKey('reason') &&
        widget.transferData['reason'] != null &&
        widget.transferData['reason'].toString().isNotEmpty) {
      _reasonController.text = widget.transferData['reason'].toString();
    }

    // Set transfer details in the bloc
    final double amount = (widget.transferData['amount'] as num).toDouble();
    final int toAccountId =
        int.tryParse(widget.transferData['accountNumber'].toString()) ?? 0;

    // Set fromAccountId from preloaded data if available
    int fromAccountId = 0;
    if (_senderAccount != null && _senderAccount!.containsKey('id')) {
      fromAccountId = _senderAccount!['id'] as int;
    }

    _transferBloc.add(
      TransferEvent.transferDetailsChanged(
        fromAccountId: fromAccountId, // Use preloaded account ID if available
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
                // Generate receipt automatically before showing success dialog
                _generateReceiptAutomatically(state).then((_) {
                  // After receipt is generated, show success dialog
                  _showSuccessDialog(
                    context,
                    state.transferId ?? state.transferResponse!.transferId,
                  );
                }).catchError((error) {
                  log('Error generating receipt automatically: $error');
                  // Still show success dialog even if receipt generation fails
                  _showSuccessDialog(
                    context,
                    state.transferId ?? state.transferResponse!.transferId,
                  );
                });
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
          BlocListener<AccountsBloc, AccountsState>(
            listener: (context, state) {
              // Update loading state when accounts are loaded (only if not preloaded)
              if (_isDataLoading && !state.isLoading && state.accounts.isNotEmpty) {
                setState(() {
                  _isDataLoading = false;
                });
              }

              if (state.hasError) {
                setState(() {
                  _isDataLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text('Failed to load account data. Please try again.'),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    action: SnackBarAction(
                      label: 'Retry',
                      textColor: Colors.white,
                      onPressed: () {
                        setState(() {
                          _isDataLoading = true;
                        });
                        _accountsBloc.add(const FetchAccounts());
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
          Map<String, String> sender = {};

          // If we have preloaded sender account data, use it
          if (_senderAccount != null) {
            sender = {
              'name': _userFullName ?? 'Account Holder',
              'accountNumber': _senderAccount!['id'].toString(),
              'bank': 'Goh Betoch Bank',
            };
          } else {
            // Fall back to getting sender account from AccountsBloc
          final senderAccount = accountsState.accounts.isNotEmpty
              ? accountsState.accounts.firstWhere(
                  (account) =>
                      account.currency.toLowerCase() == 'etb' ||
                      account.currency.toLowerCase() == 'birr',
                  orElse: () => accountsState.accounts.first,
                )
              : null;

          // Create sender info from account data
            sender = {
            'name': _userFullName ?? 'Account Holder',
            'accountNumber': senderAccount?.id.toString() ?? 'Loading...',
            'bank': 'Goh Betoch Bank',
          };
          }

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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
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
                                          margin: EdgeInsets.symmetric(
                                              vertical: 16.h),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.w, vertical: 6.h),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(20.r),
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
                                        _buildDetailRow(
                                            'Name', sender['name']!),
                                        _buildDetailRow('Account Number',
                                            sender['accountNumber']!),
                                        _buildDetailRow(
                                            'Bank', sender['bank']!),

                                        SizedBox(height: 24.h),
                                        Divider(
                                            height: 1, color: Colors.grey[300]),
                                        SizedBox(height: 24.h),

                                        // To (Receiver)
                                        _buildSectionLabel('To'),
                                        SizedBox(height: 8.h),
                                        _buildDetailRow(
                                            'Name',
                                            widget.transferData[
                                                    'accountHolderName']
                                                .toString()),
                                        _buildDetailRow(
                                            'Account Number',
                                            widget.transferData['accountNumber']
                                                .toString()),
                                        _buildDetailRow(
                                            'Bank',
                                            widget.transferData['name']
                                                .toString()),

                                        SizedBox(height: 24.h),
                                        Divider(
                                            height: 1, color: Colors.grey[300]),
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
                                            color:
                                                Colors.green.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            border: Border.all(
                                              color:
                                                  Colors.green.withOpacity(0.3),
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
                                        Divider(
                                            height: 1, color: Colors.grey[300]),
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
                                      border:
                                          Border.all(color: Colors.grey[300]!),
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
                    ContinueButton(
                                  onPressed: () => _processTransfer(context),
                      isEnabled: !state.isTransferring && !state.isTransferred,
                      isLoading: state.isTransferring || _isDataLoading,
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

    // If we have preloaded sender account data, use it directly
    if (_senderAccount != null && _senderAccount!.containsKey('id')) {
      log('Using preloaded source account ID: ${_senderAccount!['id']}');
      
      // Confirm that the fromAccountId is already set correctly
      if (transferState.fromAccountId != _senderAccount!['id']) {
        // Update if needed
        _transferBloc.add(
          TransferEvent.transferDetailsChanged(
            fromAccountId: _senderAccount!['id'] as int,
            toAccountId: transferState.toAccountId,
            amount: transferState.amount,
            currency: transferState.currency,
          ),
        );
      }
      
      // Submit transfer request directly
      log('Submitting transfer request with preloaded account data');
      _transferBloc.add(const TransferEvent.createTransferSubmitted());
      return;
    }

    // Fall back to getting the ETB account from AccountsBloc if no preloaded data
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
        transactionType: 'Instant Internal Transfer',
        currency: 'ETB',
        primaryColor: Theme.of(context).colorScheme.primary,
        successColor: Colors.green,
      ),
    );
  }

  // Share receipt method
  Future<void> _shareReceipt(BuildContext context, String filePath) async {
    try {
      final File fileToShare = File(filePath);
      if (!await fileToShare.exists()) {
        // File doesn't exist, but no snackbar notification
        return;
      }

      // Get Android SDK version to determine appropriate permission strategy
      int sdkVersion = 0;
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        sdkVersion = androidInfo.version.sdkInt;
        log('Android SDK Version: $sdkVersion');
      }

      try {
        if (Platform.isAndroid && sdkVersion < 33) {
          // For Android 12 and below (SDK < 33), request storage permission
          final status = await Permission.storage.request();
          if (!status.isGranted) {
            // Handle permission denial
            if (status.isPermanentlyDenied && context.mounted) {
                _showPermissionPermanentlyDeniedDialog(context);
            }
            // No snackbar for permission denial
            return;
          }
        }

        // Use share_plus package to share the file
        final xFile = XFile(filePath);
        await Share.shareXFiles(
          [xFile],
          text: 'NekaPayTransfer Receipt',
          subject: 'Transfer Receipt',
        );
        } catch (e) {
        log('Error sharing file with Share.shareXFiles: $e');
        
        // Fallback method: open file with default viewer
        try {
          await OpenFile.open(filePath);
          // No snackbar for fallback success
        } catch (e) {
          log('Error opening file: $e');
          // No snackbar for fallback failure
        }
      }
    } catch (e) {
      log('Error in _shareReceipt: $e');
      // No snackbar for general failure
    }
  }

  // Method to download the receipt to external storage
  Future<void> _downloadReceiptToStorage(
      BuildContext context, String filePath, String fileName, {bool showSnackbar = false}) async {
    try {
      final File sourceFile = File(filePath);
      if (!await sourceFile.exists()) {
        // File doesn't exist, but no snackbar
        return;
      }

      // Get Android SDK version to determine appropriate permission strategy
      int sdkVersion = 0;
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        sdkVersion = androidInfo.version.sdkInt;
        log('Android SDK Version: $sdkVersion');
      }

      String destinationPath = '';
      bool permissionGranted = true;

        if (Platform.isAndroid) {
        if (sdkVersion < 33) {
          // For Android 12 and below (API level < 33)
          final status = await Permission.storage.request();
          if (!status.isGranted) {
            permissionGranted = false;
            
            if (status.isPermanentlyDenied && context.mounted) {
              _showPermissionPermanentlyDeniedDialog(context);
            }
            // Removed snackbar for permission denial
          }
        }

        if (permissionGranted) {
          try {
            if (sdkVersion >= 30) { // Android 11+
              // For Android 11+, we need different approach
              // First try to get the Downloads directory through getExternalStorageDirectory
              Directory? downloadsDir = await getExternalStorageDirectory();
              
              if (downloadsDir != null) {
                // Create a 'Downloads' subfolder in the app's external directory
                final appDownloadsDir = Directory('${downloadsDir.path}/Downloads');
                if (!await appDownloadsDir.exists()) {
                  await appDownloadsDir.create(recursive: true);
                }
                destinationPath = '${appDownloadsDir.path}/$fileName';
                log('Saving to app-specific Downloads folder: $destinationPath');
              } else {
                // Fallback to app documents directory
                final appDocDir = await getApplicationDocumentsDirectory();
                destinationPath = '${appDocDir.path}/$fileName';
                log('Fallback to app documents directory: $destinationPath');
          }
        } else {
              // For Android 10 and below, try to use the system Downloads folder
              final downloadsDir = Directory('/storage/emulated/0/Download');
              if (await downloadsDir.exists()) {
                destinationPath = '${downloadsDir.path}/$fileName';
                log('Using system Downloads folder: $destinationPath');
              } else {
                // If system Downloads folder is not accessible, use app's folder
                final appDir = await getExternalStorageDirectory();
                if (appDir != null) {
                  destinationPath = '${appDir.path}/$fileName';
                  log('Using app external storage: $destinationPath');
                } else {
                  // Fallback to app documents directory
                  final appDocDir = await getApplicationDocumentsDirectory();
                  destinationPath = '${appDocDir.path}/$fileName';
                  log('Fallback to app documents directory: $destinationPath');
                }
              }
            }
          } catch (e) {
            log('Error determining download path: $e');
            // Fallback to app documents directory
            final appDocDir = await getApplicationDocumentsDirectory();
            destinationPath = '${appDocDir.path}/$fileName';
            log('Fallback to app documents directory due to error: $destinationPath');
          }
        }
      } else if (Platform.isIOS) {
          // For iOS, use the documents directory
        final directory = await getApplicationDocumentsDirectory();
        destinationPath = '${directory.path}/$fileName';
        log('iOS documents directory: $destinationPath');
      }

      if (!permissionGranted) {
        log('Permission not granted, cannot save receipt');
        return;
      }

      // Ensure parent directory exists
      final parentDir = Directory(path.dirname(destinationPath));
      if (!await parentDir.exists()) {
        await parentDir.create(recursive: true);
      }

        // Copy the file
        await sourceFile.copy(destinationPath);
      log('File copied successfully to: $destinationPath');

      // Removed success snackbar notification
    } catch (e) {
      log('Error downloading receipt: $e');
      // Removed error snackbar notification
    }
  }

  // Helper method to show a dialog when permissions are permanently denied
  void _showPermissionPermanentlyDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Text(
            'Storage Permission Required',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Storage permission is permanently denied. Please enable it in app settings to download or share receipts.',
            style: GoogleFonts.outfit(),
          ),
          actions: [
            TextButton(
                onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.outfit(
                  color: Colors.grey[700],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                Navigator.of(context).pop();
                  openAppSettings();
                },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Open Settings',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                ),
                ),
              ),
            ],
        );
      },
    );
  }

  // Method to capture and save screenshot
  Future<void> _captureAndSaveScreenshot(BuildContext context, BuildContext dialogContext) async {
    try {
      // Get the render object from the global key
      final RenderRepaintBoundary boundary = _successDialogKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      
      // Capture the image with higher resolution
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      
      // Convert image to bytes
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      
      if (byteData == null) {
        // Failed to capture, but no snackbar notification
        return;
      }
      
      final Uint8List pngBytes = byteData.buffer.asUint8List();
      
      // Get Android SDK version to determine appropriate permission strategy
      int sdkVersion = 0;
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        sdkVersion = androidInfo.version.sdkInt;
        log('Android SDK Version: $sdkVersion');
      }
      
      String screenshotPath = '';
      bool permissionGranted = true;
      
      if (Platform.isAndroid) {
        if (sdkVersion < 33) {
          // For Android 12 and below (API level < 33)
          final status = await Permission.storage.request();
          if (!status.isGranted) {
            permissionGranted = false;
            
            if (status.isPermanentlyDenied && context.mounted) {
              _showPermissionPermanentlyDeniedDialog(context);
            }
            // No snackbar for permission denial
          }
        }
        
        if (permissionGranted) {
          try {
            // Generate a unique filename with timestamp
            final now = DateTime.now();
            final timestamp = '${now.day.toString().padLeft(2, '0')}${now.month.toString().padLeft(2, '0')}${now.year}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
            final screenshotFileName = 'Transfer_Screenshot_$timestamp.png';
            
            if (sdkVersion >= 30) { // Android 11+
              Directory? downloadsDir = await getExternalStorageDirectory();
              
              if (downloadsDir != null) {
                final appScreenshotsDir = Directory('${downloadsDir.path}/Screenshots');
                if (!await appScreenshotsDir.exists()) {
                  await appScreenshotsDir.create(recursive: true);
                }
                screenshotPath = '${appScreenshotsDir.path}/$screenshotFileName';
      } else {
                final appDocDir = await getApplicationDocumentsDirectory();
                screenshotPath = '${appDocDir.path}/$screenshotFileName';
              }
            } else {
              final downloadsDir = Directory('/storage/emulated/0/Download');
              if (await downloadsDir.exists()) {
                screenshotPath = '${downloadsDir.path}/$screenshotFileName';
              } else {
                final appDir = await getExternalStorageDirectory();
                if (appDir != null) {
                  screenshotPath = '${appDir.path}/$screenshotFileName';
                } else {
                  final appDocDir = await getApplicationDocumentsDirectory();
                  screenshotPath = '${appDocDir.path}/$screenshotFileName';
                }
        }
      }
    } catch (e) {
            log('Error determining screenshot path: $e');
            final appDocDir = await getApplicationDocumentsDirectory();
            final screenshotFileName = 'Transfer_Screenshot_${DateTime.now().millisecondsSinceEpoch}.png';
            screenshotPath = '${appDocDir.path}/$screenshotFileName';
          }
        }
      } else if (Platform.isIOS) {
        final directory = await getApplicationDocumentsDirectory();
        final screenshotFileName = 'Transfer_Screenshot_${DateTime.now().millisecondsSinceEpoch}.png';
        screenshotPath = '${directory.path}/$screenshotFileName';
      }
      
      if (!permissionGranted) {
        return;
      }
      
      // Ensure parent directory exists
      final parentDir = Directory(path.dirname(screenshotPath));
      if (!await parentDir.exists()) {
        await parentDir.create(recursive: true);
      }
      
      // Write the file
      final file = File(screenshotPath);
      await file.writeAsBytes(pngBytes);
      log('Screenshot saved to: $screenshotPath');
      
      // No success snackbar notification
      // No automatic sharing - just save the screenshot
      
    } catch (e) {
      log('Error capturing screenshot: $e');
      // No error snackbar
    }
  }

  // Helper method to automatically generate the receipt after a successful transfer
  Future<void> _generateReceiptAutomatically(TransferState state) async {
    try {
      if (!state.isTransferred || state.transferResponse == null) {
        throw Exception('Cannot generate receipt: Transfer data not available');
      }

      // Get transfer data from the bloc state
      final transferResponse = state.transferResponse!;
      final transactionId = state.transferId ?? transferResponse.transferId;

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
        toAccountId: transferResponse.toAccountId.toString(),
        fromName: widget.transferData['senderName']?.toString() ?? _userFullName ?? 'Account Holder',
        toName: widget.transferData['accountHolderName']?.toString() ?? 'Recipient',
        fromBank: 'Goh Betoch Bank',
        toBank: 'Goh Betoch Bank',
        currency: 'ETB',
        status: transferResponse.status,
        timestamp: '$formattedDate | $formattedTime',
        transactionRef: transferResponse.transactionRef,
        transactionType: 'Internal Transfer',
        primaryColor: Theme.of(context).colorScheme.primary,
        secondaryColor: Theme.of(context).colorScheme.secondary,
        accentColor: Colors.green,
        lightAccent: Colors.green.shade100,
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
