import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_app/features/chat/common/widgets/widgets.dart';
import 'package:super_app/features/chat/pages/message/chat/widgets/chat_list.dart';
import 'index.dart';
import 'package:super_app/features/chat/common/values/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatPage extends StatefulWidget {
  final Map<String, dynamic>? arguments;

  const ChatPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ChatController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ChatController());
    if (widget.arguments != null) {
      print("the to name argument is ${widget.arguments!['to_name']}");
      controller.state.to_name.value =
          widget.arguments!['to_name']?.toString() ?? '';
      controller.state.to_avatar.value =
          widget.arguments!['to_avatar']?.toString() ?? '';
      controller.state.to_token.value =
          widget.arguments!['to_token']?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    Get.delete<ChatController>();
    super.dispose();
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primaryBackground,
      title: Obx(() {
        return Container(
          padding: EdgeInsets.only(top: 0.w, left: 0.w, right: 0.w),
          child: Text(
            "${controller.state.to_name}",
            overflow: TextOverflow.clip,
            maxLines: 1,
            style: TextStyle(
              fontFamily: 'Avenir',
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
              fontSize: 16.sp,
            ),
          ),
        );
      }),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20.w),
          child: Stack(alignment: Alignment.center, children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: AppColors.primarySecondaryBackground,
                borderRadius: BorderRadius.all(Radius.circular(22.w)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: controller.state.to_avatar.value == null
                  ? Image(
                      image: AssetImage('assets/images/account_header.png'),
                    )
                  : CachedNetworkImage(
                      imageUrl: controller.state.to_avatar.value,
                      height: 44.w,
                      width: 44.w,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(22.w)),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill
                              // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                              ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Image(
                        image: AssetImage('assets/images/account_header.png'),
                      ),
                    ),
            ),
            Positioned(
              bottom: 5.w,
              right: 0.w,
              height: 14.w,
              child: Container(
                width: 14.w,
                height: 14.w,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2.w, color: AppColors.primaryElementText),
                  color: controller.state.to_online.value == "1"
                      ? AppColors.primaryElementStatus
                      : AppColors.primarySecondaryElementText,
                  borderRadius: BorderRadius.all(Radius.circular(12.w)),
                ),
              ),
            )
          ]),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: Obx(() => SafeArea(
                child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ChatList(),
                  Positioned(
                    bottom: 0.h,
                    child: Container(
                      width: 360.w,
                      constraints:
                          BoxConstraints(maxHeight: 170.h, minHeight: 70.h),
                      padding: EdgeInsets.only(
                          left: 20.w, right: 20.w, bottom: 10.h, top: 10.h),
                      color: AppColors.primaryBackground,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              width: 270.w,
                              constraints: BoxConstraints(
                                  maxHeight: 170.h, minHeight: 30.h),
                              padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              decoration: BoxDecoration(
                                color: AppColors.primaryBackground,
                                border: Border.all(
                                    color:
                                        AppColors.primarySecondaryElementText),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Row(children: [
                                Container(
                                  width: 220.w,
                                  constraints: BoxConstraints(
                                      maxHeight: 150.h, minHeight: 20.h),
                                  child: TextField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    controller: controller.myinputController,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      hintText: "Message...",
                                      isDense: true,
                                      contentPadding: EdgeInsets.only(
                                          left: 10.w, top: 0, bottom: 0),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        color: AppColors
                                            .primarySecondaryElementText,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  child: Container(
                                    width: 40.w,
                                    height: 40.h,
                                    child: Image.asset("assets/icons/send.png"),
                                  ),
                                  onTap: () {
                                    controller.sendMessage();
                                  },
                                )
                              ])),
                          GestureDetector(
                              child: Container(
                                  height: 40.w,
                                  width: 40.w,
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: Offset(
                                            1, 1), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.w)),
                                  ),
                                  child: controller.state.more_status.value
                                      ? Image.asset("assets/icons/by.png")
                                      : Image.asset("assets/icons/add.png")),
                              onTap: () {
                                controller.goMore();
                              }),
                        ],
                      ),
                    ),
                  ),
                  controller.state.more_status.value
                      ? Positioned(
                          right: 20.w,
                          bottom: 70.h,
                          height: 200.w,
                          width: 40.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                child: Container(
                                    height: 40.w,
                                    width: 40.w,
                                    padding: EdgeInsets.all(10.w),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(1,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40.w)),
                                    ),
                                    child:
                                        Image.asset("assets/icons/file.png")),
                                onTap: () {
                                  controller.imgFromGallery();
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                    height: 40.w,
                                    width: 40.w,
                                    padding: EdgeInsets.all(10.w),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(1,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40.w)),
                                    ),
                                    child:
                                        Image.asset("assets/icons/photo.png")),
                                onTap: () {
                                  controller.imgFromCamera();
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                    height: 40.w,
                                    width: 40.w,
                                    padding: EdgeInsets.all(10.w),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(1,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40.w)),
                                    ),
                                    child:
                                        Image.asset("assets/icons/call.png")),
                                onTap: () {
                                  controller.callAudio(context);
                                },
                              ),
                              GestureDetector(
                                child: Container(
                                    height: 40.w,
                                    width: 40.w,
                                    padding: EdgeInsets.all(10.w),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(1,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40.w)),
                                    ),
                                    child:
                                        Image.asset("assets/icons/video.png")),
                                onTap: () {
                                  controller.callVideo(context);
                                },
                              ),
                            ],
                          ))
                      : Container()
                ],
              ),
            ))));
  }
}
