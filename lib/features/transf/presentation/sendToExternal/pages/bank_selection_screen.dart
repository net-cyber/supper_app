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
    Future.delayed(const Duration(milliseconds: 800), () {
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
        'color': Colors.blue[700]?.value,
        'swift': 'CBETETAA',
        'routing': '010010',
        'address': 'Addis Ababa, Ethiopia',
        'website': 'www.combanketh.et'
      },
      {
        'id': '2',
        'name': 'Dashen Bank',
        'code': 'DASHEN',
        'logo': 'assets/images/banks/dashen.png',
        'color': Colors.green[700]?.value,
        'swift': 'DASHETH',
        'routing': '020020',
        'address': 'Addis Ababa, Ethiopia',
        'website': 'www.dashenbanksc.com'
      },
      {
        'id': '3',
        'name': 'Awash Bank',
        'code': 'AWASH',
        'logo': 'assets/images/banks/awash.png',
        'color': Colors.orange[700]?.value,
        'swift': 'AWASHETH',
        'routing': '030030',
        'address': 'Addis Ababa, Ethiopia',
        'website': 'www.awashbank.com'
      },
      {
        'id': '4',
        'name': 'Abyssinia Bank',
        'code': 'ABYSSINIA',
        'logo': 'assets/images/banks/abyssinia.png',
        'color': Colors.purple[700]?.value,
        'swift': 'ABYSETH',
        'routing': '040040',
        'address': 'Addis Ababa, Ethiopia',
        'website': 'www.bankofabyssinia.com'
      },
      {
        'id': '5',
        'name': 'Wegagen Bank',
        'code': 'WEGAGEN',
        'logo': 'assets/images/banks/wegagen.png',
        'color': Colors.red[700]?.value,
        'swift': 'WEGAETH',
        'routing': '050050',
        'address': 'Addis Ababa, Ethiopia',
        'website': 'www.wegagen.com'
      },
      {
        'id': '6',
        'name': 'United Bank',
        'code': 'UNITED',
        'logo': 'assets/images/banks/united.png',
        'color': Colors.teal[700]?.value,
        'swift': 'UNTDETH',
        'routing': '060060',
        'address': 'Addis Ababa, Ethiopia',
        'website': 'www.unitedbank.com.et'
      },
      {
        'id': '7',
        'name': 'NIB Bank',
        'code': 'NIB',
        'logo': 'assets/images/banks/nib.png',
        'color': Colors.amber[700]?.value,
        'swift': 'NIBIETH',
        'routing': '070070',
        'address': 'Addis Ababa, Ethiopia',
        'website': 'www.nibbank.com'
      },
      {
        'id': '8',
        'name': 'Zemen Bank',
        'code': 'ZEMEN',
        'logo': 'assets/images/banks/zemen.png',
        'color': Colors.indigo[700]?.value,
        'swift': 'ZEMENET',
        'routing': '080080',
        'address': 'Addis Ababa, Ethiopia',
        'website': 'www.zemenbank.com'
      },
      {
        'id': '9',
        'name': 'Oromia Cooperative Bank',
        'code': 'OROMIA',
        'logo': 'assets/images/banks/oromia.png',
        'color': Colors.brown[700]?.value,
        'swift': 'OROIETH',
        'routing': '090090',
        'address': 'Addis Ababa, Ethiopia',
        'website': 'www.coopbankoromia.com.et'
      },
      {
        'id': '10',
        'name': 'Bunna Bank',
        'code': 'BUNNA',
        'logo': 'assets/images/banks/bunna.png',
        'color': Colors.brown[500]?.value,
        'swift': 'BUNAETH',
        'routing': '100100',
        'address': 'Addis Ababa, Ethiopia',
        'website': 'www.bunnabank.com.et'
      },
      {
        'id': '11',
        'name': 'Lion International Bank',
        'code': 'LION',
        'logo': 'assets/images/banks/lion.png',
        'color': Colors.amber[800]?.value,
        'swift': 'LIONETH',
        'routing': '110110',
        'address': 'Addis Ababa, Ethiopia',
        'website': 'www.anbesabank.com'
      },
      {
        'id': '12',
        'name': 'Enat Bank',
        'code': 'ENAT',
        'logo': 'assets/images/banks/enat.png',
        'color': Colors.pink[700]?.value,
        'swift': 'ENATETAA',
        'routing': '120120',
        'address': 'Addis Ababa, Ethiopia',
        'website': 'www.enatbanksc.com'
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
                (bank['name'] as String).toLowerCase().contains(query) ||
                (bank['code'] as String).toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _selectBank(Map<String, dynamic> bank) {
    // Add timestamp for analytics tracking
    final selectedBank = {
      ...bank,
      'selectedAt': DateTime.now().toIso8601String(),
      'isSelected': true,
    };
    
    // Navigate to the next screen
    context.pushNamed(RouteName.bankAccount, extra: selectedBank);
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

          // Title with bank count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select a bank',
                  style: GoogleFonts.outfit(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                if (!_isLoading)
                  Text(
                    '${filteredBanks.length} banks available',
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),

          // Error message if any
          if (_errorMessage != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.red[100]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 20.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: GoogleFonts.outfit(
                          fontSize: 14.sp,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Bank grid or loading indicator
          Expanded(
            child: _isLoading
                ? Center(
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
                  )
                : filteredBanks.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: 48.sp,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'No banks found matching "${_searchController.text}"',
                              style: GoogleFonts.outfit(
                                fontSize: 16.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 8.h),
                            TextButton(
                              onPressed: () {
                                _searchController.clear();
                                _filterBanks();
                              },
                              child: Text(
                                'Clear search',
                                style: GoogleFonts.outfit(
                                  fontSize: 14.sp,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
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
