import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';

class WalletSelectionScreen extends StatelessWidget {
  const WalletSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _WalletSelectionScreenContent();
  }
}

class _WalletSelectionScreenContent extends StatefulWidget {
  const _WalletSelectionScreenContent();

  @override
  State<_WalletSelectionScreenContent> createState() =>
      _WalletSelectionScreenContentState();
}

class _WalletSelectionScreenContentState
    extends State<_WalletSelectionScreenContent> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _providers = [];
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadWalletProviders();
  }

  void _loadWalletProviders() {
    // Simulate API call delay
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _providers = _getMockWalletProviders();
      });
    });
  }

  List<Map<String, dynamic>> _getMockWalletProviders() {
    return [
      {
        'id': '1',
        'name': 'Telebirr',
        'code': 'TELEBIRR',
        'imagePath': 'assets/images/wallets/telebirr.png',
      },
      {
        'id': '2',
        'name': 'Amole',
        'code': 'AMOLE',
        'imagePath': 'assets/images/wallets/amole.png',
      },
      {
        'id': '3',
        'name': 'HelloCash',
        'code': 'HELLOCASH',
        'imagePath': 'assets/images/wallets/hellocash.png',
      },
      {
        'id': '4',
        'name': 'E-Birr',
        'code': 'EBIRR',
        'imagePath': 'assets/images/wallets/ebirr.png',
      },
    ];
  }

  void _handleWalletSelection(Map<String, dynamic> provider) {
    // Navigate to the next screen with provider data
    context.pushNamed(RouteName.walletPhone, extra: provider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Load To Wallet',
          style: GoogleFonts.outfit(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Text(
                      'Select Wallet Provider',
                      style: GoogleFonts.outfit(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  // Show error message if any
                  if (_errorMessage != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        _errorMessage!,
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          color: Colors.red,
                        ),
                      ),
                    ),

                  if (_providers.isEmpty)
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 32.h),
                        child: Text(
                          'No wallet providers available',
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _providers.length,
                      itemBuilder: (context, index) {
                        final provider = _providers[index];
                        return _buildWalletOption(
                          context,
                          provider['name'] as String,
                          provider['imagePath'] as String? ?? '',
                          () => _handleWalletSelection(provider),
                        );
                      },
                    ),
                ],
              ),
            ),
    );
  }

  Widget _buildWalletOption(
    BuildContext context,
    String name,
    String imagePath,
    VoidCallback onTap,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Circular logo container
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    shape: BoxShape.circle,
                  ),
                  child: _buildWalletLogo(imagePath, name),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Text(
                    name,
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                  size: 24.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWalletLogo(String imagePath, String fallbackText) {
    // Try to use an image if available, otherwise use placeholder
    if (imagePath.isNotEmpty) {
      try {
        return Center(
          child: Image.asset(
            imagePath,
            width: 40.w,
            height: 40.w,
            fit: BoxFit.contain,
          ),
        );
      } catch (_) {
        // Fallback to text if image loading fails
      }
    }

    // Text placeholder
    return Center(
      child: Text(
        fallbackText.substring(0, 1).toUpperCase(),
        style: GoogleFonts.outfit(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: Colors.blue[700],
        ),
      ),
    );
  }
}
