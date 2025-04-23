import 'package:cached_network_image/cached_network_image.dart';
import 'package:super_app/features/chat/common/entities/entities.dart';
import 'package:super_app/features/chat/common/routes/names.dart';
import 'package:super_app/features/chat/common/store/store.dart';
import 'package:super_app/features/chat/common/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_app/features/chat/common/widgets/widgets.dart';
import 'index.dart';
import 'package:super_app/features/chat/common/values/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:google_fonts/google_fonts.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with SingleTickerProviderStateMixin {
  late final MessageController controller;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(MessageController());
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        controller.state.tabStatus.value = _tabController.index == 0;
        controller.goTabStatus();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    Get.delete<MessageController>();
    super.dispose();
  }

  Widget chatListItem(Message item, BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {
          if (item.doc_id != null) {
            context.goNamed(RouteName.chat, extra: {
              "doc_id": item.doc_id!,
              "to_token": item.token!,
              "to_name": item.name!,
              "to_avatar": item.avatar!,
              "to_online": item.online.toString()
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: <Widget>[
              // Avatar with online indicator
              Stack(
                children: [
                  Hero(
                    tag: item.token ?? '',
                    child: Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(28.w),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28.w),
                        child: item.avatar == null
                            ? Image.asset(
                                'assets/images/account_header.png',
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: item.avatar!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: Colors.grey[300],
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/images/account_header.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 2.w,
                    right: 2.w,
                    child: Container(
                      width: 14.w,
                      height: 14.w,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2.w, color: Colors.white),
                        color: item.online == 1 ? Colors.green : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              // Message content and timestamp
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.name ?? "",
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          item.last_time == null
                              ? ""
                              : duTimeLineFormat(
                                  (item.last_time as Timestamp).toDate()),
                          style: const TextStyle(
                            fontFamily: 'Avenir',
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.last_msg ?? "",
                            style: const TextStyle(
                              fontFamily: 'Avenir',
                              color: Color(0xFF757575),
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (item.msg_num! > 0)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: AppColors.primaryElement,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              "${item.msg_num}",
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 12,
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
      ),
    );
  }

  Widget callListItem(CallMessage item) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: <Widget>[
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(28.w),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28.w),
                  child: item.avatar == null
                      ? Image.asset(
                          'assets/images/account_header.png',
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          imageUrl: item.avatar!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[300],
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/account_header.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              SizedBox(width: 16.w),
              // Call details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.name ?? "",
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          item.last_time == null
                              ? ""
                              : duTimeLineFormat(
                                  (item.last_time as Timestamp).toDate()),
                          style: const TextStyle(
                            fontFamily: 'Avenir',
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              item.type == "voice"
                                  ? Icons.call
                                  : Icons.video_call,
                              color: AppColors.primaryElement,
                              size: 16.w,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              item.call_time ?? "",
                              style: const TextStyle(
                                fontFamily: 'Avenir',
                                color: Color(0xFF757575),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            item.type == "voice" ? "Voice" : "Video",
                            style: const TextStyle(
                              fontFamily: 'Avenir',
                              color: Color(0xFF616161),
                              fontSize: 12,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: SafeArea(
        child: Obx(
          () => NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  floating: true,
                  pinned: true,
                  title: Row(
                    children: [
                      SizedBox(width: 12.w),
                      Text(
                        "Messages",
                        style: GoogleFonts.outfit(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black87,
                        size: 24.w,
                      ),
                      onPressed: () {
                        // Search functionality
                      },
                    ),
                  ],
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(48.h),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        labelColor: AppColors.primaryElement,
                        unselectedLabelColor: Colors.grey,
                        labelStyle: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            width: 3.h,
                            color: AppColors.primaryElement,
                          ),
                          insets: EdgeInsets.symmetric(horizontal: 60.w),
                        ),
                        tabs: [
                          Tab(text: "Chats"),
                          Tab(text: "Calls"),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                // Chats list
                controller.state.msgList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              size: 64.w,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "No messages yet",
                              style: GoogleFonts.outfit(
                                color: Colors.grey,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(top: 8.h, bottom: 80.h),
                        itemCount: controller.state.msgList.length,
                        itemBuilder: (context, index) {
                          return chatListItem(
                              controller.state.msgList[index], context);
                        },
                      ),

                // Calls list
                controller.state.callList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.call_outlined,
                              size: 64.w,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "No calls yet",
                              style: GoogleFonts.outfit(
                                color: Colors.grey,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(top: 8.h, bottom: 80.h),
                        itemCount: controller.state.callList.length,
                        itemBuilder: (context, index) {
                          return callListItem(controller.state.callList[index]);
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(RouteName.contact);
        },
        backgroundColor: AppColors.primaryElement,
        elevation: 4,
        child: Icon(
          Icons.person_add_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
