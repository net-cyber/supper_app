import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/transf/presentation/sendToExternal/widget/bank_data.dart';
import 'package:super_app/features/transf/presentation/sendToExternal/widget/bank_item.dart';
import 'package:super_app/features/transf/presentation/sendToExternal/widget/bank_search_bar.dart';

class BankSelectionScreen extends StatefulWidget {
  const BankSelectionScreen({super.key});

  @override
  State<BankSelectionScreen> createState() => _BankSelectionScreenState();
}

class _BankSelectionScreenState extends State<BankSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredBanks = [];
  
  @override
  void initState() {
    super.initState();
    filteredBanks = BankData.getBanks();
    _searchController.addListener(_filterBanks);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterBanks);
    _searchController.dispose();
    super.dispose();
  }

  void _filterBanks() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredBanks = BankData.getBanks();
      } else {
        filteredBanks = BankData.getBanks()
            .where((bank) => bank['name'].toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _selectBank(Map<String, dynamic> bank) {
    // Navigate to the next screen with the selected bank info
    context.pushNamed(RouteName.bankAccount, extra: bank);
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
          'Transfer to other bank',
          style: GoogleFonts.outfit(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search input
          BankSearchBar(controller: _searchController),
          
          // Title
          Padding(
            padding: EdgeInsets.only(left: 16.w, bottom: 16.h),
            child: Text(
              'Select a bank',
              style: GoogleFonts.outfit(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          
          // Bank grid
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                ),
                itemCount: filteredBanks.length,
                itemBuilder: (context, index) {
                  final bank = filteredBanks[index];
                  return BankItem(
                    bank: bank,
                    onTap: () => _selectBank(bank),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
} 