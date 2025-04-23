import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:super_app/features/chat/common/widgets/widgets.dart';
import 'package:super_app/features/chat/common/entities/entities.dart';
import '../index.dart';
import 'package:super_app/features/chat/common/values/values.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactList extends GetView<ContactController> {
  Widget buildListItem(ContactItem item, BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {
          controller.goChat(context, item);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: <Widget>[
              // Avatar
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26.w),
                  child: CachedNetworkImage(
                    imageUrl: item.avatar!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.person,
                        color: Colors.grey[500],
                        size: 30.w,
                      ),
                    ),
                  ),
                ),
              ),

              // Username and status
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Username
                      Text(
                        "${item.username}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      // Status or additional info
                      Text(
                        "Tap to start a conversation",
                        style: TextStyle(
                          fontFamily: 'Avenir',
                          color: Colors.grey[600],
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Connection indicator
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryElement.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.primaryElement,
                  size: 16.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.state.contactList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 64.w,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "No contacts yet",
                    style: GoogleFonts.outfit(
                      color: Colors.grey,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
              itemCount: controller.state.contactList.length,
              itemBuilder: (context, index) {
                return buildListItem(
                    controller.state.contactList[index], context);
              },
            );
    });
  }
}
