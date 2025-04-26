import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_app/features/history/application/transactions_bloc.dart';
import 'package:super_app/features/history/domain/entities/transaction_filter/transaction_filter.dart';
import 'package:super_app/features/history/domain/entities/transaction_type.dart';

class TransactionFilterDialog extends StatefulWidget {
  final TransactionFilter? initialFilter;
  final bool showFilterPreservationOption;

  const TransactionFilterDialog({
    Key? key,
    this.initialFilter,
    this.showFilterPreservationOption = false,
  }) : super(key: key);

  @override
  State<TransactionFilterDialog> createState() => _TransactionFilterDialogState();
}

class _TransactionFilterDialogState extends State<TransactionFilterDialog> {
  late TransactionFilter _filter;
  
  final _counterpartyController = TextEditingController();
  final _minAmountController = TextEditingController();
  final _maxAmountController = TextEditingController();
  
  DateTime? _startDate;
  DateTime? _endDate;
  bool _preserveFilters = false;
  
  final DateFormat _dateFormat = DateFormat('MMM dd, yyyy');
  static const String _preserveFiltersKey = 'preserve_transaction_filters';
  static const String _lastFilterKey = 'last_transaction_filter';
  
  @override
  void initState() {
    super.initState();
    
    _filter = widget.initialFilter ?? TransactionFilter();
    
    _startDate = _filter.startDate;
    _endDate = _filter.endDate;
    
    // Load the preserve filters setting
    _loadPreserveFiltersSetting();
    
    if (_filter.counterpartyName != null) {
      _counterpartyController.text = _filter.counterpartyName!;
    }
    
    if (_filter.minAmount != null) {
      _minAmountController.text = _filter.minAmount.toString();
    }
    
    if (_filter.maxAmount != null) {
      _maxAmountController.text = _filter.maxAmount.toString();
    }
  }
  
