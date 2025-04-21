import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/constants/app_constants.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/auth/domain/user/user_service.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:async';
import 'dart:math' as math;

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key, required this.accountId});
  final String accountId;

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> with TickerProviderStateMixin {
  bool _isScanMode = true;
  late TabController _tabController;
  final UserService _userService = getIt<UserService>();
  bool _isFlashOn = false;
  bool _isScanningPaused = false;
  String? _scannedCode;
  
  // Animation controller for scan line
  late AnimationController _scanAnimationController;
  late Animation<double> _scanAnimation;
  
  // Camera controller
  MobileScannerController _scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    
    // Initialize animation controller
    _scanAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    // Create animation
    _scanAnimation = Tween<double>(begin: -0.7, end: 0.7).animate(
      CurvedAnimation(parent: _scanAnimationController, curve: Curves.easeInOut)
    );
  }
  
  void _handleTabChange() {
    setState(() {
      _isScanMode = _tabController.index == 0;
      
      // Pause scanner when not on scan tab to save resources
      if (_isScanMode) {
        _scannerController.start();
      } else {
        _scannerController.stop();
      }
    });
  }
  
  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
      _scannerController.toggleTorch();
    });
  }
  
  void _toggleCamera() {
    _scannerController.switchCamera();
  }
  
  void _onDetect(BarcodeCapture capture) {
    if (_isScanningPaused) return;
    
    final List<Barcode> barcodes = capture.barcodes;
    
    if (barcodes.isNotEmpty) {
      final Barcode barcode = barcodes.first;
      if (barcode.rawValue != null) {
        setState(() {
          _scannedCode = barcode.rawValue;
          _isScanningPaused = true;
          context.pushNamed(RouteName.internalBankAccount, extra: {'accountId': _scannedCode});
        });
      }
    }
  }
  

  
  @override
  void dispose() {
    _tabController.dispose();
    _scanAnimationController.dispose();
    _scannerController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 2,
        title: Text(
          'QR Code Transfer',
          style: GoogleFonts.outfit(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(64.h),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            height: 52.h,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(26.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(26.r),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[700],
              labelStyle: GoogleFonts.outfit(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: GoogleFonts.outfit(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              tabs: [
                Tab(
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code_scanner_rounded, size: 18.sp),
                      SizedBox(width: 8.w),
                      const Text('Scan Code'),
                    ],
                  ),
                ),
                Tab(
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code_rounded, size: 18.sp),
                      SizedBox(width: 8.w),
                      const Text('My Code'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildQrScanner(),
          _buildMyQrCode(),
        ],
      ),
    );
  }

  Widget _buildQrScanner() {
    return Container(
      color: Colors.grey[50],
      child: Column(
        children: [
          SizedBox(height: 24.h),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            height: 375.h,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Real camera view
                  MobileScanner(
                    controller: _scannerController,
                    onDetect: _onDetect,
                    overlay: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ),
                  ),
                  
                  // Scan area with animated scanner line
                  Center(
                    child: Container(
                      width: 220.w,
                      height: 220.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2.5,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Stack(
                        children: [
                          // Corner decorations
                          Positioned(
                            top: -2.5,
                            left: -2.5,
                            child: Container(
                              width: 32.w,
                              height: 32.h,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Theme.of(context).colorScheme.primary, width: 5),
                                  left: BorderSide(color: Theme.of(context).colorScheme.primary, width: 5),
                                ),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r)),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -2.5,
                            right: -2.5,
                            child: Container(
                              width: 32.w,
                              height: 32.h,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Theme.of(context).colorScheme.primary, width: 5),
                                  right: BorderSide(color: Theme.of(context).colorScheme.primary, width: 5),
                                ),
                                borderRadius: BorderRadius.only(topRight: Radius.circular(16.r)),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -2.5,
                            left: -2.5,
                            child: Container(
                              width: 32.w,
                              height: 32.h,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Theme.of(context).colorScheme.primary, width: 5),
                                  left: BorderSide(color: Theme.of(context).colorScheme.primary, width: 5),
                                ),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.r)),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -2.5,
                            right: -2.5,
                            child: Container(
                              width: 32.w,
                              height: 32.h,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Theme.of(context).colorScheme.primary, width: 5),
                                  right: BorderSide(color: Theme.of(context).colorScheme.primary, width: 5),
                                ),
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(16.r)),
                              ),
                            ),
                          ),
                          
                          // Animated scan line
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Center(
                              child: AnimatedBuilder(
                                animation: _scanAnimation,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(0, _scanAnimation.value * 100.h),
                                    child: Container(
                                      width: 200.w,
                                      height: 2.h,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            Theme.of(context).colorScheme.primary,
                                            Theme.of(context).colorScheme.primary,
                                            Colors.transparent,
                                          ],
                                          stops: const [0.0, 0.3, 0.7, 1.0],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                                            blurRadius: 12.0,
                                            spreadRadius: 2.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  
                  
                  // Instruction overlay
                  Positioned(
                    bottom: 24.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.white.withOpacity(0.8),
                            size: 18.sp,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'Position QR code in the frame',
                            style: GoogleFonts.outfit(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.9),
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 24.h),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              'Scan a QR code to transfer funds or view account information',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                height: 1.4,
                color: Colors.grey[700],
              ),
            ),
          ),
          
          SizedBox(height: 24.h),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: _toggleFlash,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isFlashOn 
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                        color: _isFlashOn
                            ? Theme.of(context).colorScheme.primary.withOpacity(0.4)
                            : Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Icon(
                    _isFlashOn ? Icons.flash_on : Icons.flash_off,
                    color: _isFlashOn ? Colors.white : Colors.grey[700],
                    size: 24.sp,
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              InkWell(
                onTap: _toggleCamera,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.flip_camera_ios,
                    color: Colors.grey[700],
                    size: 24.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMyQrCode() {
    // Format account ID to make it more readable in UI display
    final String formattedAccountId = widget.accountId.length > 8
        ? "${widget.accountId.substring(0, 4)}...${widget.accountId.substring(widget.accountId.length - 4)}"
        : widget.accountId;

    return Container(
      color: Colors.grey[50],
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 24.h),
            Stack(
              alignment: Alignment.center,
              children: [
                // Background decorative elements
                Positioned(
                  top: 40.h,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 180.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                
                // QR Code Card
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        spreadRadius: 0,
                        offset: const Offset(0, 10),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 5,
                        spreadRadius: 0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Card header with logo
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.06),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24.r),
                            topRight: Radius.circular(24.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppConstants.gohbetochLogoVertical,
                              width: 30.w,
                              height: 30.h,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'GOH Betoch',
                              style: GoogleFonts.outfit(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                        child: Column(
                          children: [
                            // Account ID display
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: Colors.grey[200]!,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.account_balance_wallet,
                                    size: 16.sp,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Account: $formattedAccountId',
                                    style: GoogleFonts.spaceGrotesk(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[800],
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            SizedBox(height: 24.h),
                            
                            // QR Code with enhanced styling
                            Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white,
                                    Colors.grey[50]!,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: Colors.grey[200]!,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: QrImageView(
                                data: widget.accountId,
                                version: QrVersions.auto,
                                size: 220.w,
                                backgroundColor: Colors.white,
                                embeddedImage: AssetImage(AppConstants.gohbetochLogo),
                                embeddedImageStyle: const QrEmbeddedImageStyle(
                                  size: Size(45, 45),
                                ),
                                errorStateBuilder: (context, error) {
                                  return Center(
                                    child: Text(
                                      'Something went wrong',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        color: Colors.red,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            
                            SizedBox(height: 20.h),
                            
                            // Description with enhanced styling
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.07),
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.verified_rounded,
                                        size: 18.sp,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        'Secure Account QR Code',
                                        style: GoogleFonts.outfit(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Share this QR code to receive payments directly to your account securely',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.outfit(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      height: 1.3,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 32.h),
            
            // Action buttons with enhanced styling
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildEnhancedActionButton(
                    icon: Icons.share_rounded,
                    label: 'Share',
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Color(0xFF4A6FE5),
                      ],
                    ),
                    onTap: () {
                      // Share QR code functionality
                    },
                  ),
                  SizedBox(width: 20.w),
                  _buildEnhancedActionButton(
                    icon: Icons.save_alt_rounded,
                    label: 'Save',
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF2EC4B6),
                        Color(0xFF06D6A0),
                      ],
                    ),
                    onTap: () {
                      // Save QR code functionality
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEnhancedActionButton({
    required IconData icon,
    required String label,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 26.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
} 