import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/transf/presentation/widget/account_input_field.dart';
import 'package:super_app/features/transf/presentation/widget/continue_button.dart';

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
  bool _showAccountInfo = false;
  String _accountHolderName = "Abebe Kebede"; // Mock data - normally this would come from an API call
  
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
  
  void _verifyAccount() {
    // In a real app, this would make an API call to verify the account
    // For now, we'll just show the mock account info
    setState(() {
      _showAccountInfo = true;
    });
  }
  
  void _continueToNextScreen() {
    if (!_showAccountInfo) {
      _verifyAccount();
      return;
    }
    
    print("Continue to next screen called");
    print("Account number: ${_accountNumberController.text}");
    print("Has input: $_hasInput");
    
    // Create transfer data (always proceed for testing)
    final transferData = {
      'bank': 'Goh Betoch Bank',
      'logo': 'assets/banks/gohbetoch_bank.png',
      'accountNumber': _accountNumberController.text.isEmpty ? '1234567890' : _accountNumberController.text,
      'isInternal': true,
      'accountHolderName': _accountHolderName,
    };
    
    print("Navigating to amount screen with data: $transferData");
    
    // Navigate to the amount entry screen
    context.pushNamed(RouteName.internalBankAmount, extra: transferData);
  }
  
  void _navigateToAmountScreen() {
    // Create transfer data
    final transferData = {
      'bank': 'Goh Betoch Bank',
      'logo': 'assets/banks/gohbetoch_bank.png',
      'accountNumber': _accountNumberController.text.isEmpty ? '1234567890' : _accountNumberController.text,
      'isInternal': true,
      'accountHolderName': _accountHolderName,
    };
    
    // Navigate to the amount entry screen
    context.pushNamed(RouteName.internalBankAmount, extra: transferData);
  }

  String _getInitials(String name) {
    List<String> parts = name.split(' ');
    if (parts.length > 1) {
      return parts[0][0].toUpperCase() + parts[1][0].toUpperCase();
    } else if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    } else {
      return '';
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
            SizedBox(height: 24.h),
            
            // Account information section (visible only after verification)
            if (_showAccountInfo) ...[
              GestureDetector(
                onTap: _navigateToAmountScreen,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      // Profile circle with initials
                      Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey[300]!, width: 1),
                        ),
                        child: Center(
                          child: Text(
                            _getInitials(_accountHolderName),
                            style: GoogleFonts.outfit(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      
                      // Name and account number
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _accountHolderName.toUpperCase(),
                              style: GoogleFonts.outfit(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              _accountNumberController.text.isEmpty 
                                  ? "1234567890" 
                                  : _accountNumberController.text,
                              style: GoogleFonts.outfit(
                                fontSize: 14.sp,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Forward arrow
                      Icon(
                        Icons.chevron_right,
                        size: 24.sp,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
            
            const Spacer(),
            
            // Continue button - only shown when account info is not visible
            if (!_showAccountInfo) ...[
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: _continueToNextScreen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 