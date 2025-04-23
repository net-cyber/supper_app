import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/chat/common/widgets/widgets.dart';
import 'package:super_app/features/chat/pages/message/chat/widgets/chat_list.dart';
import 'index.dart';
import 'package:super_app/features/chat/common/values/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class ChatPage extends StatefulWidget {
  final Map<String, dynamic>? arguments;

  const ChatPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  late final ChatController controller;
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller = Get.put(ChatController());

    if (widget.arguments != null) {
      print("the to name argument is ${widget.arguments!['to_name']}");

      controller.doc_id = widget.arguments!['doc_id']?.toString();

      controller.state.to_name.value =
          widget.arguments!['to_name']?.toString() ?? '';
      controller.state.to_avatar.value =
          widget.arguments!['to_avatar']?.toString() ?? '';
      controller.state.to_token.value =
          widget.arguments!['to_token']?.toString() ?? '';
      controller.state.to_online.value =
          widget.arguments!['to_online']?.toString() ?? '1';

      if (controller.doc_id != null) {
        controller.clear_msg_num(controller.doc_id.toString());
      }
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();

    // Delay the controller deletion slightly to prevent navigation issues
    Future.delayed(Duration.zero, () {
      if (Get.isRegistered<ChatController>()) {
        Get.delete<ChatController>();
      }
    });

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
                  onPressed: () => context.goNamed(RouteName.message),
                ),
                Hero(
                  tag: controller.state.to_token.value,
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.w),
                      child: controller.state.to_avatar.value.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: controller.state.to_avatar.value,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[300],
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/account_header.png',
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.asset(
                              'assets/images/account_header.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Show user profile or info
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.state.to_name.value,
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                color: controller.state.to_online.value == "1"
                                    ? Colors.green
                                    : Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              controller.state.to_online.value == "1"
                                  ? "Active now"
                                  : "Offline",
                              style: const TextStyle(
                                fontFamily: 'Avenir',
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.phone_outlined,
                    color: AppColors.primaryElement,
                    size: 22.w,
                  ),
                  onPressed: () {
                    // Voice call action
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.videocam_outlined,
                    color: AppColors.primaryElement,
                    size: 22.w,
                  ),
                  onPressed: () {
                    // Video call action
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
      appBar: _buildAppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            // Chat messages area
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF8F9FA), // Light gray solid background
                ),
                child: ChatList(),
              ),
            ),

            // Message input area
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: Offset(0, -1),
                    blurRadius: 5,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Message input field
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: 120.h,
                          minHeight: 45.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(22.5.w),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        child: TextField(
                          controller: _textController,
                          focusNode: _focusNode,
                          minLines: 1,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                          style: const TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            hintText: 'Type a message...',
                            hintStyle: const TextStyle(
                              fontFamily: 'Avenir',
                              color: Color(0xFF9E9E9E),
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                          ),
                          onChanged: (text) {
                            controller.myinputController.text = text;
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),

                    // Send button
                    Container(
                      height: 45.h,
                      width: 45.w,
                      decoration: BoxDecoration(
                        color: AppColors.primaryElement,
                        borderRadius: BorderRadius.circular(22.5.w),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryElement.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 20.w,
                        ),
                        onPressed: () {
                          controller.sendMessage();
                          _textController.clear();
                          _focusNode.requestFocus();
                        },
                        padding: EdgeInsets.zero,
                        splashRadius: 22.w,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
