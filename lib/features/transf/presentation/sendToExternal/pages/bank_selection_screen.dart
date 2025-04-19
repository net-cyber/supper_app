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
import 'package:super_app/features/transf/presentation/widget/bank_search_bar.dart';

class BankSelectionScreen extends StatelessWidget {
  const BankSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = getIt<FinancialInstitutionBloc>();
        // Fetch with bank-specific page size and immediately filter for banks only
        bloc.add(const FetchInstitutions(pageSize: FinancialInstitutionBloc.bankPageSize));
        bloc.add(const FilterByType(type: FinancialInstitutionType.bank));
        return bloc;
      },
      child: const _BankSelectionScreenContent(),
    );
  }
}

class _BankSelectionScreenContent extends StatefulWidget {
  const _BankSelectionScreenContent();

  @override
  State<_BankSelectionScreenContent> createState() =>
      _BankSelectionScreenContentState();
}

class _BankSelectionScreenContentState
    extends State<_BankSelectionScreenContent> {
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
      log('Auto-loading more banks as user is approaching the end');
      context.read<FinancialInstitutionBloc>().add(const LoadMoreInstitutions());
    }
  }

  void _onSearchChanged(String query) {
    context.read<FinancialInstitutionBloc>().add(
          SearchQueryChanged(query: query),
        );
  }

  void _selectBank(FinancialInstitution bank) {
    // Create the bank data in the format expected by the next screen
    final bankData = {
      'id': bank.id,
      'name': bank.name,
      'code': bank.code,
      'type': bank.type,
      'logo': bank.logoUrl ?? 'assets/images/banks/default.png',
      'color': Colors.blue[700]?.value, // Default color
      'selectedAt': DateTime.now().toIso8601String(),
      'isSelected': true,
    };
    
    // Navigate to the next screen
    context.pushNamed(RouteName.bankAccount, extra: bankData);
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
          'Select Bank',
          style: GoogleFonts.outfit(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search input
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: BankSearchBar(
              onSearch: _onSearchChanged,
              hintText: 'Search bank...',
            ),
          ),
          
          // Banks Grid
          Expanded(
            child: BlocBuilder<FinancialInstitutionBloc, FinancialInstitutionState>(
              builder: (context, state) {
                if (state.isLoading && state.filteredInstitutions.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16.h),
                        Text(
                          'Loading banks...',
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
                          Icons.account_balance_outlined,
                              size: 48.sp,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 16.h),
                            Text(
                          'No banks found',
                              style: GoogleFonts.outfit(
                                fontSize: 16.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                        if (state.searchQuery.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: TextButton(
                              onPressed: () => _onSearchChanged(''),
                              child: Text(
                                'Clear search',
                                style: GoogleFonts.outfit(
                                  fontSize: 14.sp,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  );
                }
                
                // Calculate number of rows needed (based on 2 items per row)
                final int totalItems = state.filteredInstitutions.length;
                final int loadingIndicator = state.isLoading && state.hasMorePages ? 1 : 0;
                final int displayRows = ((totalItems + loadingIndicator + 1) / 2).ceil(); // +1 ensures we have enough rows
                
                return GridView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.all(16.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Changed from 3 to 2 columns
                    childAspectRatio: 0.9, // Adjusted for better fit with 2 columns
                    crossAxisSpacing: 16.w, // Increased spacing between columns
                            mainAxisSpacing: 16.h,
                          ),
                  itemCount: state.filteredInstitutions.length + loadingIndicator,
                          itemBuilder: (context, index) {
                    // Show loading indicator as the last item
                    if (index == state.filteredInstitutions.length && loadingIndicator == 1) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    
                    final bank = state.filteredInstitutions[index];
                    
                    // Determine if logoUrl is already a network URL or needs assets path
                    final String logoPath = bank.logoUrl != null && 
                          (bank.logoUrl!.startsWith('http://') || 
                            bank.logoUrl!.startsWith('https://'))
                        ? bank.logoUrl!
                        : bank.logoUrl != null && bank.logoUrl!.isNotEmpty
                            ? bank.logoUrl!
                            : 'assets/images/banks/${bank.code.toLowerCase()}.png';
                    
                    return _buildBankItem(bank, logoPath);
                  },
                );
              },
                      ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBankItem(FinancialInstitution bank, String logoPath) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: () => _selectBank(bank),
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Bank logo
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: _buildLogoImage(logoPath, bank.name),
                ),
              ),
              
              SizedBox(height: 16.h),
              
              // Bank name
              Text(
                bank.name,
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
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
        width: 40.w,
        height: 40.h,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: 40.w,
            height: 40.h,
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
          log('Failed to load bank logo from network: $logoPath. Error: $error');
          return _buildInitials(name);
        },
      );
    } else if (isAssetImage) {
      return Image.asset(
        logoPath,
        width: 40.w,
        height: 40.h,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          log('Failed to load bank logo from assets: $logoPath. Error: $error');
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
      initials = 'B';
    }
    
    return Text(
      initials.toUpperCase(),
      style: GoogleFonts.outfit(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
