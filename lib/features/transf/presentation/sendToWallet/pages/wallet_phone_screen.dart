import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';

class WalletPhoneScreen extends StatefulWidget {
  final Map<String, dynamic>? walletProvider;

  const WalletPhoneScreen({
    super.key,
    this.walletProvider,
  });

  @override
  State<WalletPhoneScreen> createState() => _WalletPhoneScreenState();
}

class _WalletPhoneScreenState extends State<WalletPhoneScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isValidating = false;
  Map<String, dynamic>? _validatedWallet;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Pre-fill with default country code
    _phoneController.text = "+251 ";
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  String _getInitials(String name) {
    List<String> parts = name.split(' ');
    if (parts.length > 1) {
      return parts[0][0].toUpperCase() + parts[1][0].toUpperCase();
    } else if (parts.length == 1 && parts[0].isNotEmpty) {
      return parts[0][0].toUpperCase();
    } else {
      return 'NA';
    }
  }

  bool get _isPhoneValid => _phoneController.text.length > 5;

  void _validatePhoneNumber() {
    // Mock wallet verification
    setState(() {
      _isValidating = true;
      _errorMessage = null;
    });

    // Simulate network request delay
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      // Simulate successful verification for a specific number
      final String phoneNumber = _phoneController.text;
      if (phoneNumber.contains('928')) {
        // Success case
        setState(() {
          _isValidating = false;
          _validatedWallet = {
            'accountHolderName': 'Abebe Kebede',
            'phoneNumber': phoneNumber,
            'accountNumber': '123456789',
          };
        });
      } else {
        // Error case
        setState(() {
          _isValidating = false;
          _errorMessage = 'No wallet account found with this phone number';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_errorMessage!)),
        );
      }
    });
  }

  void _navigateToAmountScreen() {
    // Navigate to amount screen with validated data
    context.pushNamed(RouteName.walletAmount, extra: {
      'walletProvider': widget.walletProvider,
      'phoneNumber': _phoneController.text,
      'validatedWallet': _validatedWallet,
    });
  }

  @override
  Widget build(BuildContext context) {
    final String providerName =
        widget.walletProvider?['name'] as String? ?? 'Wallet';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Enter Wallet Phone',
          style: GoogleFonts.outfit(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      // Use a resizeToAvoidBottomInset to prevent keyboard from causing overflow
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            // Use Expanded with SingleChildScrollView for scrollable content area
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Wallet information section with branding
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 40.w,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.account_balance_wallet_rounded,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      size: 24.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  '$providerName Wallet',
                                  style: GoogleFonts.outfit(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            _buildDetailRow('Provider', providerName),
                            SizedBox(height: 8.h),
                            _buildDetailRow('Country', 'Ethiopia'),
                          ],
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Phone input section
                      Text(
                        'Enter Phone Number',
                        style: GoogleFonts.outfit(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Please enter the phone number associated with your wallet',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _buildPhoneInput(),

                      SizedBox(height: 24.h),

                      // User information section (visible only after verification)
                      if (_validatedWallet != null) ...[
                        GestureDetector(
                          onTap: _navigateToAmountScreen,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.3),
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _getInitials(
                                          _validatedWallet!['accountHolderName']
                                                  as String? ??
                                              'Unknown User'),
                                      style: GoogleFonts.outfit(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),

                                // Name and phone number
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _validatedWallet!['accountHolderName']
                                                as String? ??
                                            'Unknown User',
                                        style: GoogleFonts.outfit(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        _phoneController.text,
                                        style: GoogleFonts.outfit(
                                          fontSize: 14.sp,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Forward arrow
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.sp,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],

                      // Show loading indicator while validating
                      if (_isValidating) ...[
                        SizedBox(height: 24.h),
                        Center(
                          child: Column(
                            children: [
                              CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'Verifying phone number...',
                                style: GoogleFonts.outfit(
                                  fontSize: 14.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Add additional space at the bottom when keyboard is visible
                      SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom > 0
                              ? 200.h
                              : 0),
                    ],
                  ),
                ),
              ),
            ),

            // Continue button in a separate container outside the scroll view
            if (_validatedWallet == null && !_isValidating) ...[
              Container(
                padding: EdgeInsets.all(20.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: _isPhoneValid ? _validatePhoneNumber : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      disabledBackgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: GoogleFonts.outfit(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
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

  Widget _buildPhoneInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.r),
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
            child: Row(
              children: [
                _buildEthiopianFlag(),
                SizedBox(width: 8.w),
              ],
            ),
          ),
          Expanded(
            child: TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: '928 870 057',
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
              inputFormatters: [
                // Allow only numbers after the country code
                FilteringTextInputFormatter.allow(RegExp(r'^\+251 \d*$')),
              ],
              onChanged: (value) {
                // Force refresh to update continue button state
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEthiopianFlag() {
    // Simple Ethiopian flag
    return Container(
      width: 32.w,
      height: 24.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        // Simplified Ethiopian flag colors
        gradient: const LinearGradient(
          colors: [
            Color(0xFF078930), // Green
            Color(0xFFFFCE00), // Yellow
            Color(0xFFD00F35), // Red
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
