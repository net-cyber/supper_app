import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:intl/intl.dart';
import 'package:super_app/features/chat/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'controller.dart';

class VoiceCallViewPage extends StatefulWidget {
  final Map<String, dynamic>? arguments;
  const VoiceCallViewPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<VoiceCallViewPage> createState() => _VoiceCallViewPageState();
}

class _VoiceCallViewPageState extends State<VoiceCallViewPage> {
  late final VoiceCallViewController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(VoiceCallViewController());
    if (widget.arguments != null) {
      print("Calling setParameters with: ${widget.arguments}");
      controller.setParameters(widget.arguments);
    } else {
      print("NO ARGUMENTS FOUND!");
    }
  }

  @override
  void dispose() {
    Get.delete<VoiceCallViewController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary_bg,
      body: SafeArea(
        child: Obx(() {
          return Container(
            child: Stack(children: [
              Positioned(
                  top: 10.h,
                  left: 30.w,
                  right: 30.w,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 6.h),
                          child: Text(
                            "${controller.state.call_time.value}",
                            style: TextStyle(
                              color: AppColors.primaryElementText,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          width: 70.w,
                          height: 70.w,
                          margin: EdgeInsets.only(top: 150.h),
                          padding: EdgeInsets.all(0.w),
                          decoration: BoxDecoration(
                            color: AppColors.primaryElementText,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.w)),
                          ),
                          child: Image.network(
                            "${controller.state.to_avatar.value}",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 6.h),
                          child: Text(
                            "${controller.state.to_name.value}",
                            style: TextStyle(
                              color: AppColors.primaryElementText,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                      ])),
              Positioned(
                  bottom: 80.h,
                  left: 30.w,
                  right: 30.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            child: Container(
                                width: 60.w,
                                height: 60.w,
                                padding: EdgeInsets.all(15.w),
                                decoration: BoxDecoration(
                                  color: controller.state.openMicrophone.value
                                      ? AppColors.primaryElementText
                                      : AppColors.primaryText,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.w)),
                                ),
                                child: controller.state.openMicrophone.value
                                    ? Image.asset(
                                        "assets/icons/b_microphone.png")
                                    : Image.asset(
                                        "assets/icons/a_microphone.png")),
                            onTap: controller.state.isJoined.value
                                ? controller.switchMicrophone
                                : null,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.h),
                            child: Text(
                              "Microphone",
                              style: TextStyle(
                                color: AppColors.primaryElementText,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(children: [
                        GestureDetector(
                          child: Container(
                            width: 60.w,
                            height: 60.w,
                            padding: EdgeInsets.all(15.w),
                            decoration: BoxDecoration(
                              color: controller.state.isJoined.value
                                  ? AppColors.primaryElementBg
                                  : AppColors.primaryElementStatus,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.w)),
                            ),
                            child: controller.state.isJoined.value
                                ? Image.asset("assets/icons/a_phone.png")
                                : Image.asset("assets/icons/a_telephone.png"),
                          ),
                          onTap: controller.state.isJoined.value
                              ? controller.leaveChannel
                              : controller.joinChannel,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.h),
                          child: Text(
                            controller.state.isJoined.value
                                ? "Disconnect"
                                : "Connected",
                            style: TextStyle(
                              color: AppColors.primaryElementText,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ]),
                      Column(children: [
                        GestureDetector(
                          child: Container(
                            width: 60.w,
                            height: 60.w,
                            padding: EdgeInsets.all(15.w),
                            decoration: BoxDecoration(
                              color: controller.state.enableSpeakerphone.value
                                  ? AppColors.primaryElementText
                                  : AppColors.primaryText,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.w)),
                            ),
                            child: controller.state.enableSpeakerphone.value
                                ? Image.asset("assets/icons/bo_trumpet.png")
                                : Image.asset("assets/icons/a_trumpet.png"),
                          ),
                          onTap: controller.state.isJoined.value
                              ? controller.switchSpeakerphone
                              : null,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.h),
                          child: Text(
                            "Speakerphone",
                            style: TextStyle(
                              color: AppColors.primaryElementText,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                      ]),
                    ],
                  ))
            ]),
          );
        }),
      ),
    );
  }
}
