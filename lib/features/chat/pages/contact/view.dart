import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_app/features/chat/common/widgets/widgets.dart';
import 'index.dart';
import 'widgets/widgets.dart';
import 'package:super_app/features/chat/common/values/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Contact",
        style: TextStyle(
          color: AppColors.primaryText,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ContactList(),
    );
  }
}
