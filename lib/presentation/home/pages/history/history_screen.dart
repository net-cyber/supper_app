import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';

import 'package:super_app/core/theme/app_colors.dart';
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Transaction History',
          style: GoogleFonts.outfit(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.grey[800], size: 24.sp),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterSection(),
          Expanded(
            child: _buildTransactionList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, size: 20.sp, color: Colors.grey[600]),
                  SizedBox(width: 12.w),
                  Text(
                    'Search transactions',
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.tune_rounded,
              size: 20.sp,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

 



  Widget _buildTransactionList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemCount: 10,
      itemBuilder: (context, index) {
        if (index == 0 || index == 3 || index == 7) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                child: Text(
                  index == 0 ? 'Today' : index == 3 ? 'Yesterday' : 'March 13, 2024',
                  style: GoogleFonts.outfit(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              _buildTransactionItem(
                context: context,
                date: '2024-03-15T10:00:00Z',
                type: index % 2 == 0 ? 'Bank Transfer' : 'Kacha Transfer',
                amount: (100 + index * 50).toString(),
                status: index % 3 == 0 ? 'Pending' : 'Completed',
                recipient: index % 2 == 0 ? 'SISAY LUKAS TEKA' : 'NATNAEL SEYOUM',
              ),
            ],
          );
        }
        return _buildTransactionItem(
          context: context,
          date: '2024-03-15T10:00:00Z',
          type: index % 2 == 0 ? 'Bank Transfer' : 'Kacha Transfer',
          amount: (100 + index * 50).toString(),
          status: index % 3 == 0 ? 'Pending' : 'Completed',
          recipient: index % 2 == 0 ? 'SISAY LUKAS TEKA' : 'NATNAEL SEYOUM',
        );
      },
    );
  }

  Widget _buildTransactionItem({
    required String date,
    required String type,
    required String amount,
    required String status,
    required String recipient,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () => context.pushNamed(
        RouteName.transactionDetail, 
        extra: {
          'transactionId': '123',
          'type': type,
          'amount': amount,
          'status': status,
          'recipient': recipient,
          'date': DateTime.parse(date),
        },
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: type == 'Bank Transfer'
                    ? AppColors.primaryColor.withOpacity(0.1)
                    : Colors.orange[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                type == 'Bank Transfer'
                    ? Icons.account_balance_rounded
                    : Icons.account_balance_wallet_rounded,
                color: type == 'Bank Transfer'
                    ? AppColors.primaryColor
                    : Colors.orange[700],
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          recipient,
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '\$$amount',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        type,
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 6.w),
                        width: 4.w,
                        height: 4.w,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: status == 'Completed'
                              ? Colors.green[50]
                              : Colors.orange[50],
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          status,
                          style: GoogleFonts.outfit(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: status == 'Completed'
                                ? Colors.green[700]
                                : Colors.orange[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
