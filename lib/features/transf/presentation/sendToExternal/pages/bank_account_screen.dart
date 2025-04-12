import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/transf/presentation/widget/account_input_field.dart';
import 'package:super_app/features/transf/presentation/widget/continue_button.dart';

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

  // Map of sample accounts for validation - different account formats for different banks
  final Map<String, Map<String, Map<String, dynamic>>> _bankAccounts = {
    'CBE': {
      '1000123456': {
      'accountHolderName': 'Abebe Kebede',
        'accountNumber': '1000123456',
        'bankName': 'Commercial Bank of Ethiopia',
        'branch': 'Addis Ababa Main Branch',
        'accountType': 'Savings',
      },
      '1000789012': {
        'accountHolderName': 'Hiwot Tesfaye',
        'accountNumber': '1000789012',
      'bankName': 'Commercial Bank of Ethiopia',
        'branch': 'Bole Branch',
        'accountType': 'Current',
      }
    },
    'DASHEN': {
      '0152345678': {
      'accountHolderName': 'Tigist Haile',
        'accountNumber': '0152345678',
      'bankName': 'Dashen Bank',
        'branch': 'Megenagna Branch',
        'accountType': 'Savings',
      }
    },
    'AWASH': {
      '00123456789': {
      'accountHolderName': 'Solomon Tesfaye',
        'accountNumber': '00123456789',
      'bankName': 'Awash Bank',
        'branch': 'Merkato Branch',
        'accountType': 'Current',
      }
    },
    'ABYSSINIA': {
      'ETB-456789123': {
      'accountHolderName': 'Meron Tadesse',
        'accountNumber': 'ETB-456789123',
      'bankName': 'Abyssinia Bank',
        'branch': 'Piassa Branch',
        'accountType': 'Savings',
      }
    },
    // Default test accounts for all banks
    'DEFAULT': {
      '1234567890': {
        'accountHolderName': 'John Doe',
        'accountNumber': '1234567890',
        'bankName': 'Test Bank',
        'branch': 'Test Branch',
        'accountType': 'Savings',
      },
    '158040484': {
        'accountHolderName': 'Jane Smith',
      'accountNumber': '158040484',
        'bankName': 'Test Bank',
        'branch': 'Test Branch',
        'accountType': 'Current',
      }
    }
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
    // Default to test account number if empty
    final accountNumber = _accountNumberController.text.isEmpty
        ? '158040484'
        : _accountNumberController.text;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simulate network delay
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;

      // Try to find account in the specific bank's account list
      final bankCode = widget.bank['code'] as String;
      Map<String, dynamic>? foundAccount;

      // Check in bank-specific accounts
      if (_bankAccounts.containsKey(bankCode) && 
          _bankAccounts[bankCode]!.containsKey(accountNumber)) {
        foundAccount = _bankAccounts[bankCode]![accountNumber];
      } 
      // If not found, check in DEFAULT accounts
      else if (_bankAccounts['DEFAULT']!.containsKey(accountNumber)) {
        foundAccount = _bankAccounts['DEFAULT']![accountNumber];
        // Update bank name to match the selected bank
        foundAccount = {
          ...foundAccount!,
          'bankName': widget.bank['name'],
        };
      }

      if (foundAccount != null) {
        // Account exists in our sample data
        setState(() {
          _isLoading = false;
          _isAccountValidated = true;
          _validatedAccount = foundAccount;
        });
      } else {
        // Account doesn't exist
        setState(() {
          _isLoading = false;
          _isAccountValidated = false;
          _errorMessage = 'Account not found. Please check the account number.';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage!),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red[700],
            action: SnackBarAction(
              label: 'Try Again',
              textColor: Colors.white,
              onPressed: () {
                _accountNumberController.clear();
                FocusScope.of(context).requestFocus(FocusNode());
              },
            ),
          ),
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
      'accountHolderName': _validatedAccount?['accountHolderName'] ?? 'John Doe',
      'accountType': _validatedAccount?['accountType'] ?? 'Savings',
      'branch': _validatedAccount?['branch'] ?? 'Main Branch',
      'timestamp': DateTime.now().toIso8601String(),
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
    } else if (parts.length == 1 && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bankName = widget.bank['name'] as String;
    final bankCode = widget.bank['code'] as String;
    
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
          'Transfer to $bankName',
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
            // Bank info header
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey[300]!),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        bankCode,
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bankName,
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        if (widget.bank.containsKey('swift'))
                          Text(
                            'SWIFT: ${widget.bank['swift']}',
                            style: GoogleFonts.outfit(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24.h),
            
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
              'Enter recipient bank account number for $bankName.',
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'For testing, you can use account numbers: 1234567890 or 158040484',
              style: GoogleFonts.outfit(
                fontSize: 12.sp,
                color: Colors.grey[500],
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 16.h),
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
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Profile circle with initials
                      Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _getInitials(_validatedAccount!['accountHolderName']
                                as String),
                            style: GoogleFonts.outfit(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
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
                            SizedBox(height: 4.h),
                            Text(
                              _validatedAccount!['accountType'] as String,
                              style: GoogleFonts.outfit(
                                fontSize: 12.sp,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Forward arrow and tap indicator
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Icon(
                            Icons.arrow_forward_ios,
                            size: 20.sp,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Tap to continue",
                            style: GoogleFonts.outfit(
                              fontSize: 10.sp,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
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
                    CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
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
              ContinueButton(
                onPressed: _continueToNextScreen,
                isEnabled: _hasInput,
                isLoading: false,
                text: 'Continue',
              ),
            ],
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
