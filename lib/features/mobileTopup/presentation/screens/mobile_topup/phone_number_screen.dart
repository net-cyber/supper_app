import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/mobileTopup/application/mobile_topup/bloc/mobile_topup.dart';
import 'package:super_app/features/mobileTopup/presentation/widgets/common/phone_input_field.dart';

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

  // TODO: Replace with actual user phone number from auth repository
  final String _userPhoneNumber = '912345678'; // Mock user phone number

  @override
  void initState() {
    super.initState();
    // Set the operator details in the bloc
    context.read<MobileTopupBloc>().add(OperatorSelected(
          operatorName: widget.operatorName,
          operatorLogo: widget.operatorLogo,
        ));
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MobileTopupBloc, MobileTopupState>(
      builder: (context, state) {
        // Set phone number for self top-up
        if (state.topupType == TopupType.self &&
            _phoneController.text.isEmpty) {
          _phoneController.text = _userPhoneNumber;
          context
              .read<MobileTopupBloc>()
              .add(PhoneNumberChanged(_userPhoneNumber));
        }

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
                      _buildTab(context, 'Self', TopupType.self),
                      _buildTab(context, 'Others', TopupType.others),
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
                    onContactsTap: state.topupType == TopupType.others
                        ? () {
                            // Handle contacts tap
                          }
                        : null,
                    onChanged: (value) {
                      if (state.topupType == TopupType.others) {
                        context
                            .read<MobileTopupBloc>()
                            .add(PhoneNumberChanged(value));
                      }
                    },
                  ),
                ),

                // Error message if any
                if (state.errorMessage != null)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Text(
                      state.errorMessage!,
                      style: GoogleFonts.outfit(
                        color: Colors.red,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),

                const Spacer(),

                // Continue button
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55.h,
                    child: ElevatedButton(
                      onPressed: state.isPhoneValid && !state.isSubmitting
                          ? () {
                              // Navigate to amount selection screen
                              context.goNamed(RouteName.mobileTopupAmount);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.isPhoneValid
                            ? Colors.indigo[900]
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        elevation: 0,
                      ),
                      child: state.isSubmitting
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
      },
    );
  }

  Widget _buildTab(BuildContext context, String title, TopupType type) {
    final state = context.watch<MobileTopupBloc>().state;
    final isSelected = state.topupType == type;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<MobileTopupBloc>().add(TopupTypeChanged(type));
          if (type == TopupType.self) {
            _phoneController.text = _userPhoneNumber;
            context
                .read<MobileTopupBloc>()
                .add(PhoneNumberChanged(_userPhoneNumber));
          } else {
            _phoneController.clear();
            context.read<MobileTopupBloc>().add(const PhoneNumberChanged(''));
          }
        },
        child: Container(
          height: 50.h,
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
