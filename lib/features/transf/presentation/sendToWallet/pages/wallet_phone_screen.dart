import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/transf/application/wallet_transfer/wallet_transfer_bloc.dart';
import 'package:super_app/features/transf/application/wallet_transfer/wallet_transfer_event.dart';
import 'package:super_app/features/transf/application/wallet_transfer/wallet_transfer_state.dart';

class WalletPhoneScreen extends StatefulWidget {
  const WalletPhoneScreen({super.key});

  @override
  State<WalletPhoneScreen> createState() => _WalletPhoneScreenState();
}

class _WalletPhoneScreenState extends State<WalletPhoneScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill with default country code
    _phoneController.text = "+251 ";
    // Add listener for text changes
    _phoneController.addListener(_onPhoneChanged);
  }

  @override
  void dispose() {
    _phoneController.removeListener(_onPhoneChanged);
    _phoneController.dispose();
    super.dispose();
  }

  void _onPhoneChanged() {
    // Update phone number in BLoC
    context.read<WalletTransferBloc>().add(
          WalletTransferEvent.phoneNumberChanged(_phoneController.text),
        );
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

  void _validatePhoneNumber() {
    // Dispatch validation event to BLoC
    context.read<WalletTransferBloc>().add(
          const WalletTransferEvent.validatePhoneNumber(),
        );
  }

  void _navigateToAmountScreen() {
    // Navigate to amount screen
    context.pushNamed(RouteName.walletAmount);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletTransferBloc, WalletTransferState>(
      listener: (context, state) {
        // Handle error messages
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }

        // Handle phone validation success
        if (state.status == WalletTransferStatus.phoneValidated) {
          _navigateToAmountScreen();
        }
      },
      builder: (context, state) {
        final bool isPhoneValidated =
            state.status == WalletTransferStatus.phoneValidated;
        final bool isValidating =
            state.status == WalletTransferStatus.validatingPhone;
        final bool isPhoneValid = state.phoneNumberInput.length > 5;
        final String providerName =
            state.selectedProvider?['name'] as String? ?? 'Wallet';

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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
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
                          if (state.validatedWallet != null) ...[
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
                                          _getInitials(state.validatedWallet!
                                                  .accountHolderName ??
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
                                            state.validatedWallet!
                                                    .accountHolderName ??
                                                'Unknown User',
                                            style: GoogleFonts.outfit(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            state.phoneNumberInput,
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
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],

                          // Show loading indicator while validating
                          if (isValidating) ...[
                            SizedBox(height: 24.h),
                            Center(
                              child: Column(
                                children: [
                                  CircularProgressIndicator(
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                              height:
                                  MediaQuery.of(context).viewInsets.bottom > 0
                                      ? 200.h
                                      : 0),
                        ],
                      ),
                    ),
                  ),
                ),

                // Continue button in a separate container outside the scroll view
                if (state.validatedWallet == null && !isValidating) ...[
                  Container(
                    padding: EdgeInsets.all(20.w),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: isPhoneValid ? _validatePhoneNumber : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
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
      },
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
