import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/transf/presentation/widget/continue_button.dart';

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
  bool _isLoading = false;
  bool _isFeeCalculated = false;
  String? _errorMessage;
  double? _calculatedFee;

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
        // Reset fee calculation when amount changes
        _isFeeCalculated = false;
        _calculatedFee = null;
      });
    }
  }

  void _onReasonChanged() {
    // No need to do anything special when reason changes
    // Just track the changes in the text controller
  }

  void _calculateFee() {
    // Validate input first
    if (_amountController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter an amount';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red[700],
        ),
      );
      return;
    }

    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      setState(() {
        _errorMessage = 'Please enter a valid amount';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red[700],
        ),
      );
      return;
    }

    // Simulate fee calculation
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simulate network delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;

      // Calculate fee based on bank and amount
      final amountValue = double.parse(_amountController.text);
      double calculatedFee;
      
      // Different fee structures for different banks
      final bankCode = widget.transferData['code'] as String;
      switch (bankCode) {
        case 'CBE':
          // CBE: 0.5% of amount or min 10 ETB, max 50 ETB
          calculatedFee = (amountValue * 0.005).clamp(10.0, 50.0);
          break;
        case 'DASHEN':
        case 'AWASH':
          // Dashen & Awash: 0.75% of amount or min 12 ETB, max 75 ETB
          calculatedFee = (amountValue * 0.0075).clamp(12.0, 75.0);
          break;
        default:
          // Other banks: 1% of amount or min 15 ETB, max 100 ETB
          calculatedFee = (amountValue * 0.01).clamp(15.0, 100.0);
      }

      setState(() {
        _isLoading = false;
        _isFeeCalculated = true;
        _calculatedFee = calculatedFee;
      });
    });
  }

  void _continueToConfirmation() {
    if (!_isFeeCalculated) {
      _calculateFee();
      return;
    }

    if (_hasInput && _calculatedFee != null) {
      // Add amount to transfer data and navigate to confirmation screen
      final completeTransferData = {
        ...widget.transferData,
        'amount': double.tryParse(_amountController.text) ?? 0.0,
        'fee': _calculatedFee ?? 0.0,
        'reason': _reasonController.text,
        'timestamp': DateTime.now().toIso8601String(),
      };

      // Navigate to confirmation screen
      context.pushNamed(RouteName.confirmTransfer, extra: completeTransferData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bankName = widget.transferData['name'] as String;
    final accountHolderName = widget.transferData['accountHolderName'] as String;
    final accountType = widget.transferData['accountType'] as String? ?? 'Account';
    
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
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.3)),
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
                        'Recipient Details',
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
                      'Bank', bankName),
                  SizedBox(height: 8.h),
                  _buildDetailRow('Account Number',
                      widget.transferData['accountNumber'].toString()),
                  SizedBox(height: 8.h),
                  _buildDetailRow('Account Holder',
                      accountHolderName),
                  SizedBox(height: 8.h),
                  _buildDetailRow('Account Type',
                      accountType),
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
            if (_isFeeCalculated && _calculatedFee != null) ...[
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.green.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.green[700],
                          size: 18.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'Transfer fee: ETB ${_calculatedFee!.toStringAsFixed(2)}',
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.green[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (double.tryParse(_amountController.text) != null) ...[
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          SizedBox(width: 26.w), // To align with the text above
                          Expanded(
                            child: Text(
                              'Total amount: ETB ${(double.parse(_amountController.text) + _calculatedFee!).toStringAsFixed(2)}',
                              style: GoogleFonts.outfit(
                                fontSize: 14.sp,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
                border: Border.all(
                  color: Colors.grey[300]!,
                ),
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
            if (_isLoading) ...[
              Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
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
            if (!_isLoading) ...[
              ContinueButton(
                onPressed: _continueToConfirmation,
                isEnabled: _hasInput,
                isLoading: false,
                text: _isFeeCalculated ? 'Continue' : 'Calculate Fee',
              ),
            ],
            SizedBox(height: 16.h),
          ],
        ),
      ),
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
        border: Border.all(
          color: Colors.grey[300]!,
        ),
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
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
