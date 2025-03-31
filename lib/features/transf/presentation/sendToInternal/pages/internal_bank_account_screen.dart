import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/transf/presentation/sendToExternal/widget/account_input_field.dart';
import 'package:super_app/features/transf/presentation/sendToExternal/widget/continue_button.dart';

class InternalBankAccountScreen extends StatefulWidget {
  const InternalBankAccountScreen({
    super.key,
  });

  @override
  State<InternalBankAccountScreen> createState() => _InternalBankAccountScreenState();
}

class _InternalBankAccountScreenState extends State<InternalBankAccountScreen> {
  final TextEditingController _accountNumberController = TextEditingController();
  bool _hasInput = false;
  
  @override
  void initState() {
    super.initState();
    _accountNumberController.addListener(_onInputChanged);
  }
  
  @override
  void dispose() {
    _accountNumberController.removeListener(_onInputChanged);
    _accountNumberController.dispose();
    super.dispose();
  }
  
  void _onInputChanged() {
    final text = _accountNumberController.text;
    final hasInput = text.isNotEmpty;
    
    if (hasInput != _hasInput) {
      setState(() {
        _hasInput = hasInput;
      });
    }
  }
  
  void _continueToNextScreen() {
    if (_hasInput) {
      // Navigate to the amount entry screen with bank and account number info
      final transferData = {
        'bank': 'Goh Betoch Bank',
        'logo': 'assets/banks/gohbetoch_bank.png',
        'accountNumber': _accountNumberController.text,
        'isInternal': true,
      };
      
      context.pushNamed(RouteName.bankAmount, extra: transferData);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          'Transfer to Goh Betoch Bank',
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
              'Enter Account Number',
              style: GoogleFonts.outfit(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Enter recipient Goh Betoch Bank account number.',
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 32.h),
            AccountInputField(
              label: 'Account Number',
              controller: _accountNumberController,
              hintText: 'Enter account number',
              errorMessage: null,
            ),
            const Spacer(),
            ContinueButton(
              onPressed: _continueToNextScreen,
              isEnabled: _hasInput,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
} 