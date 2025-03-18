import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:super_app/core/theme/app_colors.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MortgageTrackingScreen extends StatefulWidget {
  final String applicationId;

  const MortgageTrackingScreen({
    Key? key,
    required this.applicationId,
  }) : super(key: key);

  @override
  State<MortgageTrackingScreen> createState() => _MortgageTrackingScreenState();
}

class _MortgageTrackingScreenState extends State<MortgageTrackingScreen> {
  // Mock data for application status
  final Map<String, dynamic> _applicationData = {
    'status': 'in_review',
    'submittedDate': DateTime.now().subtract(const Duration(days: 2)),
    'estimatedCompletionDate': DateTime.now().add(const Duration(days: 10)),
    'currentStep': 2,
    'totalSteps': 5,
    'steps': [
      {
        'title': 'Application Submitted',
        'description': 'Your application has been received',
        'date': DateTime.now().subtract(const Duration(days: 2)),
        'status': 'completed',
      },
      {
        'title': 'Initial Review',
        'description': 'Application is being reviewed by our team',
        'date': DateTime.now().subtract(const Duration(days: 1)),
        'status': 'completed',
      },
      {
        'title': 'Document Verification',
        'description': 'Verifying your submitted documents',
        'date': DateTime.now(),
        'status': 'in_progress',
      },
      {
        'title': 'Credit Assessment',
        'description': 'Evaluating your credit history and eligibility',
        'date': DateTime.now().add(const Duration(days: 5)),
        'status': 'pending',
      },
      {
        'title': 'Final Approval',
        'description': 'Final decision on your mortgage application',
        'date': DateTime.now().add(const Duration(days: 10)),
        'status': 'pending',
      },
    ],
    'requiredDocuments': [
      {
        'name': 'ID Card/Passport',
        'status': 'verified',
      },
      {
        'name': 'Proof of Income',
        'status': 'pending',
      },
      {
        'name': 'Bank Statements (3 months)',
        'status': 'pending',
      },
      {
        'name': 'Employment Verification',
        'status': 'not_submitted',
      },
    ],
    'contactPerson': {
      'name': 'Abebe Kebede',
      'role': 'Mortgage Advisor',
      'phone': '+251 91 234 5678',
      'email': 'abebe.k@gohbetoch.com',
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Application Tracking',
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Application ID and Status Card
            _buildApplicationStatusCard(),
            SizedBox(height: 24.h),
            
            // Application Timeline
            Text(
              'Application Progress',
              style: GoogleFonts.outfit(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16.h),
            _buildApplicationTimeline(),
            SizedBox(height: 24.h),
            
            // Required Documents
            Text(
              'Required Documents',
              style: GoogleFonts.outfit(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16.h),
            _buildRequiredDocumentsList(),
            SizedBox(height: 24.h),
            
            // Contact Person
            Text(
              'Your Mortgage Advisor',
              style: GoogleFonts.outfit(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16.h),
            _buildContactPersonCard(),
            SizedBox(height: 24.h),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showUploadDocumentDialog();
                    },
                    icon: Icon(
                      Icons.upload_file_outlined,
                      color: AppColors.primaryColor,
                      size: 20.sp,
                    ),
                    label: Text(
                      'Upload Documents',
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      side: BorderSide(color: AppColors.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Contact mortgage advisor
                      _showContactAdvisorDialog();
                    },
                    icon: Icon(
                      Icons.support_agent_outlined,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    label: Text(
                      'Contact Advisor',
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
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildApplicationStatusCard() {
    String statusText = '';
    Color statusColor = Colors.grey;
    
    switch (_applicationData['status']) {
      case 'submitted':
        statusText = 'Submitted';
        statusColor = Colors.blue;
        break;
      case 'in_review':
        statusText = 'In Review';
        statusColor = Colors.orange;
        break;
      case 'approved':
        statusText = 'Approved';
        statusColor = Colors.green;
        break;
      case 'rejected':
        statusText = 'Rejected';
        statusColor = Colors.red;
        break;
      default:
        statusText = 'Pending';
        statusColor = Colors.grey;
    }
    
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Application ID',
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    widget.applicationId,
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      statusText,
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: Colors.grey[200]),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoColumn(
                'Submitted On',
                DateFormat('MMM d, yyyy').format(_applicationData['submittedDate'] as DateTime),
              ),
              _buildInfoColumn(
                'Estimated Completion',
                DateFormat('MMM d, yyyy').format(_applicationData['estimatedCompletionDate'] as DateTime),
              ),
              _buildInfoColumn(
                'Current Step',
                '${_applicationData['currentStep']}/${_applicationData['totalSteps']}',
              ),
            ],
          ),
          SizedBox(height: 16.h),
          LinearProgressIndicator(
            value: (_applicationData['currentStep'] as int) / (_applicationData['totalSteps'] as int),
            backgroundColor: Colors.grey[200],
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 12.sp,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 4.h),
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
  
  Widget _buildApplicationTimeline() {
    final steps = _applicationData['steps'] as List;
    
    return Container(
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
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: steps.length,
        itemBuilder: (context, index) {
          final step = steps[index] as Map<String, dynamic>;
          bool isFirst = index == 0;
          bool isLast = index == steps.length - 1;
          
          Color indicatorColor;
          Widget indicatorChild;
          
          switch (step['status']) {
            case 'completed':
              indicatorColor = Colors.green;
              indicatorChild = Icon(
                Icons.check,
                color: Colors.white,
                size: 16.sp,
              );
              break;
            case 'in_progress':
              indicatorColor = Colors.orange;
              indicatorChild = Container(
                width: 12.w,
                height: 12.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              );
              break;
            default:
              indicatorColor = Colors.grey[300]!;
              indicatorChild = Container();
          }
          
          return TimelineTile(
            isFirst: isFirst,
            isLast: isLast,
            alignment: TimelineAlign.start,
            indicatorStyle: IndicatorStyle(
              width: 24.w,
              height: 24.w,
              indicator: Container(
                decoration: BoxDecoration(
                  color: indicatorColor,
                  shape: BoxShape.circle,
                ),
                child: Center(child: indicatorChild),
              ),
            ),
            beforeLineStyle: LineStyle(
              color: index > 0 && steps[index - 1]['status'] == 'completed' 
                  ? Colors.green 
                  : Colors.grey[300]!,
            ),
            afterLineStyle: LineStyle(
              color: step['status'] == 'completed' 
                  ? Colors.green 
                  : Colors.grey[300]!,
            ),
            endChild: Container(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['title'] as String,
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: step['status'] == 'pending' 
                          ? Colors.grey[600] 
                          : Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    step['description'] as String,
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    DateFormat('MMM d, yyyy').format(step['date'] as DateTime),
                    style: GoogleFonts.outfit(
                      fontSize: 12.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildRequiredDocumentsList() {
    final documents = _applicationData['requiredDocuments'] as List;
    
    return Container(
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
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: documents.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey[200],
          height: 1,
        ),
        itemBuilder: (context, index) {
          final document = documents[index] as Map<String, dynamic>;
          
          IconData statusIcon;
          Color statusColor;
          String statusText;
          
          switch (document['status']) {
            case 'verified':
              statusIcon = Icons.check_circle;
              statusColor = Colors.green;
              statusText = 'Verified';
              break;
            case 'pending':
              statusIcon = Icons.access_time;
              statusColor = Colors.orange;
              statusText = 'Pending';
              break;
            case 'rejected':
              statusIcon = Icons.cancel;
              statusColor = Colors.red;
              statusText = 'Rejected';
              break;
            default:
              statusIcon = Icons.upload_file;
              statusColor = Colors.grey[600]!;
              statusText = 'Not Submitted';
          }
          
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            leading: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.description_outlined,
                color: Colors.grey[600],
                size: 24.sp,
              ),
            ),
            title: Text(
              document['name'] as String,
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  statusIcon,
                  color: statusColor,
                  size: 16.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  statusText,
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    color: statusColor,
                  ),
                ),
                if (document['status'] != 'verified')
                  Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: Icon(
                      Icons.upload_outlined,
                      color: AppColors.primaryColor,
                      size: 20.sp,
                    ),
                  ),
              ],
            ),
            onTap: document['status'] != 'verified' 
                ? () => _showUploadDocumentDialog(documentName: document['name'] as String) 
                : null,
          );
        },
      ),
    );
  }
  
  Widget _buildContactPersonCard() {
    final contactPerson = _applicationData['contactPerson'] as Map<String, dynamic>;
    
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
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                contactPerson['name'].toString().substring(0, 2).toUpperCase(),
                style: GoogleFonts.outfit(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contactPerson['name'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  contactPerson['role'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      size: 16.sp,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      contactPerson['phone'] as String,
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  void _showUploadDocumentDialog({String? documentName}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          documentName != null ? 'Upload $documentName' : 'Upload Documents',
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
              height: 120.h,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Colors.grey[300]!,
                  style: BorderStyle.solid,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 40.sp,
                      color: Colors.grey[500],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Tap to upload file',
                      style: GoogleFonts.outfit(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Supported formats: PDF, JPG, PNG\nMaximum file size: 5MB',
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
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
                const SnackBar(
                  content: Text('Document uploaded successfully'),
                  duration: Duration(seconds: 2),
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
              'Upload',
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
  
  void _showContactAdvisorDialog() {
    final contactPerson = _applicationData['contactPerson'] as Map<String, dynamic>;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Contact Advisor',
          style: GoogleFonts.outfit(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.phone_outlined,
                  color: AppColors.primaryColor,
                  size: 24.sp,
                ),
              ),
              title: Text(
                'Call',
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                contactPerson['phone'] as String,
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Calling ${contactPerson['name']}...'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.email_outlined,
                  color: AppColors.primaryColor,
                  size: 24.sp,
                ),
              ),
              title: Text(
                'Email',
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                contactPerson['email'] as String,
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Sending email to ${contactPerson['name']}...'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.message_outlined,
                  color: AppColors.primaryColor,
                  size: 24.sp,
                ),
              ),
              title: Text(
                'Message',
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                'Send a direct message',
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Opening chat with ${contactPerson['name']}...'),
                    duration: const Duration(seconds: 2),
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
} 