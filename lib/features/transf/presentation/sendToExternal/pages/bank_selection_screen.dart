import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/transf/presentation/widget/bank_search_bar.dart';
import 'package:super_app/features/transf/presentation/widget/bank_item.dart';

class BankSelectionScreen extends StatelessWidget {
  const BankSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _BankSelectionScreenContent();
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
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> allBanks = [];
  List<Map<String, dynamic>> filteredBanks = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterBanks);
    _loadBanks();
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterBanks);
    _searchController.dispose();
    super.dispose();
  }

  void _loadBanks() {
    // Simulating API call to load banks
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        allBanks = _getMockBanks();
        filteredBanks = List.from(allBanks);
      });
    });
  }

  List<Map<String, dynamic>> _getMockBanks() {
    return [
      {
        'id': '1',
        'name': 'Commercial Bank of Ethiopia',
        'code': 'CBE',
        'logo': 'assets/images/banks/cbe.png',
        'color': Colors.blue[700]?.value
      },
      {
        'id': '2',
        'name': 'Dashen Bank',
        'code': 'DASHEN',
        'logo': 'assets/images/banks/dashen.png',
        'color': Colors.green[700]?.value
      },
      {
        'id': '3',
        'name': 'Awash Bank',
        'code': 'AWASH',
        'logo': 'assets/images/banks/awash.png',
        'color': Colors.orange[700]?.value
      },
      {
        'id': '4',
        'name': 'Abyssinia Bank',
        'code': 'ABYSSINIA',
        'logo': 'assets/images/banks/abyssinia.png',
        'color': Colors.purple[700]?.value
      },
      {
        'id': '5',
        'name': 'Wegagen Bank',
        'code': 'WEGAGEN',
        'logo': 'assets/images/banks/wegagen.png',
        'color': Colors.red[700]?.value
      },
      {
        'id': '6',
        'name': 'United Bank',
        'code': 'UNITED',
        'logo': 'assets/images/banks/united.png',
        'color': Colors.teal[700]?.value
      },
      {
        'id': '7',
        'name': 'NIB Bank',
        'code': 'NIB',
        'logo': 'assets/images/banks/nib.png',
        'color': Colors.amber[700]?.value
      },
      {
        'id': '8',
        'name': 'Zemen Bank',
        'code': 'ZEMEN',
        'logo': 'assets/images/banks/zemen.png',
        'color': Colors.indigo[700]?.value
      },
      {
        'id': '9',
        'name': 'Oromia Cooperative Bank',
        'code': 'OROMIA',
        'logo': 'assets/images/banks/oromia.png',
        'color': Colors.brown[700]?.value
      },
    ];
  }

  void _filterBanks() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredBanks = List.from(allBanks);
      } else {
        filteredBanks = allBanks
            .where((bank) =>
                (bank['name'] as String).toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _selectBank(Map<String, dynamic> bank) {
    // Navigate to the next screen
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

          // Error message if any
          if (_errorMessage != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Text(
                _errorMessage!,
                style: GoogleFonts.outfit(
                  fontSize: 14.sp,
                  color: Colors.red,
                ),
              ),
            ),

          // Bank grid or loading indicator
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredBanks.isEmpty
                    ? Center(
                        child: Text(
                          'No banks found',
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
