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

class ConfirmTransferScreen extends StatefulWidget {
  final Map<String, dynamic> transferData;

  const ConfirmTransferScreen({
    super.key,
    required this.transferData,
  });

  @override
  State<ConfirmTransferScreen> createState() => _ConfirmTransferScreenState();
}

class _ConfirmTransferScreenState extends State<ConfirmTransferScreen> {
  final TextEditingController _reasonController = TextEditingController();
  bool _isLoading = false;
  bool _isTransactionComplete = false;
  String? _transactionId;
  String? _errorMessage;
  late final AccountsBloc _accountsBloc;
  late final ExternalTransferBloc _transferBloc;
  bool _isDataLoading = false;
  String? _userFullName;
  Map<String, dynamic>? _senderAccount;

  @override
  void initState() {
    super.initState();
    _accountsBloc = getIt<AccountsBloc>();
    _transferBloc = getIt<ExternalTransferBloc>();
    
    // Check if data was preloaded from previous screen
    if (widget.transferData.containsKey('preloaded') && widget.transferData['preloaded'] == true) {
      // Use preloaded data
      _userFullName = widget.transferData['senderName'] as String?;
      _senderAccount = widget.transferData['senderAccount'] as Map<String, dynamic>?;
      
      if (_userFullName == null || _senderAccount == null) {
        _loadUserData();
      }
    } else {
      // Fall back to original loading behavior if data wasn't preloaded
      _isDataLoading = true;
      _loadUserData();

      // Check if accounts data is loaded
      if (_accountsBloc.state.accounts.isEmpty && !_accountsBloc.state.isLoading) {
        _accountsBloc.add(const FetchAccounts());
      } else if (_accountsBloc.state.accounts.isNotEmpty) {
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
    if (_accountsBloc.state.accounts.isNotEmpty) {
      final firstAccount = _accountsBloc.state.accounts.first;
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
              fontSize: 20.sp,
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
          bloc: _accountsBloc,
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
          bloc: _transferBloc,
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
                _transactionId = state.transferResponse?.id?.toString() ?? "ETX${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}";
              });
              
              // Show success dialog
              _showSuccessDialog(context, _transactionId!);
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
            'Confirm Transfer',
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
                'Review',
                style: GoogleFonts.outfit(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Please verify all details before confirming the transfer',
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
                                color: Colors.purple.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.swap_horiz_rounded,
                                color: Colors.purple,
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
                              'Transaction ID: ${_transactionId ?? "Pending"}',
                              style: GoogleFonts.outfit(
                                fontSize: 12.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 24.h),

                            // From (Sender)
                            _buildSectionLabel('From'),
                            SizedBox(height: 8.h),
                            _buildDetailRow('Name', _userFullName ?? 'Account Holder'),
                            _buildDetailRow('Account Number', _senderAccount?['accountNumber']?.toString() ?? ''),
                            _buildDetailRow('Bank', _senderAccount?['bank']?.toString() ?? ''),

                            SizedBox(height: 24.h),
                            Divider(height: 1, color: Colors.grey[300]),
                            SizedBox(height: 24.h),

                            // To (Receiver)
                            _buildSectionLabel('To'),
                            SizedBox(height: 8.h),
                            _buildDetailRow('Name', widget.transferData['accountHolderName'].toString()),
                            _buildDetailRow('Account Number', widget.transferData['accountNumber'].toString()),
                            _buildDetailRow('Bank', widget.transferData['name'].toString()),

                            SizedBox(height: 24.h),
                            Divider(height: 1, color: Colors.grey[300]),
                            SizedBox(height: 24.h),

                            // Amount Details
                            _buildSectionLabel('Amount'),
                            SizedBox(height: 8.h),
                            _buildDetailRow('Transfer Amount', '${amount.toStringAsFixed(2)} ETB'),
                            _buildDetailRow('Service Charge', '${fee.toStringAsFixed(2)} ETB'),
                            SizedBox(height: 16.h),
                            _buildDetailRow(
                              'Total Amount',
                              '${totalAmount.toStringAsFixed(2)} ETB',
                              valueStyle: GoogleFonts.outfit(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),

                            SizedBox(height: 24.h),
                            Divider(height: 1, color: Colors.grey[300]),
                            SizedBox(height: 24.h),

                            // Date and Time
                            _buildDetailRow('Date & Time', _formatDateTime(DateTime.now())),
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
                            contentPadding: EdgeInsets.symmetric(vertical: 8.h),
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
                isEnabled: !_isLoading,
                color: Theme.of(context).colorScheme.primary,
                text: _isLoading ? 'Processing...' : 'Confirm Transfer',
              ),

              // Show loading indicator if processing
              if (_isLoading) ...[
                SizedBox(height: 16.h),
                Center(
                  child: LinearProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  ),
                ),
              ],
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
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final date = '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
    final time = '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    return '$date at $time';
  }

  void _processTransfer(BuildContext context) {
    if (_isLoading || _isTransactionComplete) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final senderAccountId = int.tryParse(_senderAccount?['id']?.toString() ?? '') ?? 
                            int.tryParse(_senderAccount?['accountNumber']?.toString() ?? '') ?? 0;
                            
    if (senderAccountId <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid sender account'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final bankCode = widget.transferData['code']?.toString() ?? '';
    final toAccountNumber = widget.transferData['accountNumber']?.toString() ?? '';
    final double amount = (widget.transferData['amount'] as num).toDouble();
    final description = _reasonController.text;
    
    // Update transfer details in the bloc
    _transferBloc.add(
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
    _transferBloc.add(
      const ExternalTransferEvent.createTransferSubmitted(),
    );
  }

  void _showSuccessDialog(BuildContext context, String transactionId) {
    final amount = (widget.transferData['amount'] as num).toDouble();
    final fee = widget.transferData.containsKey('fee')
        ? (widget.transferData['fee'] as num).toDouble()
        : 0.0;

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

            // External transfer badge
            Container(
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: Colors.purple.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.swap_horiz_rounded,
                    color: Colors.purple,
                    size: 14.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'External Bank Transfer',
                    style: GoogleFonts.outfit(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.purple,
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
                    transactionId,
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
                  Navigator.of(context).pop();
                  Navigator.of(context).popUntil((route) => route.isFirst);
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
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.25),
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
          ],
        ),
      ),
    );
  }
}
