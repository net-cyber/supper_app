import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/features/transf/presentation/sendToExternal/widget/continue_button.dart';

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
  
  // Mock data for sender (in a real app, this would come from user profile/auth)
  final Map<String, String> _sender = {
    'name': 'Bereket Tefera',
    'accountNumber': '1234567890',
    'bank': 'Goh Betoch Bank',
  };
  
  // Service charge (would typically be calculated based on amount and bank)
  final double _serviceCharge = 10.0;
  
  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total amount with service charge
    final double amount = widget.transferData['amount'];
    final double totalAmount = amount + _serviceCharge;
    
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
                    // Single receipt-like card with all transfer details
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
                          // Header with bank logos or transfer icon
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
                            'Transaction ID: ${DateTime.now().millisecondsSinceEpoch}',
                            style: GoogleFonts.outfit(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 24.h),
                          
                          // From (Sender)
                          _buildSectionLabel('From'),
                          SizedBox(height: 8.h),
                          _buildDetailRow('Name', _sender['name']!),
                          _buildDetailRow('Account Number', _sender['accountNumber']!),
                          _buildDetailRow('Bank', _sender['bank']!),
                          
                          SizedBox(height: 24.h),
                          Divider(height: 1, color: Colors.grey[300]),
                          SizedBox(height: 24.h),
                          
                          // To (Receiver)
                          _buildSectionLabel('To'),
                          SizedBox(height: 8.h),
                          _buildDetailRow('Name', widget.transferData['accountHolderName']),
                          _buildDetailRow('Account Number', widget.transferData['accountNumber']),
                          _buildDetailRow('Bank', widget.transferData['name']),
                          
                          SizedBox(height: 24.h),
                          Divider(height: 1, color: Colors.grey[300]),
                          SizedBox(height: 24.h),
                          
                          // Amount Details
                          _buildSectionLabel('Amount'),
                          SizedBox(height: 8.h),
                          _buildDetailRow('Transfer Amount', '${amount.toStringAsFixed(2)} ETB'),
                          _buildDetailRow('Service Charge', '${_serviceCharge.toStringAsFixed(2)} ETB'),
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
                        maxLines: 3,
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
              isEnabled: true,
              color: Theme.of(context).colorScheme.primary,
              text: 'Confirm Transfer',
            ),
          ],
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
            style: valueStyle ?? GoogleFonts.outfit(
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
    // Create final transfer data with reason
    final completeTransferData = {
      ...widget.transferData,
      'reason': _reasonController.text,
      'serviceCharge': _serviceCharge,
      'totalAmount': widget.transferData['amount'] + _serviceCharge,
      'sender': _sender,
      'timestamp': DateTime.now().toString(),
      'transactionId': DateTime.now().millisecondsSinceEpoch.toString(),
    };
    
    // Show success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 64.sp,
            ),
            SizedBox(height: 16.h),
            Text(
              'Transfer Successful!',
              style: GoogleFonts.outfit(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Your transfer of ${completeTransferData['amount'].toStringAsFixed(2)} ETB to ${widget.transferData['accountHolderName']} has been processed successfully.',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Close dialog and navigate back to home screen
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
                    height: 48.h,
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