import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/di/injection.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/transf/application/external_transfer/external_transfer_bloc.dart';
import 'package:super_app/features/transf/application/external_transfer/external_transfer_event.dart';
import 'package:super_app/features/transf/application/external_transfer/external_transfer_state.dart';
import 'package:super_app/features/transf/presentation/widget/bank_search_bar.dart';
import 'package:super_app/features/transf/presentation/widget/bank_item.dart';

class BankSelectionScreen extends StatelessWidget {
  const BankSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => inject<ExternalTransferBloc>()
        ..add(const ExternalTransferEvent.loadBanks()),
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
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredBanks = [];

  @override
  void initState() {
    super.initState();
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
    final state = context.read<ExternalTransferBloc>().state;

    setState(() {
      if (query.isEmpty) {
        filteredBanks = state.banks;
      } else {
        filteredBanks = state.banks
            .where((bank) =>
                (bank['name'] as String).toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _selectBank(Map<String, dynamic> bank) {
    // Dispatch event to BLoC
    context.read<ExternalTransferBloc>().add(
          ExternalTransferEvent.bankSelected(bank),
        );

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
      body: BlocConsumer<ExternalTransferBloc, ExternalTransferState>(
        listener: (context, state) {
          // Handle state changes that require UI feedback
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }

          // Initialize filtered banks when banks are loaded
          if (state.status == ExternalTransferStatus.banksLoaded) {
            setState(() {
              filteredBanks = state.banks;
            });
          }
        },
        builder: (context, state) {
          return Column(
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

              // Bank grid or loading indicator
              Expanded(
                child: state.isLoading
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
          );
        },
      ),
    );
  }
}
