import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:super_app/features/chat/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'controller.dart';

class VideoCallPage extends StatefulWidget {
  final Map<String, dynamic>? arguments;
  const VideoCallPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  late final VideoCallController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(VideoCallController());
    if (widget.arguments != null) {
      print("Calling setParameters with: ${widget.arguments}");
      controller.setParameters(widget.arguments);
    } else {
      print("NO ARGUMENTS FOUND!");
    }
  }

  @override
  void dispose() {
    Get.delete<VideoCallController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(child: Obx(() {
          return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2C3E50), Color(0xFF1A2530)],
                ),
              ),
              child: controller.state.isReadyPreview.value
                  ? Stack(
                      children: [
                        controller.state.onremoteUid.value == 0
                            ? Container()
                            : AgoraVideoView(
                                controller: VideoViewController.remote(
                                  rtcEngine: controller.engine,
                                  canvas: VideoCanvas(
                                      uid: controller.state.onremoteUid.value),
                                  connection: RtcConnection(
                                      channelId:
                                          controller.state.channelId.value),
                                ),
                              ),
                        Positioned(
                          top: 30.h,
                          right: 15.w,
                          child: Container(
                            width: 100.w,
                            height: 140.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: AgoraVideoView(
                                controller: VideoViewController(
                                  rtcEngine: controller.engine,
                                  canvas: const VideoCanvas(uid: 0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        controller.state.isShowAvatar.value
                            ? Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 6.h),
                                        child: Text(
                                          "${controller.state.call_time.value}",
                                          style: GoogleFonts.outfit(
                                            color: Colors.white70,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 120.w,
                                        height: 120.w,
                                        margin: EdgeInsets.only(top: 40.h),
                                        decoration: BoxDecoration(
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
                                          borderRadius:
                                              BorderRadius.circular(60.w),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "${controller.state.to_avatar.value}",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Container(
                                              color: Colors.grey[800],
                                              child: Icon(Icons.person,
                                                  color: Colors.white,
                                                  size: 50.w),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              color: Colors.grey[800],
                                              child: Icon(Icons.person,
                                                  color: Colors.white,
                                                  size: 50.w),
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
                                        "Connecting video call...",
                                        style: TextStyle(
                                          fontFamily: 'Avenir',
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      )
                                    ]))
                            : Container(),
                        Positioned(
                            bottom: 40.h,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Call button
                                GestureDetector(
                                  onTap: controller.state.isJoined.value
                                      ? controller.leaveChannel
                                      : controller.joinChannel,
                                  child: Container(
                                    width: 65.w,
                                    height: 65.w,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    decoration: BoxDecoration(
                                      color: controller.state.isJoined.value
                                          ? Colors.redAccent
                                          : Colors.greenAccent,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: controller.state.isJoined.value
                                              ? Colors.redAccent
                                                  .withOpacity(0.3)
                                              : Colors.greenAccent
                                                  .withOpacity(0.3),
                                          blurRadius: 12,
                                          spreadRadius: 2,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      controller.state.isJoined.value
                                          ? Icons.call_end
                                          : Icons.videocam,
                                      color: Colors.white,
                                      size: 28.sp,
                                    ),
                                  ),
                                ),

                                // Camera switch button
                                GestureDetector(
                                  onTap: controller.switchCamera,
                                  child: Container(
                                    width: 55.w,
                                    height: 55.w,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white24,
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
                                      Icons.flip_camera_ios,
                                      color: Colors.white,
                                      size: 24.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    )
                  : Container());
        })));
  }
}
