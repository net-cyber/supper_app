import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';
import 'package:open_file/open_file.dart';

class SuccessDialog extends StatefulWidget {
  final String transactionId;
  final double amount;
  final String recipientName;
  final String? receiptPath;
  final String? receiptName;
  final String routeName;
  final String transactionType;
  final String currency;
  final Color primaryColor;
  final Color successColor;

  const SuccessDialog({
    super.key,
    required this.transactionId,
    required this.amount,
    required this.recipientName,
    this.receiptPath,
    this.receiptName,
    required this.routeName,
    required this.transactionType,
    required this.currency,
    required this.primaryColor,
    required this.successColor,
  });

  @override
  State<SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> {
  final GlobalKey _successDialogKey = GlobalKey();
  bool isDownloading = false;
  bool isSharing = false;
  bool isScreenshotting = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            contentPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 24.w, top: 12.w),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.receiptPath != null) ...[
                  // Screenshot button
                  IconButton(
                    icon: isScreenshotting 
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                widget.primaryColor,
                              ),
                            ),
                          )
                        : Icon(
                            Icons.screenshot_outlined,
                            color: widget.primaryColor,
                            size: 24.sp,
                          ),
                    tooltip: 'Take Screenshot',
                    onPressed: isScreenshotting 
                        ? null 
                        : () async {
                            setState(() { isScreenshotting = true; });
                            try {
                              await _captureAndSaveScreenshot(context);
                            } finally {
                              if (mounted) {
                                setState(() { isScreenshotting = false; });
                              }
                            }
                          },
                  ),
                  
                  // Share button
                  IconButton(
                    icon: isSharing 
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                widget.primaryColor,
                              ),
                            ),
                          )
                        : Icon(
                            Icons.share_outlined,
                            color: widget.primaryColor,
                            size: 24.sp,
                          ),
                    tooltip: 'Share Receipt',
                    onPressed: isSharing
                        ? null
                        : () async {
                            setState(() { isSharing = true; });
                            try {
                              await _shareReceipt(context, widget.receiptPath!);
                            } finally {
                              if (mounted) {
                                setState(() { isSharing = false; });
                              }
                            }
                          },
                  ),
                  
                  // Download button
                  IconButton(
                    icon: isDownloading
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                widget.primaryColor,
                              ),
                            ),
                          )
                        : Icon(
                            Icons.download_outlined,
                            color: widget.primaryColor,
                            size: 24.sp,
                          ),
                    tooltip: 'Download Receipt',
                    onPressed: isDownloading
                        ? null
                        : () async {
                            setState(() { isDownloading = true; });
                            try {
                              await _downloadReceiptToStorage(
                                context, 
                                widget.receiptPath!, 
                                widget.receiptName!,
                              );
                            } finally {
                              if (mounted) {
                                setState(() { isDownloading = false; });
                              }
                            }
                          },
                  ),
                ],
                
                // Close button
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey[600],
                    size: 24.sp,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Future.microtask(() {
                      GoRouter.of(context).goNamed(widget.routeName);
                    });
                  },
                ),
              ],
            ),
            content: RepaintBoundary(
              key: _successDialogKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Success animation with confetti effect
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: widget.successColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_circle,
                          color: widget.successColor,
                          size: 64.sp,
                        ),
                      ),
                      // Decorative elements around success icon
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            color: widget.primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        left: 5,
                        child: Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                            color: widget.successColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  // Transaction type badge
                  Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: widget.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: widget.primaryColor.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.bolt,
                          color: widget.primaryColor,
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          widget.transactionType,
                          style: GoogleFonts.outfit(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: widget.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    'Transaction Successful!',
                    style: GoogleFonts.outfit(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    '${widget.currency} ${widget.amount.toStringAsFixed(2)} has been transferred to ${widget.recipientName}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  
                  // Transaction details in decorated container
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      'Transaction ID: ${widget.transactionId}',
                      style: GoogleFonts.outfit(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),

                  // Receipt status message
                  if (widget.receiptPath != null) ...[
                    SizedBox(height: 16.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: widget.successColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: widget.successColor.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.receipt_outlined,
                            color: widget.successColor,
                            size: 16.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Receipt Ready',
                            style: GoogleFonts.outfit(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: widget.successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  SizedBox(height: 24.h),

                  // Done button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Future.microtask(() {
                          GoRouter.of(context).goNamed(widget.routeName);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.r),
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              widget.primaryColor,
                              widget.primaryColor.withOpacity(0.8),
                            ],
                            stops: const [0.3, 1.0],
                          ),
                          borderRadius: BorderRadius.circular(28.r),
                          boxShadow: [
                            BoxShadow(
                              color: widget.primaryColor.withOpacity(0.25),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 56.h,
                          alignment: Alignment.center,
                          child: Text(
                            'Done',
                            style: GoogleFonts.outfit(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  Future<void> _shareReceipt(BuildContext context, String filePath) async {
    try {
      final File fileToShare = File(filePath);
      if (!await fileToShare.exists()) {
        return;
      }

      int sdkVersion = 0;
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        sdkVersion = androidInfo.version.sdkInt;
      }

      try {
        if (Platform.isAndroid && sdkVersion < 33) {
          final status = await Permission.storage.request();
          if (!status.isGranted) {
            if (status.isPermanentlyDenied && context.mounted) {
              _showPermissionPermanentlyDeniedDialog(context);
            }
            return;
          }
        }

        final xFile = XFile(filePath);
        await Share.shareXFiles(
          [xFile],
          text: 'Transaction Receipt',
          subject: 'Transaction Receipt',
        );
      } catch (e) {
        try {
          await OpenFile.open(filePath);
        } catch (e) {
          // Handle error silently
        }
      }
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _downloadReceiptToStorage(
    BuildContext context,
    String filePath,
    String fileName,
  ) async {
    try {
      final File sourceFile = File(filePath);
      if (!await sourceFile.exists()) {
        return;
      }

      int sdkVersion = 0;
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        sdkVersion = androidInfo.version.sdkInt;
      }

      String destinationPath = '';
      bool permissionGranted = true;

      if (Platform.isAndroid) {
        if (sdkVersion < 33) {
          final status = await Permission.storage.request();
          if (!status.isGranted) {
            permissionGranted = false;
            if (status.isPermanentlyDenied && context.mounted) {
              _showPermissionPermanentlyDeniedDialog(context);
            }
          }
        }

        if (permissionGranted) {
          try {
            if (sdkVersion >= 30) {
              Directory? downloadsDir = await getExternalStorageDirectory();
              if (downloadsDir != null) {
                final appDownloadsDir = Directory('${downloadsDir.path}/Downloads');
                if (!await appDownloadsDir.exists()) {
                  await appDownloadsDir.create(recursive: true);
                }
                destinationPath = '${appDownloadsDir.path}/$fileName';
              } else {
                final appDocDir = await getApplicationDocumentsDirectory();
                destinationPath = '${appDocDir.path}/$fileName';
              }
            } else {
              final downloadsDir = Directory('/storage/emulated/0/Download');
              if (await downloadsDir.exists()) {
                destinationPath = '${downloadsDir.path}/$fileName';
              } else {
                final appDir = await getExternalStorageDirectory();
                if (appDir != null) {
                  destinationPath = '${appDir.path}/$fileName';
                } else {
                  final appDocDir = await getApplicationDocumentsDirectory();
                  destinationPath = '${appDocDir.path}/$fileName';
                }
              }
            }
          } catch (e) {
            final appDocDir = await getApplicationDocumentsDirectory();
            destinationPath = '${appDocDir.path}/$fileName';
          }
        }
      } else if (Platform.isIOS) {
        final directory = await getApplicationDocumentsDirectory();
        destinationPath = '${directory.path}/$fileName';
      }

      if (!permissionGranted) {
        return;
      }

      final parentDir = Directory(path.dirname(destinationPath));
      if (!await parentDir.exists()) {
        await parentDir.create(recursive: true);
      }

      await sourceFile.copy(destinationPath);
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _captureAndSaveScreenshot(BuildContext context) async {
    try {
      final RenderRepaintBoundary boundary = _successDialogKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      
      if (byteData == null) {
        return;
      }
      
      final Uint8List pngBytes = byteData.buffer.asUint8List();
      
      int sdkVersion = 0;
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        sdkVersion = androidInfo.version.sdkInt;
      }
      
      String screenshotPath = '';
      bool permissionGranted = true;
      
      if (Platform.isAndroid) {
        if (sdkVersion < 33) {
          final status = await Permission.storage.request();
          if (!status.isGranted) {
            permissionGranted = false;
            if (status.isPermanentlyDenied && context.mounted) {
              _showPermissionPermanentlyDeniedDialog(context);
            }
          }
        }
        
        if (permissionGranted) {
          try {
            final now = DateTime.now();
            final timestamp = '${now.day.toString().padLeft(2, '0')}${now.month.toString().padLeft(2, '0')}${now.year}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
            final screenshotFileName = 'Transaction_Screenshot_$timestamp.png';
            
            if (sdkVersion >= 30) {
              Directory? downloadsDir = await getExternalStorageDirectory();
              if (downloadsDir != null) {
                final appScreenshotsDir = Directory('${downloadsDir.path}/Screenshots');
                if (!await appScreenshotsDir.exists()) {
                  await appScreenshotsDir.create(recursive: true);
                }
                screenshotPath = '${appScreenshotsDir.path}/$screenshotFileName';
              } else {
                final appDocDir = await getApplicationDocumentsDirectory();
                screenshotPath = '${appDocDir.path}/$screenshotFileName';
              }
            } else {
              final downloadsDir = Directory('/storage/emulated/0/Download');
              if (await downloadsDir.exists()) {
                screenshotPath = '${downloadsDir.path}/$screenshotFileName';
              } else {
                final appDir = await getExternalStorageDirectory();
                if (appDir != null) {
                  screenshotPath = '${appDir.path}/$screenshotFileName';
                } else {
                  final appDocDir = await getApplicationDocumentsDirectory();
                  screenshotPath = '${appDocDir.path}/$screenshotFileName';
                }
              }
            }
          } catch (e) {
            final appDocDir = await getApplicationDocumentsDirectory();
            final screenshotFileName = 'Transaction_Screenshot_${DateTime.now().millisecondsSinceEpoch}.png';
            screenshotPath = '${appDocDir.path}/$screenshotFileName';
          }
        }
      } else if (Platform.isIOS) {
        final directory = await getApplicationDocumentsDirectory();
        final screenshotFileName = 'Transaction_Screenshot_${DateTime.now().millisecondsSinceEpoch}.png';
        screenshotPath = '${directory.path}/$screenshotFileName';
      }
      
      if (!permissionGranted) {
        return;
      }
      
      final parentDir = Directory(path.dirname(screenshotPath));
      if (!await parentDir.exists()) {
        await parentDir.create(recursive: true);
      }
      
      final file = File(screenshotPath);
      await file.writeAsBytes(pngBytes);
    } catch (e) {
      // Handle error silently
    }
  }

  void _showPermissionPermanentlyDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: Text(
            'Storage Permission Required',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Storage permission is permanently denied. Please enable it in app settings to download or share receipts.',
            style: GoogleFonts.outfit(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.outfit(
                  color: Colors.grey[700],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Open Settings',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
} 