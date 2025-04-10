import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/mobile_topup/presentation/widgets/common/phone_input_field.dart';

enum TopupType { self, others }

class PhoneNumberScreen extends StatefulWidget {
  final String operatorName;
  final String operatorLogo;

  const PhoneNumberScreen({
    Key? key,
    required this.operatorName,
    required this.operatorLogo,
  }) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String _countryCode = '+251';
  TopupType _topupType = TopupType.self;
  bool _isPhoneValid = false;
  bool _isSubmitting = false;

  // Mock user phone numbers based on operator
  late String _userPhoneNumber;

  @override
  void initState() {
    super.initState();
    // Set the appropriate mock phone number based on operator
    _userPhoneNumber = widget.operatorName.toLowerCase().contains('safaricom')
        ? '712345678' // Safaricom number starting with 7
        : '912345678'; // Ethio-Telecom number starting with 9

    // Initialize with user's phone number for self top-up
    if (_topupType == TopupType.self) {
      _phoneController.text = _userPhoneNumber;
      _validatePhoneNumber(_userPhoneNumber);
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleBackNavigation(BuildContext context) {
    try {
      // Try to pop the current route
      context.pop();
    } catch (e) {
      // If popping fails, navigate to the mobile topup operator selection screen
      context.goNamed(RouteName.mobileTopup);
    }
  }

  void _validatePhoneNumber(String value) {
    // Check if phone number starts with correct digit for the operator
    final bool startsWithCorrectDigit =
        widget.operatorName.toLowerCase().contains('safaricom')
            ? (value.isNotEmpty && value.startsWith('7'))
            : (value.isNotEmpty && value.startsWith('9'));

    setState(() {
      _isPhoneValid = value.length >= 9 && startsWithCorrectDigit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => _handleBackNavigation(context),
        ),
        title: Text(
          'Mobile Top-up',
          style: GoogleFonts.outfit(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            // Operator logo
            Center(
              child: Image.asset(
                widget.operatorLogo.isNotEmpty
                    ? widget.operatorLogo
                    : 'assets/tele-logo.png',
                height: 60.h,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback if the image still can't be loaded
                  return Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.phone_android,
                      size: 32.sp,
                      color: Colors.grey[600],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 30.h),

            // Tab selection
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                children: [
                  _buildTab('Self', TopupType.self),
                  _buildTab('Others', TopupType.others),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            // Phone number label
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'Phone Number',
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: 10.h),

            // Phone number input using reusable widget
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: PhoneInputField(
                controller: _phoneController,
                countryCode: _countryCode,
                flagAssetPath: 'assets/ethio-flag.png',
                operatorName: widget.operatorName,
                onContactsTap: _topupType == TopupType.others
                    ? () {
                        // Handle contacts tap
                      }
                    : null,
                onChanged: (value) {
                  if (_topupType == TopupType.others) {
                    _validatePhoneNumber(value);
                  }
                },
              ),
            ),

            const Spacer(),

            // Continue button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: _isPhoneValid && !_isSubmitting
                      ? () {
                          // Save data to pass to the next screen
                          final Map<String, dynamic> extraData = {
                            'phoneNumber': _phoneController.text,
                            'operatorName': widget.operatorName,
                            'operatorLogo': widget.operatorLogo,
                          };

                          // Navigate to amount selection screen
                          context.goNamed(
                            RouteName.mobileTopupAmount,
                            extra: extraData,
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isPhoneValid ? Colors.indigo[900] : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    elevation: 0,
                  ),
                  child: _isSubmitting
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2.w,
                        )
                      : Text(
                          'Continue',
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
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

  Widget _buildTab(String title, TopupType type) {
    final bool isSelected = _topupType == type;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _topupType = type;
            if (type == TopupType.self) {
              _phoneController.text = _userPhoneNumber;
              _validatePhoneNumber(_userPhoneNumber);
            } else {
              // For Others tab, clear or set starting digit
              if (widget.operatorName.toLowerCase().contains('safaricom')) {
                _phoneController.text = '7'; // Prefill with 7 for Safaricom
              } else {
                _phoneController.text = '9'; // Prefill with 9 for Ethio-Telecom
              }
              _validatePhoneNumber(_phoneController.text);
            }
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
