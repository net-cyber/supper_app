import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:super_app/core/theme/app_colors.dart';
import 'package:super_app/features/mortgages/presentation/screens/mortgage_approval_screen.dart';
import 'package:super_app/features/mortgages/presentation/screens/mortgage_tracking_screen.dart';

class MortgageDashboardScreen extends StatefulWidget {
  const MortgageDashboardScreen({Key? key}) : super(key: key);

  @override
  State<MortgageDashboardScreen> createState() => _MortgageDashboardScreenState();
}

class _MortgageDashboardScreenState extends State<MortgageDashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Mock data for applications
  final List<Map<String, dynamic>> _applications = [
    {
      'id': 'GBB-12345678',
      'propertyName': 'Modern Apartment in Bole',
      'amount': 4500000.0,
      'status': 'in_review',
      'submittedDate': DateTime.now().subtract(const Duration(days: 2)),
      'lastUpdated': DateTime.now().subtract(const Duration(hours: 6)),
    },
    {
      'id': 'GBB-87654321',
      'propertyName': 'Luxury Villa in CMC',
      'amount': 7800000.0,
      'status': 'approved',
      'submittedDate': DateTime.now().subtract(const Duration(days: 15)),
      'lastUpdated': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': 'GBB-24681357',
      'propertyName': 'Cozy Apartment in Kazanchis',
      'amount': 3900000.0,
      'status': 'rejected',
      'submittedDate': DateTime.now().subtract(const Duration(days: 30)),
      'lastUpdated': DateTime.now().subtract(const Duration(days: 25)),
    },
  ];
  
  // Mock data for pre-approved offers
  final List<Map<String, dynamic>> _preApprovedOffers = [
    {
      'id': 'PRE-12345',
      'amount': 5000000.0,
      'interestRate': 7.5,
      'term': 20,
      'expiryDate': DateTime.now().add(const Duration(days: 30)),
    },
    {
      'id': 'PRE-67890',
      'amount': 3500000.0,
      'interestRate': 7.2,
      'term': 15,
      'expiryDate': DateTime.now().add(const Duration(days: 45)),
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
          'My Mortgages',
          style: GoogleFonts.outfit(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: AppColors.primaryColor,
          labelStyle: GoogleFonts.outfit(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.outfit(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          tabs: const [
            Tab(text: 'Applications'),
            Tab(text: 'Pre-Approved'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Applications Tab
          _applications.isEmpty
              ? _buildEmptyState('No mortgage applications yet', 'Start by browsing properties and applying for a mortgage.')
              : _buildApplicationsList(),
          
          // Pre-Approved Tab
          _preApprovedOffers.isEmpty
              ? _buildEmptyState('No pre-approved offers', 'Complete your profile to receive pre-approved mortgage offers.')
              : _buildPreApprovedList(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to property listings
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Navigating to property listings...'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        backgroundColor: AppColors.primaryColor,
        icon: Icon(
          Icons.search,
          color: Colors.white,
          size: 20.sp,
        ),
        label: Text(
          'Find Properties',
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  
  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home_work_outlined,
              size: 80.sp,
              color: Colors.grey[400],
            ),
            SizedBox(height: 24.h),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to property listings
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Navigating to property listings...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 20.sp,
              ),
              label: Text(
                'Browse Properties',
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildApplicationsList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: _applications.length,
      itemBuilder: (context, index) {
        final application = _applications[index];
        return _buildApplicationCard(application);
      },
    );
  }
  
  Widget _buildApplicationCard(Map<String, dynamic> application) {
    final currencyFormat = NumberFormat.currency(
      locale: 'en_ET',
      symbol: 'ETB ',
      decimalDigits: 0,
    );
    
    Color statusColor;
    IconData statusIcon;
    String statusText;
    
    switch (application['status']) {
      case 'submitted':
        statusColor = Colors.blue;
        statusIcon = Icons.check_circle_outline;
        statusText = 'Submitted';
        break;
      case 'in_review':
        statusColor = Colors.orange;
        statusIcon = Icons.hourglass_top;
        statusText = 'In Review';
        break;
      case 'approved':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        statusText = 'Approved';
        break;
      case 'rejected':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        statusText = 'Rejected';
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help_outline;
        statusText = 'Unknown';
    }
    
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: InkWell(
        onTap: () {
          if (application['status'] == 'approved') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MortgageApprovalScreen(
                  applicationId: 'GBB-${application['id']}',
                  interestRate: 7.5,
                  loanTerm: 20,
                  approvedAmount: 5000000.0,
                ),
              ),
            );
          } else {
            Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MortgageTrackingScreen(
                applicationId: application['id'] as String,
              ),
            ),
          );
          }
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      statusIcon,
                      color: statusColor,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          application['propertyName'] as String ,
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
                          'Application ID: ${application['id']}',
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
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Loan Amount',
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        currencyFormat.format(application['amount']),
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Status',
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(
                          statusText,
                          style: GoogleFonts.outfit(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Submitted: ${DateFormat('MMM d, yyyy').format(application['submittedDate'] as DateTime)}',
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Last updated: ${_getTimeAgo(application['lastUpdated'] as DateTime)}',
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildPreApprovedList() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: _preApprovedOffers.length,
      itemBuilder: (context, index) {
        final offer = _preApprovedOffers[index];
        return _buildPreApprovedCard(offer);
      },
    );
  }
  
  Widget _buildPreApprovedCard(Map<String, dynamic> offer) {
    final currencyFormat = NumberFormat.currency(
      locale: 'en_ET',
      symbol: 'ETB ',
      decimalDigits: 0,
    );
    
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.verified_outlined,
                    color: AppColors.primaryColor,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pre-Approved Mortgage Offer',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Offer ID: ${offer['id']}',
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
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Loan Amount',
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        currencyFormat.format(offer['amount']),
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Interest Rate',
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        '${offer['interestRate']}%',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Loan Term',
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        '${offer['term']} years',
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
            SizedBox(height: 16.h),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16.sp,
                  color: Colors.orange,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Expires in ${_getDaysUntil(offer['expiryDate'] as DateTime)} days',
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to property listings with pre-approved amount
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Browsing properties within ${currencyFormat.format(offer['amount'])}...'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Find Properties',
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
    );
  }
  
  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
  
  int _getDaysUntil(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.difference(now).inDays;
  }
} 