import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';

class AmountSelectionScreen extends StatefulWidget {
  const AmountSelectionScreen({Key? key}) : super(key: key);

  @override
  State<AmountSelectionScreen> createState() => _AmountSelectionScreenState();
}

class _AmountSelectionScreenState extends State<AmountSelectionScreen> {
  // Predefined airtime amounts
  final List<int> _amounts = [5, 10, 15, 25, 50, 100, 300, 600, 1000];
  int _selectedAmount = 0; // Default selected amount is zero

  // Mock account data
  final String _accountNumber = '2991083724811';
  final String _maskedCardNumber = 'ETB **********';

  // Data from previous screen
  late String _phoneNumber;
  late String _operatorName;
  late String _operatorLogo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get data passed from previous screen
    final Map<String, dynamic>? extraData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            GoRouterState.of(context).extra as Map<String, dynamic>?;

    if (extraData != null) {
      _phoneNumber = extraData['phoneNumber'] as String? ?? '';
      _operatorName = extraData['operatorName'] as String? ?? '';
      _operatorLogo = extraData['operatorLogo'] as String? ?? '';
    } else {
      _phoneNumber = '';
      _operatorName = '';
      _operatorLogo = '';
    }
  }

  void _handleBackNavigation(BuildContext context) {
    try {
      context.pop();
    } catch (e) {
      // Navigate to phone number screen with operator details
      context.goNamed(
        RouteName.mobileTopupPhoneNumber,
        extra: {
          'operatorName':
              _operatorName.isNotEmpty ? _operatorName : 'Ethio-Telecom',
          'operatorLogo':
              _operatorLogo.isNotEmpty ? _operatorLogo : 'assets/tele-logo.png',
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if an amount is selected
    final bool isAmountSelected = _selectedAmount > 0;

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
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Phone number display
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(20.w),
                padding: EdgeInsets.symmetric(vertical: 15.h),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  '+251-$_phoneNumber',
                  style: GoogleFonts.outfit(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Account selection section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Account',
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // Account selector with dropdown
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _accountNumber,
                            style: GoogleFonts.outfit(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_down, color: Colors.black),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),

                    // Masked card number
                    Row(
                      children: [
                        Text(
                          _maskedCardNumber,
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.indigo[900],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.grey[500],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Amount display
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '$_selectedAmount',
                        style: GoogleFonts.montserrat(
                          fontSize: 60.sp,
                          fontWeight: FontWeight.bold,
                          color: isAmountSelected
                              ? Colors.indigo[900]
                              : Colors.grey,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        '(ETB)',
                        style: GoogleFonts.outfit(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: isAmountSelected
                              ? Colors.indigo[900]
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Predefined amounts section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Defined Airtimes',
                      style: GoogleFonts.outfit(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15.h),

                    // Grid of amount buttons
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: _amounts.length,
                      itemBuilder: (context, index) {
                        final amount = _amounts[index];
                        final isSelected = amount == _selectedAmount;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedAmount = amount;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.indigo[900]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ETB',
                                  style: GoogleFonts.outfit(
                                    fontSize: 14.sp,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  amount.toString(),
                                  style: GoogleFonts.outfit(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              // Continue button
              Padding(
                padding: EdgeInsets.all(20.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: isAmountSelected
                        ? () {
                            // Save data to pass to the next screen
                            final Map<String, dynamic> extraData = {
                              'phoneNumber': _phoneNumber,
                              'operatorName': _operatorName,
                              'operatorLogo': _operatorLogo,
                              'amount': _selectedAmount.toDouble(),
                            };

                            // Navigate to confirmation screen
                            context.goNamed(
                              RouteName.mobileTopupConfirmation,
                              extra: extraData,
                            );
                          }
                        : null, // Disable button when no amount is selected
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isAmountSelected ? Colors.indigo[900] : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
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
      ),
    );
  }
}
