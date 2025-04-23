import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_app/features/chat/common/widgets/widgets.dart';
import 'index.dart';
import 'widgets/widgets.dart';
import 'package:super_app/features/chat/common/values/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:super_app/core/router/route_name.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late final ContactController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ContactController());
  }

  @override
  void dispose() {
    Get.delete<ContactController>();
    super.dispose();
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(65.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 1),
              blurRadius: 5,
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded, size: 20.w),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.goNamed(RouteName.message);
                    }
                  },
                ),
                SizedBox(width: 8.w),
                Text(
                  "Contacts",
                  style: GoogleFonts.outfit(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: AppColors.primaryElement,
                    size: 24.w,
                  ),
                  onPressed: () {
                    // Search functionality
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: _buildAppBar(),
      body: ContactList(),
    );
  }
}
