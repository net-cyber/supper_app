import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/transf/presentation/widget/account_input_field.dart';

class BankAccountScreen extends StatefulWidget {
  final Map<String, dynamic> bank;

  const BankAccountScreen({
    super.key,
    required this.bank,
  });

  @override
  State<BankAccountScreen> createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  final TextEditingController _accountNumberController =
      TextEditingController();
  bool _hasInput = false;
  bool _isLoading = false;
  bool _isAccountValidated = false;
  String? _errorMessage;

  // Mock validated account data
  Map<String, dynamic>? _validatedAccount;

  // Map of sample accounts for validation
  final Map<String, Map<String, dynamic>> _sampleAccounts = {
    '1234567890': {
      'accountHolderName': 'Abebe Kebede',
      'accountNumber': '1234567890',
      'bankName': 'Commercial Bank of Ethiopia',
    },
    '2345678901': {
      'accountHolderName': 'Tigist Haile',
      'accountNumber': '2345678901',
      'bankName': 'Dashen Bank',
    },
    '3456789012': {
      'accountHolderName': 'Solomon Tesfaye',
      'accountNumber': '3456789012',
      'bankName': 'Awash Bank',
    },
    '4567890123': {
      'accountHolderName': 'Meron Tadesse',
      'accountNumber': '4567890123',
      'bankName': 'Abyssinia Bank',
    },
    // Default test account
    '158040484': {
      'accountHolderName': 'John Doe',
      'accountNumber': '158040484',
      'bankName': 'Commercial Bank of Ethiopia',
    },
  };

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
        // Reset validation when input changes
        _isAccountValidated = false;
        _validatedAccount = null;
        _errorMessage = null;
      });
    }
  }

  void _verifyAccount() {
    final accountNumber = _accountNumberController.text.isEmpty
        ? '158040484'
        : _accountNumberController.text;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simulate network delay
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      if (_sampleAccounts.containsKey(accountNumber)) {
        // Account exists in our sample data
        setState(() {
          _isLoading = false;
          _isAccountValidated = true;
          _validatedAccount = _sampleAccounts[accountNumber];
        });
      } else {
        // Account doesn't exist
        setState(() {
          _isLoading = false;
          _isAccountValidated = false;
          _errorMessage = 'Account not found. Please check the account number.';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_errorMessage!)),
        );
      }
    });
  }

  void _continueToNextScreen() {
    if (!_isAccountValidated) {
      _verifyAccount();
      return;
    }

    _navigateToAmountScreen();
  }

  void _navigateToAmountScreen() {
    // Create transfer data object to pass to the next screen
    final accountNumber = _accountNumberController.text.isEmpty
        ? '158040484'
        : _accountNumberController.text;

    final transferData = {
      ...widget.bank,
      'accountNumber': accountNumber,
      'accountHolderName':
          _validatedAccount?['accountHolderName'] ?? 'John Doe',
    };

    context.pushNamed(RouteName.bankAmount, extra: transferData);
  }

  String _getInitials(String name) {
    List<String> parts = name.split(' ');
    if (parts.length > 1) {
      return parts[0][0].toUpperCase() +
          (parts.length > 2
              ? parts[2][0].toUpperCase()
              : parts[1][0].toUpperCase());
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
          'Transfer to ${widget.bank['name']}',
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
              'Enter recipient bank account number.',
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
              errorMessage: _errorMessage,
            ),
            SizedBox(height: 24.h),

            // Account information section (visible only after verification)
            if (_isAccountValidated && _validatedAccount != null) ...[
              GestureDetector(
                onTap: _navigateToAmountScreen,
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
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
                          border:
                              Border.all(color: Colors.grey[300]!, width: 1),
                        ),
                        child: Center(
                          child: Text(
                            _getInitials(_validatedAccount!['accountHolderName']
                                as String),
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
                              _validatedAccount!['accountHolderName'] as String,
                              style: GoogleFonts.outfit(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              _accountNumberController.text.isEmpty
                                  ? "158040484"
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

            // Loading indicator when validating account
            if (_isLoading) ...[
              Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16.h),
                    Text(
                      'Verifying account...',
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Continue button - only shown when account info is not visible
            if (!_isAccountValidated && !_isLoading) ...[
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: _hasInput ? _continueToNextScreen : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _hasInput
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[300],
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
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
