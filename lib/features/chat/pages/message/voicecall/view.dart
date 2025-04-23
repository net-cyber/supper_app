import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:intl/intl.dart';
import 'package:super_app/features/chat/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
      backgroundColor: Color(0xFF2C3E50), // Modern dark background
      body: SafeArea(
        child: Obx(() {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2C3E50), Color(0xFF1A2530)],
              ),
            ),
            child: Stack(children: [
              // Call time and user info
              Positioned(
                  top: 40.h,
                  left: 30.w,
                  right: 30.w,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 6.h),
                          child: Text(
                            "${controller.state.call_time.value}",
                            style: GoogleFonts.outfit(
                              color: Colors.white70,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          width: 120.w,
                          height: 120.w,
                          margin: EdgeInsets.only(top: 50.h),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60.w),
                            child: CachedNetworkImage(
                              imageUrl: "${controller.state.to_avatar.value}",
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[800],
                                child: Icon(Icons.person,
                                    color: Colors.white, size: 50.w),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[800],
                                child: Icon(Icons.person,
                                    color: Colors.white, size: 50.w),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16.h),
                          child: Text(
                            "${controller.state.to_name.value}",
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Voice Call",
                          style: const TextStyle(
                            fontFamily: 'Avenir',
                            color: Colors.white60,
                            fontSize: 16,
                          ),
                        )
                      ])),

              // Call controls
              Positioned(
                bottom: 50.h,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    // Call quality indicator
                    Container(
                      margin: EdgeInsets.only(bottom: 30.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        "HD Voice",
                        style: GoogleFonts.outfit(
                          color: Colors.white70,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),

                    // Call controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Microphone button
                        Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 56.w,
                                height: 56.w,
                                decoration: BoxDecoration(
                                  color: controller.state.openMicrophone.value
                                      ? Colors.white
                                      : Colors.white24,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  controller.state.openMicrophone.value
                                      ? Icons.mic
                                      : Icons.mic_off,
                                  color: controller.state.openMicrophone.value
                                      ? Color(0xFF2C3E50)
                                      : Colors.white70,
                                  size: 26.sp,
                                ),
                              ),
                              onTap: controller.state.isJoined.value
                                  ? controller.switchMicrophone
                                  : null,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "Mute",
                              style: GoogleFonts.outfit(
                                color: Colors.white70,
                                fontSize: 12.sp,
                              ),
                            )
                          ],
                        ),

                        // Call button
                        Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 72.w,
                                height: 72.w,
                                decoration: BoxDecoration(
                                  color: controller.state.isJoined.value
                                      ? Colors.redAccent
                                      : Colors.greenAccent,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: controller.state.isJoined.value
                                          ? Colors.redAccent.withOpacity(0.3)
                                          : Colors.greenAccent.withOpacity(0.3),
                                      blurRadius: 12,
                                      spreadRadius: 2,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  controller.state.isJoined.value
                                      ? Icons.call_end
                                      : Icons.call,
                                  color: Colors.white,
                                  size: 30.sp,
                                ),
                              ),
                              onTap: controller.state.isJoined.value
                                  ? controller.leaveChannel
                                  : controller.joinChannel,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              controller.state.isJoined.value ? "End" : "Call",
                              style: GoogleFonts.outfit(
                                color: Colors.white70,
                                fontSize: 12.sp,
                              ),
                            )
                          ],
                        ),

                        // Speaker button
                        Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                width: 56.w,
                                height: 56.w,
                                decoration: BoxDecoration(
                                  color:
                                      controller.state.enableSpeakerphone.value
                                          ? Colors.white
                                          : Colors.white24,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  controller.state.enableSpeakerphone.value
                                      ? Icons.volume_up
                                      : Icons.volume_down,
                                  color:
                                      controller.state.enableSpeakerphone.value
                                          ? Color(0xFF2C3E50)
                                          : Colors.white70,
                                  size: 26.sp,
                                ),
                              ),
                              onTap: controller.state.isJoined.value
                                  ? controller.switchSpeakerphone
                                  : null,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "Speaker",
                              style: GoogleFonts.outfit(
                                color: Colors.white70,
                                fontSize: 12.sp,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ]),
          );
        }),
      ),
    );
  }
}