  Future<void> _loadPreserveFiltersSetting() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _preserveFilters = prefs.getBool(_preserveFiltersKey) ?? false;
      });
    } catch (e) {
      // Fallback to default in case of error
      _preserveFilters = false;
    }
  }
  
  Future<void> _savePreserveFiltersSetting(bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_preserveFiltersKey, value);
      _preserveFilters = value;
    } catch (e) {
      // Handle error silently
    }
  }
  
  // Used to save the last applied filter to SharedPreferences
  Future<void> _saveLastAppliedFilter(TransactionFilter filter) async {
    if (!_preserveFilters) return; // Only save if preserving filters
    
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Create a simple map representation of the filter
      final filterMap = {
        'type': filter.type?.value,
        'direction': filter.direction?.value,
        'status': filter.status?.value,
        'startDate': filter.startDate?.millisecondsSinceEpoch,
        'endDate': filter.endDate?.millisecondsSinceEpoch,
        'counterpartyName': filter.counterpartyName,
        'minAmount': filter.minAmount,
        'maxAmount': filter.maxAmount,
      };
      
      // Save as a properly encoded JSON string
      await prefs.setString(_lastFilterKey, jsonEncode(filterMap));
    } catch (e) {
      // Handle error silently
    }
  }
  
  @override
  void dispose() {
    _counterpartyController.dispose();
    _minAmountController.dispose();
    _maxAmountController.dispose();
    super.dispose();
  }
  
  void _applyFilters() {
    TransactionFilter updatedFilter = _filter.copyWith(
      startDate: _startDate,
      endDate: _endDate,
      counterpartyName: _counterpartyController.text.isEmpty 
          ? null 
          : _counterpartyController.text,
      minAmount: _minAmountController.text.isEmpty 
          ? null 
          : double.tryParse(_minAmountController.text),
      maxAmount: _maxAmountController.text.isEmpty 
          ? null 
          : double.tryParse(_maxAmountController.text),
    );
    
    try {
      // Use the BlocProvider to access the bloc
      final transactionsBloc = context.read<TransactionsBloc>();
      
      // Save the filter preservation preference
      if (widget.showFilterPreservationOption) {
        _savePreserveFiltersSetting(_preserveFilters);
        
        // Also save the current filter if preservation is enabled
        if (_preserveFilters) {
          _saveLastAppliedFilter(updatedFilter);
        }
      }
      
      // Try to add the event - we'll catch any exceptions
      transactionsBloc.add(
        TransactionsEvent.filtered(filter: updatedFilter)
      );
      
      Navigator.of(context).pop();
    } catch (e) {
      // Handle any errors that occur when trying to access or use the bloc
      Navigator.of(context).pop();
      
      // Show a dialog with more information about what happened
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Filter Error',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Unable to apply filters. The transaction history page may need to be refreshed.',
                style: GoogleFonts.outfit(fontSize: 14.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                'Error details: ${e.toString()}',
                style: GoogleFonts.outfit(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  void _resetFilters() {
    setState(() {
      _filter = TransactionFilter();
      _startDate = null;
      _endDate = null;
      _counterpartyController.clear();
      _minAmountController.clear();
      _maxAmountController.clear();
    });
  }
  
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }
  
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      elevation: 8,
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: DefaultTabController(
        length: 3,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.white,
          ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
              // Header with gradient background
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryColor.withOpacity(0.1),
                      primaryColor.withOpacity(0.02),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.filter_list_rounded,
                          color: primaryColor,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Transaction Filters',
                          style: GoogleFonts.outfit(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Container(
                        padding: EdgeInsets.all(2.r),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.grey[700],
                          size: 14.sp,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
              
              // Tab Bar
              TabBar(
                labelColor: primaryColor,
                unselectedLabelColor: Colors.grey[600],
                indicatorColor: primaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(
                    icon: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.category_rounded, size: 16.sp),
                        SizedBox(width: 4.w),
                        Text('Type', style: GoogleFonts.outfit(fontSize: 12.sp)),
                      ],
                    ),
                  ),
                  Tab(
                    icon: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_today_rounded, size: 16.sp),
                        SizedBox(width: 4.w),
                        Text('Date', style: GoogleFonts.outfit(fontSize: 12.sp)),
                      ],
                    ),
                  ),
                  Tab(
                    icon: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.monetization_on_rounded, size: 16.sp),
                        SizedBox(width: 4.w),
                        Text('Other', style: GoogleFonts.outfit(fontSize: 12.sp)),
                      ],
                    ),
                  ),
                ],
              ),
              
              SizedBox(
                height: 300.h, // Fixed height to avoid scrolling
                child: TabBarView(
                  children: [
                    // First tab - Type filters
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Transaction type section
                            _buildCompactSection(
                              title: 'Transaction Type',
                              iconData: Icons.category_rounded,
                              child: Wrap(
                                spacing: 6.w,
                                runSpacing: 6.h,
                                children: [
                                  _buildCompactChip(
                          label: 'All',
                                    isSelected: _filter.type == null,
                                    onSelected: (selected) {
                                      if (selected) {
                                        setState(() {
                                          _filter = _filter.copyWith(type: null);
                                        });
                                      }
                                    },
                                  ),
                                  _buildCompactChip(
                                    label: 'External',
                                    isSelected: _filter.type?.value == 'external_transfer',
                                    onSelected: (selected) {
                                      setState(() {
                                        _filter = _filter.copyWith(
                                          type: selected 
                                              ? TransactionType.externalTransfer
                                              : null
                                        );
                                      });
                                    },
                        ),
                                  _buildCompactChip(
                                    label: 'Internal',
                                    isSelected: _filter.type?.value == 'internal_transfer',
                                    onSelected: (selected) {
                                      setState(() {
                                        _filter = _filter.copyWith(
                                          type: selected 
                                              ? TransactionType.internalTransfer
                                              : null
                                        );
                                      });
                                    },
                                  ),
                                  _buildCompactChip(
                                    label: 'Top-up',
                                    isSelected: _filter.type?.value == 'topup',
                                    onSelected: (selected) {
                                      setState(() {
                                        _filter = _filter.copyWith(
                                          type: selected 
                                              ? TransactionType.topUp
                                              : null
                                        );
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            
                            // Direction section
                            _buildCompactSection(
                              title: 'Direction',
                              iconData: Icons.sync_alt_rounded,
                              child: Wrap(
                                spacing: 6.w,
                                runSpacing: 6.h,
                                children: [
                                  _buildCompactChip(
                                    label: 'All',
                                    isSelected: _filter.direction == null,
                                    onSelected: (selected) {
                                      if (selected) {
                                        setState(() {
                                          _filter = _filter.copyWith(direction: null);
                                        });
                                      }
                                    },
                                  ),
                                  _buildCompactChip(
                                    label: 'In',
                                    icon: Icons.arrow_downward_rounded,
                                    isSelected: _filter.direction?.value == 'incoming',
                                    onSelected: (selected) {
                                      setState(() {
                                        _filter = _filter.copyWith(
                                          direction: selected 
                                              ? TransactionDirection.incoming
                                              : null
                                        );
                                      });
                                    },
                                  ),
                                  _buildCompactChip(
                                    label: 'Out',
                                    icon: Icons.arrow_upward_rounded,
                                    isSelected: _filter.direction?.value == 'outgoing',
                                    onSelected: (selected) {
                                      setState(() {
                                        _filter = _filter.copyWith(
                                          direction: selected 
                                              ? TransactionDirection.outgoing
                                              : null
                                        );
                                      });
                                    },
                        ),
                      ],
                    ),
                            ),
                            SizedBox(height: 10.h),
                    
                            // Status section
                            _buildCompactSection(
                              title: 'Status',
                              iconData: Icons.check_circle_outline_rounded,
                              child: Wrap(
                                spacing: 6.w,
                                runSpacing: 6.h,
                      children: [
                                  _buildCompactChip(
                          label: 'All',
                                    isSelected: _filter.status == null,
                                    onSelected: (selected) {
                                      if (selected) {
                                        setState(() {
                                          _filter = _filter.copyWith(status: null);
                                        });
                                      }
                                    },
                        ),
                                  _buildCompactChip(
                                    label: 'Done',
                                    icon: Icons.check_circle_rounded,
                                    iconColor: Colors.green,
                                    isSelected: _filter.status?.value == 'completed',
                                    onSelected: (selected) {
                                      setState(() {
                                        _filter = _filter.copyWith(
                                          status: selected 
                                              ? TransactionStatus.completed
                                              : null
                                        );
                                      });
                                    },
                        ),
                                  _buildCompactChip(
                          label: 'Pending',
                                    icon: Icons.pending_rounded,
                                    iconColor: Colors.orange,
                                    isSelected: _filter.status?.value == 'pending',
                                    onSelected: (selected) {
                                      setState(() {
                                        _filter = _filter.copyWith(
                                          status: selected 
                                              ? TransactionStatus.pending
                                              : null
                                        );
                                      });
                                    },
                        ),
                                  _buildCompactChip(
                          label: 'Failed',
                                    icon: Icons.error_rounded,
                                    iconColor: Colors.red,
                                    isSelected: _filter.status?.value == 'failed',
                                    onSelected: (selected) {
                                      setState(() {
                                        _filter = _filter.copyWith(
                                          status: selected 
                                              ? TransactionStatus.failed
                                              : null
                                        );
                                      });
                                    },
                        ),
                      ],
                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Second tab - Date range
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCompactSection(
                              title: 'Date Range',
                              iconData: Icons.calendar_today_rounded,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                                  InkWell(
                                    onTap: () => _selectStartDate(context),
                                    borderRadius: BorderRadius.circular(12.r),
                            child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                        border: Border.all(color: primaryColor.withOpacity(0.2)),
                                        borderRadius: BorderRadius.circular(12.r),
                                        color: primaryColor.withOpacity(0.05),
                          ),
                              child: Row(
                                children: [
                                  Icon(
                                            Icons.calendar_month_rounded,
                                    size: 18.sp,
                                            color: primaryColor.withOpacity(0.7),
                        ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'From',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 12.sp,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                SizedBox(height: 2.h),
                                                Text(
                                      _startDate != null 
                                          ? _dateFormat.format(_startDate!) 
                                                      : 'Select start date',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                                    fontWeight: _startDate != null ? FontWeight.w500 : FontWeight.normal,
                                                    color: _startDate != null ? Colors.black : Colors.grey[600],
                            ),
                                                  maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                          ),
                                              ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                                  SizedBox(height: 10.h),
                                  InkWell(
                                    onTap: () => _selectEndDate(context),
                                    borderRadius: BorderRadius.circular(12.r),
                            child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                        border: Border.all(color: primaryColor.withOpacity(0.2)),
                                        borderRadius: BorderRadius.circular(12.r),
                                        color: primaryColor.withOpacity(0.05),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                            Icons.calendar_month_rounded,
                                    size: 18.sp,
                                            color: primaryColor.withOpacity(0.7),
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'To',
                                                  style: GoogleFonts.outfit(
                                                    fontSize: 12.sp,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                SizedBox(height: 2.h),
                                                Text(
                                      _endDate != null 
                                          ? _dateFormat.format(_endDate!) 
                                                      : 'Select end date',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                                    fontWeight: _endDate != null ? FontWeight.w500 : FontWeight.normal,
                                                    color: _endDate != null ? Colors.black : Colors.grey[600],
                                      ),
                                                  maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (_startDate != null && _endDate != null && _startDate!.isAfter(_endDate!))
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.h),
                                      child: Text(
                                        'Start date should be before end date',
                                        style: GoogleFonts.outfit(
                                          fontSize: 12.sp,
                                          color: Colors.red[700],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Third tab - Amount and Others
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Amount range section
                            _buildCompactSection(
                              title: 'Amount Range',
                              iconData: Icons.monetization_on_rounded,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 40.h,
                                          child: TextField(
                                            controller: _minAmountController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: 'Min',
                                              prefixIcon: Icon(Icons.remove_rounded, color: primaryColor.withOpacity(0.7), size: 18.sp),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12.r),
                                                borderSide: BorderSide(color: primaryColor.withOpacity(0.2)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12.r),
                                                borderSide: BorderSide(color: primaryColor.withOpacity(0.2)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12.r),
                                                borderSide: BorderSide(color: primaryColor, width: 1.5),
                                              ),
                                              contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                              filled: true,
                                              fillColor: primaryColor.withOpacity(0.05),
                                            ),
                                            style: GoogleFonts.outfit(fontSize: 14.sp),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Container(
                                          height: 40.h,
                                          child: TextField(
                                            controller: _maxAmountController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: 'Max',
                                              prefixIcon: Icon(Icons.add_rounded, color: primaryColor.withOpacity(0.7), size: 18.sp),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12.r),
                                                borderSide: BorderSide(color: primaryColor.withOpacity(0.2)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12.r),
                                                borderSide: BorderSide(color: primaryColor.withOpacity(0.2)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12.r),
                                                borderSide: BorderSide(color: primaryColor, width: 1.5),
                                              ),
                                              contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                              filled: true,
                                              fillColor: primaryColor.withOpacity(0.05),
                                            ),
                                            style: GoogleFonts.outfit(fontSize: 14.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                                ],
                              ),
                            ),
                    SizedBox(height: 16.h),
                    
                            // Counterparty name section
                            _buildCompactSection(
                              title: 'Counterparty',
                              iconData: Icons.person_rounded,
                              child: Container(
                                height: 40.h,
                                child: TextField(
                      controller: _counterpartyController,
                      decoration: InputDecoration(
                      hintText: 'Search by name',
                                    prefixIcon: Icon(Icons.search_rounded, color: primaryColor.withOpacity(0.7), size: 18.sp),
                        border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(color: primaryColor.withOpacity(0.2)),
                        ),
                        enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(color: primaryColor.withOpacity(0.2)),
                        ),
                        focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(color: primaryColor, width: 1.5),
                        ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                    filled: true,
                                    fillColor: primaryColor.withOpacity(0.05),
                                  ),
                                  style: GoogleFonts.outfit(fontSize: 14.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Footer with buttons
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  border: Border(
                    top: BorderSide(color: Colors.grey[200]!),
                                ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.showFilterPreservationOption)
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 18.h,
                              width: 18.w,
                              child: Checkbox(
                                value: _preserveFilters,
                                onChanged: (value) {
                                  setState(() {
                                    _preserveFilters = value ?? false;
                                    _savePreserveFiltersSetting(_preserveFilters);
                                  });
                                },
                                activeColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'Remember these filters',
                                style: GoogleFonts.outfit(
                                  fontSize: 12.sp,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _resetFilters,
                            icon: Icon(Icons.refresh_rounded, size: 16.sp),
                            label: Text('Reset'),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              side: BorderSide(color: primaryColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              foregroundColor: primaryColor,
                              ),
                            ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _applyFilters,
                            icon: Icon(Icons.check_rounded, size: 16.sp),
                            label: Text('Apply'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
  
  Widget _buildCompactSection({
    required String title,
    required IconData iconData,
    required Widget child,
  }) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              iconData,
              size: 16.sp,
              color: primaryColor,
            ),
            SizedBox(width: 6.w),
            Text(
          title,
          style: GoogleFonts.outfit(
          fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
          ],
        ),
        SizedBox(height: 8.h),
        child,
      ],
    );
  }
  
  Widget _buildCompactChip({
    required String label, 
    required bool isSelected,
    required Function(bool) onSelected,
    IconData? icon,
    Color? iconColor,
  }) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 14.sp,
              color: isSelected ? Colors.white : (iconColor ?? Colors.grey[700]),
            ),
            SizedBox(width: 4.w),
          ],
          Text(
            label,
            style: GoogleFonts.outfit(
          fontSize: 12.sp,
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: onSelected,
      backgroundColor: Colors.grey[100],
      selectedColor: primaryColor,
      checkmarkColor: Colors.white,
      showCheckmark: false,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(
          color: isSelected ? primaryColor : Colors.grey[300]!,
          width: 1,
        ),
      ),
      elevation: isSelected ? 1 : 0,
      pressElevation: 2,
    );
  }
}