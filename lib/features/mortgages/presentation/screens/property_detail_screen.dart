import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:super_app/features/mortgages/presentation/screens/mortgage_application_screen.dart';
import 'package:super_app/features/mortgages/domain/entities/property.dart';
import 'package:super_app/core/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

final currencyFormat = NumberFormat.currency(
  locale: 'en_ET',
  symbol: 'ETB ',
  decimalDigits: 0,
);

class PropertyDetailScreen extends StatefulWidget {

  const PropertyDetailScreen({
    Key? key,
    required this.property,
  }) : super(key: key);
  final Property property;

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  final PageController _imagePageController = PageController();
  int _currentImageIndex = 0;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  @override
  void dispose() {
    _imagePageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Content
          CustomScrollView(
            slivers: [
              // Image gallery with app bar
              SliverAppBar(
                expandedHeight: 300.h,
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 0,
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: EdgeInsets.only(left: 16.w, top: 16.h),
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                      size: 20.sp,
                    ),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: _toggleFavorite,
                    child: Container(
                      margin: EdgeInsets.only(right: 16.w, top: 16.h),
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.black87,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _shareProperty,
                    child: Container(
                      margin: EdgeInsets.only(right: 16.w, top: 16.h),
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.share_outlined,
                        color: Colors.black87,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      // Image gallery
                      PageView.builder(
                        controller: _imagePageController,
                        itemCount: widget.property.images.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentImageIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => _openFullscreenGallery(index),
                            child: Image.network(
                              widget.property.images[index],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[200],
                                  child: Icon(
                                    Icons.image_not_supported_outlined,
                                    size: 50.sp,
                                    color: Colors.grey[400],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      
                      // Image indicators
                      Positioned(
                        bottom: 16.h,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            widget.property.images.length,
                            (index) => Container(
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              width: 8.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentImageIndex == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      // Tags
                      if (widget.property.tags.isNotEmpty)
                        Positioned(
                          top: 16.h,
                          left: 16.w,
                          child: Row(
                            children: widget.property.tags.map((tag) {
                              Color tagColor;
                              if (tag.toLowerCase() == 'new') {
                                tagColor = Colors.green;
                              } else if (tag.toLowerCase() == 'featured') {
                                tagColor = Colors.orange;
                              } else if (tag.toLowerCase() == 'premium') {
                                tagColor = Colors.purple;
                              } else {
                                tagColor = Colors.blue;
                              }
                              
                              return Container(
                                margin: EdgeInsets.only(right: 8.w),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: tagColor,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  tag.toUpperCase(),
                                  style: GoogleFonts.outfit(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              
              // Property details
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Price
                      Text(
                        currencyFormat.format(widget.property.price),
                        style: GoogleFonts.outfit(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      
                      // Title
                      Text(
                        widget.property.title,
                        style: GoogleFonts.outfit(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      
                      // Location
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 18.sp,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${widget.property.location.neighborhood}, ${widget.property.location.city}',
                            style: GoogleFonts.outfit(
                              fontSize: 16.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      
                      // Specifications
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildSpecItem(
                              Icons.king_bed_outlined,
                              '${widget.property.specifications.bedrooms}',
                              'Bedrooms',
                            ),
                            _buildSpecItem(
                              Icons.bathtub_outlined,
                              '${widget.property.specifications.bathrooms}',
                              'Bathrooms',
                            ),
                            _buildSpecItem(
                              Icons.square_foot_outlined,
                              '${widget.property.specifications.size}',
                              'Square Meters',
                            ),
                            _buildSpecItem(
                              Icons.home_outlined,
                              widget.property.specifications.propertyType,
                              'Type',
                              isLast: true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      
                      // Mortgage details
                      Text(
                        'Mortgage Details',
                        style: GoogleFonts.outfit(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      
                      // Mortgage eligibility
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: widget.property.mortgageEligible
                              ? Colors.green[50]
                              : Colors.red[50],
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: widget.property.mortgageEligible
                                ? Colors.green[200]!
                                : Colors.red[200]!,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              widget.property.mortgageEligible
                                  ? Icons.check_circle_outline
                                  : Icons.cancel_outlined,
                              color: widget.property.mortgageEligible
                                  ? Colors.green[700]
                                  : Colors.red[700],
                              size: 24.sp,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.property.mortgageEligible
                                        ? 'Eligible for Mortgage'
                                        : 'Not Eligible for Mortgage',
                                    style: GoogleFonts.outfit(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: widget.property.mortgageEligible
                                          ? Colors.green[700]
                                          : Colors.red[700],
                                    ),
                                  ),
                                  if (widget.property.mortgageEligible)
                                    Text(
                                      'This property qualifies for Goh Betoch Bank mortgage financing',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      
                      // Monthly payment estimate
                      if (widget.property.mortgageEligible)
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Estimated Monthly Payment',
                                style: GoogleFonts.outfit(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                currencyFormat.format(widget.property.monthlyPaymentEstimate),
                                style: GoogleFonts.outfit(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Based on 20% down payment and 20-year term',
                                style: GoogleFonts.outfit(
                                  fontSize: 14.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 24.h),
                      
                      // Mortgage calculator
                      if (widget.property.mortgageEligible)... [
                        SizedBox(height: 16.h),
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mortgage Calculator',
                                style: GoogleFonts.outfit(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              
                              // Down payment slider
                              Row(
                                children: [
                                  Text(
                                    'Down Payment:',
                                    style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    '20%',
                                    style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    currencyFormat.format(widget.property.price * 0.2),
                                    style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              
                              // Loan term
                              Row(
                                children: [
                                  Text(
                                    'Loan Term:',
                                    style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    '20 years',
                                    style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              
                              // Interest rate
                              Row(
                                children: [
                                  Text(
                                    'Interest Rate:',
                                    style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    '7.5%',
                                    style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              
                              // Divider
                              Divider(color: Colors.grey[300]),
                              SizedBox(height: 16.h),
                              
                              // Monthly payment
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Estimated Monthly Payment:',
                                    style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    currencyFormat.format(widget.property.monthlyPaymentEstimate),
                                    style: GoogleFonts.outfit(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              
                              // Calculate button
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: _showMortgageCalculatorDialog,
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 12.h),
                                    side: const BorderSide(color: AppColors.primaryColor),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  child: Text(
                                    'Customize Calculation',
                                    style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                        
                      // Description
                      Text(
                        'Description',
                        style: GoogleFonts.outfit(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'This beautiful property offers modern living in a prime location. '
                        'Featuring spacious rooms, quality finishes, and excellent amenities. '
                        'Perfect for families looking for comfort and convenience in the heart of the city.',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      
                      // Similar Properties Section
                      Text(
                        'Similar Properties',
                        style: GoogleFonts.outfit(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        height: 220.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          itemBuilder: (context, index) {
                            return _buildSimilarPropertyCard(index);
                          },
                        ),
                      ),
                      
                      // Schedule Tour Section
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  size: 20.sp,
                                  color: AppColors.primaryColor,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Schedule a Tour',
                                  style: GoogleFonts.outfit(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: _showTourScheduleDialog,
                                    icon: Icon(
                                      Icons.date_range_outlined,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),
                                    label: Text(
                                      'Book a Tour',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      padding: EdgeInsets.symmetric(vertical: 12.h),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: _showVirtualTourDialog,
                                    icon: Icon(
                                      Icons.videocam_outlined,
                                      color: AppColors.primaryColor,
                                      size: 20.sp,
                                    ),
                                    label: Text(
                                      'Virtual Tour',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(vertical: 12.h),
                                      side: const BorderSide(color: AppColors.primaryColor),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Location map placeholder
                      Text(
                        'Location',
                        style: GoogleFonts.outfit(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 200.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            if (widget.property.location.latitude != null && widget.property.location.longitude != null) {
                              _openFullscreenMap();
                            }
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: widget.property.location.latitude != null && widget.property.location.longitude != null
                              ? Stack(
                                  children: [
                                    FlutterMap(
                                      options: MapOptions(
                                        center: LatLng(
                                          widget.property.location.latitude!,
                                          widget.property.location.longitude!,
                                        ),
                                        zoom: 15,
                                      ),
                                      children: [
                                        TileLayer(
                                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                          userAgentPackageName: 'com.gohbetoch.app',
                                        ),
                                        MarkerLayer(
                                          markers: [
                                            Marker(
                                              width: 40.w,
                                              height: 40.h,
                                              point: LatLng(
                                                widget.property.location.latitude!,
                                                widget.property.location.longitude!,
                                              ),
                                              builder: (ctx) => Icon(
                                                Icons.location_on,
                                                color: AppColors.primaryColor,
                                                size: 40.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      right: 8.w,
                                      bottom: 8.h,
                                      child: Container(
                                        padding: EdgeInsets.all(6.w),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(4.r),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.fullscreen,
                                          color: Colors.black87,
                                          size: 20.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.map_outlined,
                                        size: 48.sp,
                                        color: Colors.grey[400],
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'Map location not available',
                                        style: GoogleFonts.outfit(
                                          fontSize: 16.sp,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          ),
                        ),
                      ),
                      SizedBox(height: 100.h), // Space for bottom button
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Apply for mortgage button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
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
                  // Contact Agent Button
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _showContactDialog,
                      icon: Icon(
                        Icons.phone_outlined,
                        color: AppColors.primaryColor,
                        size: 20.sp,
                      ),
                      label: Text(
                        'Contact Agent',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        side: const BorderSide(color: AppColors.primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Apply for Mortgage Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to mortgage application
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MortgageApplicationScreen(property: widget.property),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                        child: Text(
                          'Apply for Mortgage',
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
          ),
        ],
      ),
    );

  }
  
  Widget _buildSpecItem(IconData icon, String value, String label, {bool isLast = false}) {
    return Column(
      children: [
        Icon(
          icon,
          size: 24.sp,
          color: AppColors.primaryColor,
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 12.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Contact Agent',
          style: GoogleFonts.outfit(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildContactOption(
              icon: Icons.phone,
              title: 'Call Agent',
              subtitle: '+251 91 234 5678',
              onTap: () {
                Navigator.pop(context);
                // Launch phone call
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Calling agent...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            SizedBox(height: 16.h),
            _buildContactOption(
              icon: Icons.message_outlined,
              title: 'Send Message',
              subtitle: 'Usually responds within 1 hour',
              onTap: () {
                Navigator.pop(context);
                // Open messaging
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Opening messaging...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            SizedBox(height: 16.h),
            _buildContactOption(
              icon: Icons.email_outlined,
              title: 'Email Agent',
              subtitle: 'agent@gohbetoch.com',
              onTap: () {
                Navigator.pop(context);
                // Launch email
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Opening email...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryColor,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  void _shareProperty() {
    final shareText = 'Check out this property: ${widget.property.title} - '
        'Price: ETB ${NumberFormat.currency(locale: 'en_ET', symbol: '', decimalDigits: 0).format(widget.property.price)} '
        'Location: ${widget.property.location.neighborhood}, ${widget.property.location.city}';
    
    // In a real app, you would use a package like share_plus
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing: $shareText'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showTourScheduleDialog() {
    var selectedDate = DateTime.now().add(const Duration(days: 1));
    var selectedTime = '10:00 AM';
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            title: Text(
              'Schedule a Tour',
              style: GoogleFonts.outfit(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Date',
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 20.sp,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          DateFormat('EEEE, MMMM d, yyyy').format(selectedDate),
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 20.sp,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 30)),
                          );
                          if (picked != null && picked != selectedDate) {
                            setState(() {
                              selectedDate = picked;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Select Time',
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedTime,
                      isExpanded: true,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey[600],
                      ),
                      items: [
                        '9:00 AM',
                        '10:00 AM',
                        '11:00 AM',
                        '12:00 PM',
                        '1:00 PM',
                        '2:00 PM',
                        '3:00 PM',
                        '4:00 PM',
                        '5:00 PM',
                      ].map((String time) {
                        return DropdownMenuItem<String>(
                          value: time,
                          child: Text(
                            time,
                            style: GoogleFonts.outfit(
                              fontSize: 16.sp,
                              color: Colors.black87,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedTime = newValue;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Tour scheduled for ${DateFormat('EEEE, MMMM d').format(selectedDate)} at $selectedTime',
                      ),
                      duration: const Duration(seconds: 3),
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
                  'Schedule',
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showVirtualTourDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Virtual Tour',
          style: GoogleFonts.outfit(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 180.h,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Icon(
                  Icons.videocam_outlined,
                  size: 48.sp,
                  color: Colors.grey[400],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Virtual tour is not available for this property yet. Please check back later or contact the agent for more information.',
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
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
              Navigator.pop(context);
              _showContactDialog();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Contact Agent',
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
  }

  Widget _buildSimilarPropertyCard(int index) {
    // Dummy data for similar properties
    final similarProperties = <Map<String, dynamic>>[
      {
        'title': 'Modern Apartment in Bole',
        'price': 4500000.0,
        'image': 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267',
        'bedrooms': 2,
        'bathrooms': 2,
        'size': 85.0,
      },
      {
        'title': 'Luxury Villa in CMC',
        'price': 7800000.0,
        'image': 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750',
        'bedrooms': 3,
        'bathrooms': 3,
        'size': 120.0,
      },
      {
        'title': 'Cozy Apartment in Kazanchis',
        'price': 3900000.0,
        'image': 'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2',
        'bedrooms': 1,
        'bathrooms': 1,
        'size': 65.0,
      },
    ];

    final property = similarProperties[index];
    
    return Container(
      width: 200.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
            child: Image.network(
              property['image'] as String,
              height: 120.h,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 120.h,
                  color: Colors.grey[200],
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 40.sp,
                    color: Colors.grey[400],
                  ),
                );
              },
            ),
          ),
          
          // Details
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Price
                Text(
                  currencyFormat.format(property['price']),
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 4.h),
                
                // Title
                Text(
                  property['title'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                
                // Specs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMiniSpec(Icons.king_bed_outlined, '${property['bedrooms']}'),
                    _buildMiniSpec(Icons.bathtub_outlined, '${property['bathrooms']}'),
                    _buildMiniSpec(Icons.square_foot_outlined, '${property['size']} m²'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniSpec(IconData icon, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14.sp,
          color: Colors.grey[600],
        ),
        SizedBox(width: 4.w),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 12.sp,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Future<void> _loadFavoriteStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = prefs.getStringList('favorites') ?? [];
      setState(() {
        _isFavorite = favorites.contains(widget.property.id);
      });
    } catch (e) {
      // Handle error
      print('Error loading favorite status: $e');
    }
  }

  Future<void> _toggleFavorite() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = prefs.getStringList('favorites') ?? [];
      
      setState(() {
        _isFavorite = !_isFavorite;
      });
      
      if (_isFavorite) {
        favorites.add(widget.property.id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Added to favorites'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        favorites.remove(widget.property.id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Removed from favorites'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      
      await prefs.setStringList('favorites', favorites);
    } catch (e) {
      // Handle error
      print('Error saving favorite status: $e');
      setState(() {
        _isFavorite = !_isFavorite; // Revert state change
      });
    }
  }

  void _openFullscreenGallery(int initialIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              '${initialIndex + 1}/${widget.property.images.length}',
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          body: PageView.builder(
            controller: PageController(initialPage: initialIndex),
            itemCount: widget.property.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                widget.property.images[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: 50.sp,
                      color: Colors.grey[400],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _showMortgageCalculatorDialog() {
    var downPaymentPercentage = 20;
    var loanTermYears = 20;
    var interestRate = 7.5;
    
    double calculateMonthlyPayment(double price, double downPaymentPercent, int termYears, double rate) {
      var loanAmount = price * (1 - downPaymentPercent / 100);
      var monthlyRate = rate / 100 / 12;
      var totalPayments = termYears * 12;
      
      // Monthly payment formula: P = L[c(1 + c)^n]/[(1 + c)^n - 1]
      // where L = loan amount, c = monthly interest rate, n = number of payments
      var monthlyPayment = loanAmount * (monthlyRate * pow(1 + monthlyRate, totalPayments)) / 
                             (pow(1 + monthlyRate, totalPayments) - 1);
      
      return monthlyPayment;
    }
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          var monthlyPayment = calculateMonthlyPayment(
            widget.property.price, 
            downPaymentPercentage.toDouble(), 
            loanTermYears, 
            interestRate,
          );
          
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            title: Text(
              'Mortgage Calculator',
              style: GoogleFonts.outfit(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Property price
                Text(
                  'Property Price: ${currencyFormat.format(widget.property.price)}',
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 24.h),
                
                // Down payment slider
                Text(
                  'Down Payment: ${downPaymentPercentage.toStringAsFixed(0)}% (${currencyFormat.format(widget.property.price * downPaymentPercentage / 100)})',
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8.h),
                Slider(
                  value: downPaymentPercentage.toDouble(),
                  min: 10,
                  max: 50,
                  divisions: 8,
                  activeColor: AppColors.primaryColor,
                  inactiveColor: Colors.grey[300],
                  label: '${downPaymentPercentage.toStringAsFixed(0)}%',
                  onChanged: (value) {
                    setState(() {
                      downPaymentPercentage = value.toInt();
                    });
                  },
                ),
                SizedBox(height: 16.h),
                
                // Loan term slider
                Text(
                  'Loan Term: $loanTermYears years',
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8.h),
                Slider(
                  value: loanTermYears.toDouble(),
                  min: 5,
                  max: 30,
                  divisions: 5,
                  activeColor: AppColors.primaryColor,
                  inactiveColor: Colors.grey[300],
                  label: '$loanTermYears years',
                  onChanged: (value) {
                    setState(() {
                      loanTermYears = value.toInt();
                    });
                  },
                ),
                SizedBox(height: 16.h),
                
                // Interest rate slider
                Text(
                  'Interest Rate: ${interestRate.toStringAsFixed(1)}%',
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8.h),
                Slider(
                  value: interestRate,
                  min: 5,
                  max: 15,
                  divisions: 20,
                  activeColor: AppColors.primaryColor,
                  inactiveColor: Colors.grey[300],
                  label: '${interestRate.toStringAsFixed(1)}%',
                  onChanged: (value) {
                    setState(() {
                      interestRate = value;
                    });
                  },
                ),
                SizedBox(height: 24.h),
                
                // Results
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Monthly Payment:',
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        currencyFormat.format(monthlyPayment),
                        style: GoogleFonts.outfit(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Loan Amount: ${currencyFormat.format(widget.property.price * (1 - downPaymentPercentage / 100))}',
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Total Payment: ${currencyFormat.format(monthlyPayment * loanTermYears * 12)}',
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
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
                  Navigator.pop(context);
                  // Navigate to mortgage application with these parameters
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Applying with ${downPaymentPercentage.toStringAsFixed(0)}% down payment and $loanTermYears year term'),
                      duration: const Duration(seconds: 3),
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
                  'Apply with These Terms',
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _openFullscreenMap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              widget.property.location.neighborhood,
              style: GoogleFonts.outfit(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: FlutterMap(
            options: MapOptions(
              center: LatLng(
                widget.property.location.latitude!,
                widget.property.location.longitude!,
              ),
              zoom: 16,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.gohbetoch.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 40.w,
                    height: 40.h,
                    point: LatLng(
                      widget.property.location.latitude!,
                      widget.property.location.longitude!,
                    ),
                    builder: (ctx) => Icon(
                      Icons.location_on,
                      color: AppColors.primaryColor,
                      size: 40.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            child: const Icon(Icons.directions),
            onPressed: () {
              // Open directions in maps app (would require url_launcher in a real app)
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Opening directions in maps app...'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
} 