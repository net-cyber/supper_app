import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/transf/application/financial_institution/bloc/financial_institution_bloc.dart';
import 'package:super_app/features/transf/domain/entities/financial_institution/financial_institution.dart';
import 'package:super_app/features/transf/presentation/widget/wallet_search_bar.dart';

class WalletSelectionScreen extends StatelessWidget {
  const WalletSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = getIt<FinancialInstitutionBloc>();
        // Fetch with wallet-specific page size and immediately filter for wallets only
        bloc.add(const FetchInstitutions(pageSize: FinancialInstitutionBloc.walletPageSize));
        bloc.add(const FilterByType(type: FinancialInstitutionType.wallet));
        return bloc;
      },
      child: const _WalletSelectionScreenContent(),
    );
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final state = context.read<FinancialInstitutionBloc>().state;
    
    // Load more when user scrolls to 80% of the list
    if (currentScroll >= maxScroll * 0.8 &&
        state.hasMorePages && 
        !state.isLoading) {
      log('Auto-loading more wallets as user is approaching the end');
      context.read<FinancialInstitutionBloc>().add(const LoadMoreInstitutions());
    }
  }

  void _onSearchChanged(String query) {
    context.read<FinancialInstitutionBloc>().add(
          SearchQueryChanged(query: query),
        );
  }

  void _selectWallet(FinancialInstitution wallet) {
    // Convert from FinancialInstitution to the format expected by next screen
    final walletData = {
      'id': wallet.id,
      'name': wallet.name,
      'code': wallet.code,
      'type': wallet.type,
      'logo': wallet.logoUrl ?? 'assets/images/wallets/default.png',
      'color': Colors.blue[700]?.value, // Default color
      'description': wallet.description ?? 'Mobile money service',
    };
    
    // Navigate to the wallet phone screen with the selected wallet provider
    context.pushNamed(RouteName.walletPhone, extra: walletData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Load To Wallet',
          style: GoogleFonts.outfit(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder<FinancialInstitutionBloc, FinancialInstitutionState>(
        builder: (context, state) {
          if (state.isLoading && state.filteredInstitutions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16.h),
                  Text(
                    'Loading wallets...',
                      style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          } else if (state.filteredInstitutions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 48.sp,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No wallets available',
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                    ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            itemCount: state.filteredInstitutions.length + (state.isLoading && state.hasMorePages ? 1 : 0),
            itemBuilder: (context, index) {
              // Show loading indicator at the end when loading more
              if (index == state.filteredInstitutions.length) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.h),
                    child: CircularProgressIndicator(),
            ),
    );
  }

              final wallet = state.filteredInstitutions[index];
              
              // Determine if logoUrl is already a network URL or needs assets path
              final String logoPath = wallet.logoUrl != null && 
                    (wallet.logoUrl!.startsWith('http://') || 
                      wallet.logoUrl!.startsWith('https://'))
                  ? wallet.logoUrl!
                  : wallet.logoUrl != null && wallet.logoUrl!.isNotEmpty
                      ? wallet.logoUrl!
                      : 'assets/images/wallets/${wallet.code.toLowerCase()}.png';
              
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
        child: InkWell(
                    onTap: () => _selectWallet(wallet),
                    borderRadius: BorderRadius.circular(8.r),
          child: Padding(
                      padding: EdgeInsets.all(16.h),
            child: Row(
              children: [
                          // Wallet logo
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    shape: BoxShape.circle,
                  ),
                            child: Center(
                              child: _buildLogoImage(logoPath, wallet.name),
                            ),
                ),
                          
                SizedBox(width: 16.w),
                          
                          // Wallet name
                Expanded(
                  child: Text(
                              wallet.name,
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                                color: Colors.black,
                    ),
                  ),
                ),
                          
                          // Chevron icon
                Icon(
                  Icons.chevron_right,
                            color: Colors.grey[600],
                  size: 24.sp,
                ),
              ],
            ),
          ),
        ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLogoImage(String logoPath, String name) {
    // Check if logo is a URL (starts with http:// or https://)
    final isNetworkImage = logoPath.startsWith('http://') || logoPath.startsWith('https://');
    final isAssetImage = logoPath.startsWith('assets/');
    
    if (isNetworkImage) {
      return Image.network(
        logoPath,
        width: 30.w,
        height: 30.h,
            fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: 30.w,
            height: 30.h,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / 
                      loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          log('Failed to load wallet logo from network: $logoPath. Error: $error');
          return _buildInitials(name);
        },
      );
    } else if (isAssetImage) {
      return Image.asset(
        logoPath,
        width: 30.w,
        height: 30.h,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          log('Failed to load wallet logo from assets: $logoPath. Error: $error');
          return _buildInitials(name);
        },
      );
    } else {
      return _buildInitials(name);
    }
  }
  
  Widget _buildInitials(String name) {
    String initials = '';
    final nameParts = name.trim().split(' ');
    if (nameParts.length > 1 && nameParts[0].isNotEmpty && nameParts[1].isNotEmpty) {
      initials = '${nameParts[0][0]}${nameParts[1][0]}';
    } else if (nameParts.isNotEmpty && nameParts[0].isNotEmpty) {
      initials = nameParts[0].length > 1 
          ? nameParts[0].substring(0, 2) 
          : nameParts[0][0];
    } else {
      initials = 'W';
    }
    
    return Text(
      initials.toUpperCase(),
        style: GoogleFonts.outfit(
        fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
