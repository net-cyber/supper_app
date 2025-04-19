import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MiniAppWebView extends StatefulWidget {
  final String title;
  final String url;

  const MiniAppWebView({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  State<MiniAppWebView> createState() => _MiniAppWebViewState();
}

class _MiniAppWebViewState extends State<MiniAppWebView> {
  late final WebViewController controller;
  bool isLoading = true;
  bool canGoBack = false;
  bool canGoForward = false;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              isLoading = progress < 100;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
            controller
                .canGoBack()
                .then((value) => setState(() => canGoBack = value));
            controller
                .canGoForward()
                .then((value) => setState(() => canGoForward = value));
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.outfit(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 2,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.grey[800],
            size: 20.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (canGoBack)
            IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.grey[800],
                size: 22.sp,
              ),
              onPressed: () => controller.goBack(),
            ),
          if (canGoForward)
            IconButton(
              icon: Icon(
                Icons.arrow_forward_rounded,
                color: Colors.grey[800],
                size: 22.sp,
              ),
              onPressed: () => controller.goForward(),
            ),
          IconButton(
            icon: Icon(
              Icons.refresh_rounded,
              color: Colors.grey[800],
              size: 22.sp,
            ),
            onPressed: () => controller.reload(),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
