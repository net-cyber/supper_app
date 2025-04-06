import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:super_app/core/theme/app_colors.dart';
import 'package:super_app/features/mortgages/domain/entities/property.dart';
import 'package:super_app/features/mortgages/presentation/screens/mortgage_tracking_screen.dart';

class MortgageApplicationScreen extends StatefulWidget {

  const MortgageApplicationScreen({
    Key? key,
    required this.property,
  }) : super(key: key);
  final Property property;

  @override
  State<MortgageApplicationScreen> createState() => _MortgageApplicationScreenState();
}

class _MortgageApplicationScreenState extends State<MortgageApplicationScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  
  // Form controllers
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _monthlyIncomeController = TextEditingController();
  final _employerController = TextEditingController();
  
  // Loan details
  double _downPaymentPercentage = 20;
  int _loanTermYears = 20;
  
  final currencyFormat = NumberFormat.currency(
    locale: 'en_ET',
    symbol: 'ETB ',
    decimalDigits: 0,
  );

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _idNumberController.dispose();
    _monthlyIncomeController.dispose();
    _employerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Mortgage Application',
          style: GoogleFonts.outfit(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Progress indicator
          LinearProgressIndicator(
            value: (_currentStep + 1) / 3,
            backgroundColor: Colors.grey[200],
            color: AppColors.primaryColor,
          ),
          
          // Steps indicator
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                _buildStepIndicator(0, 'Personal Info'),
                _buildStepConnector(_currentStep >= 1),
                _buildStepIndicator(1, 'Financial Info'),
                _buildStepConnector(_currentStep >= 2),
                _buildStepIndicator(2, 'Loan Details'),
              ],
            ),
          ),
          
          // Form content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: _formKey,
                child: _buildCurrentStep(),
              ),
            ),
          ),
          
          // Bottom buttons
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _currentStep--;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        side: BorderSide(color: Colors.grey[400]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Previous',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                if (_currentStep > 0) SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentStep < 2) {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _currentStep++;
                          });
                        }
                      } else {
                        _submitApplication();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      _currentStep < 2 ? 'Next' : 'Submit Application',
                      style: GoogleFonts.outfit(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStepIndicator(int step, String label) {
    final isActive = _currentStep >= step;
    final isCurrent = _currentStep == step;
    
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primaryColor : Colors.grey[300],
              shape: BoxShape.circle,
              border: isCurrent 
                  ? Border.all(color: AppColors.primaryColor, width: 2.w)
                  : null,
            ),
            child: Center(
              child: isActive
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16.sp,
                    )
                  : Text(
                      '${step + 1}',
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 12.sp,
              fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
              color: isCurrent ? AppColors.primaryColor : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Widget _buildStepConnector(bool isActive) {
    return Container(
      width: 20.w,
      height: 2.h,
      color: isActive ? AppColors.primaryColor : Colors.grey[300],
    );
  }
  
  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildPersonalInfoStep();
      case 1:
        return _buildFinancialInfoStep();
      case 2:
        return _buildLoanDetailsStep();
      default:
        return Container();
    }
  }
  
  Widget _buildPersonalInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Property card
        _buildPropertyCard(),
        SizedBox(height: 24.h),
        
        // Personal information form
        Text(
          'Personal Information',
          style: GoogleFonts.outfit(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _fullNameController,
          label: 'Full Name',
          hint: 'Enter your full name',
          icon: Icons.person_outline,
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _phoneController,
          label: 'Phone Number',
          hint: 'Enter your phone number',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Phone number is required';
            }
            if (value.length < 10) {
              return 'Please enter a valid phone number';
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _emailController,
          label: 'Email Address',
          hint: 'Enter your email address',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email is required';
            }
            if (!value.contains('@') || !value.contains('.')) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _idNumberController,
          label: 'ID Number',
          hint: 'Enter your national ID number',
          icon: Icons.badge_outlined,
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
  
  Widget _buildFinancialInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Property card
        _buildPropertyCard(),
        SizedBox(height: 24.h),
        
        // Financial information form
        Text(
          'Financial Information',
          style: GoogleFonts.outfit(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _monthlyIncomeController,
          label: 'Monthly Income (ETB)',
          hint: 'Enter your monthly income',
          icon: Icons.attach_money_outlined,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Monthly income is required';
            }
            if (double.tryParse(value) == null) {
              return 'Please enter a valid amount';
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _employerController,
          label: 'Employer',
          hint: 'Enter your employer name',
          icon: Icons.business_outlined,
        ),
        SizedBox(height: 16.h),
        
        // Employment status
        Text(
          'Employment Status',
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: 'Full-time',
              isExpanded: true,
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.grey[600],
              ),
              items: [
                'Full-time',
                'Part-time',
                'Self-employed',
                'Unemployed',
                'Retired',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      color: Colors.black87,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {},
            ),
          ),
        ),
        SizedBox(height: 16.h),
        
        // Years at current employer
        Text(
          'Years at Current Employer',
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: '1-3 years',
              isExpanded: true,
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.grey[600],
              ),
              items: [
                'Less than 1 year',
                '1-3 years',
                '3-5 years',
                '5-10 years',
                'More than 10 years',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      color: Colors.black87,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {},
            ),
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
  
  Widget _buildLoanDetailsStep() {
    // Calculate loan amount and monthly payment
    var loanAmount = widget.property.price * (1 - _downPaymentPercentage / 100);
    final monthlyRate = 7.5 / 100 / 12; // 7.5% annual interest rate
    var totalPayments = _loanTermYears * 12;
    
    // Monthly payment formula: P = L[c(1 + c)^n]/[(1 + c)^n - 1]
    final monthlyPayment = loanAmount * (monthlyRate * pow(1 + monthlyRate, totalPayments)) / 
                           (pow(1 + monthlyRate, totalPayments) - 1);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Property card
        _buildPropertyCard(),
        SizedBox(height: 24.h),
        
        // Loan details
        Text(
          'Loan Details',
          style: GoogleFonts.outfit(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),
        
        // Down payment slider
        Text(
          'Down Payment: ${_downPaymentPercentage.toStringAsFixed(0)}% (${currencyFormat.format(widget.property.price * _downPaymentPercentage / 100)})',
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        Slider(
          value: _downPaymentPercentage,
          min: 10,
          max: 50,
          divisions: 8,
          activeColor: AppColors.primaryColor,
          inactiveColor: Colors.grey[300],
          label: '${_downPaymentPercentage.toStringAsFixed(0)}%',
          onChanged: (value) {
            setState(() {
              _downPaymentPercentage = value;
            });
          },
        ),
        SizedBox(height: 16.h),
        
        // Loan term
        Text(
          'Loan Term: $_loanTermYears years',
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '5 yrs',
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            Text(
              '30 yrs',
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        Slider(
          value: _loanTermYears.toDouble(),
          min: 5,
          max: 30,
          divisions: 5,
          activeColor: AppColors.primaryColor,
          inactiveColor: Colors.grey[300],
          label: '$_loanTermYears years',
          onChanged: (value) {
            setState(() {
              _loanTermYears = value.toInt();
            });
          },
        ),
        SizedBox(height: 24.h),
        
        // Loan Summary
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Text(
                'Loan Summary',
                style: GoogleFonts.outfit(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16.h),
              _buildLoanSummaryRow('Loan Amount:', currencyFormat.format(loanAmount)),
              SizedBox(height: 8.h),
              _buildLoanSummaryRow('Interest Rate:', '7.5% per annum'),
              SizedBox(height: 8.h),
              _buildLoanSummaryRow('Loan Term:', '$_loanTermYears years'),
              SizedBox(height: 8.h),
              _buildLoanSummaryRow('Processing Fee:', currencyFormat.format(loanAmount * 0.01)),
              SizedBox(height: 16.h),
              Divider(color: Colors.grey[300]),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Monthly Payment:',
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    currencyFormat.format(monthlyPayment),
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        
        // Terms and conditions
        Row(
          children: [
            Checkbox(
              value: true,
              onChanged: (value) {},
              activeColor: AppColors.primaryColor,
            ),
            Expanded(
              child: Text(
                'I agree to the terms and conditions of the mortgage application',
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildPropertyCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Property image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              widget.property.images.first,
              width: 80.w,
              height: 80.w,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80.w,
                  height: 80.w,
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 30.sp,
                    color: Colors.grey[400],
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 16.w),
          
          // Property details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.property.title,
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  '${widget.property.location.neighborhood}, ${widget.property.location.city}',
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Text(
                  currencyFormat.format(widget.property.price),
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.outfit(
              fontSize: 14.sp,
              color: Colors.grey[400],
            ),
            prefixIcon: Icon(
              icon,
              color: Colors.grey[500],
              size: 20.sp,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.primaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.red[400]!),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          ),
          style: GoogleFonts.outfit(
            fontSize: 16.sp,
            color: Colors.black87,
          ),
          validator: validator ?? (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }
  
  void _submitApplication() {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ),
    );
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading dialog
      
      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Application Submitted',
                style: GoogleFonts.outfit(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your mortgage application has been successfully submitted. Our team will review your application and contact you within 2-3 business days.',
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.confirmation_number_outlined,
                      color: AppColors.primaryColor,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Application Reference:',
                          style: GoogleFonts.outfit(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          'GBB-${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 13)}',
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Return to property detail
              },
              child: Text(
                'Close',
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Return to property detail
                
                // Navigate to application tracking screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MortgageTrackingScreen(
                      applicationId: 'GBB-${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 13)}',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Track Application',
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
  
  Widget _buildLoanSummaryRow(String label, String value) {
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
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}