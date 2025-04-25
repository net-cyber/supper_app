import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:super_app/features/history/application/transactions_bloc.dart';
import 'package:super_app/features/history/domain/entities/transaction_filter/transaction_filter.dart';
import 'package:super_app/features/history/domain/entities/transaction_type.dart';

class TransactionFilterDialog extends StatefulWidget {
  final TransactionFilter? initialFilter;

  const TransactionFilterDialog({
    Key? key,
    this.initialFilter,
  }) : super(key: key);

  @override
  State<TransactionFilterDialog> createState() => _TransactionFilterDialogState();
}

class _TransactionFilterDialogState extends State<TransactionFilterDialog> {
  late TransactionType? _selectedType;
  late TransactionDirection? _selectedDirection;
  late TransactionStatus? _selectedStatus;
  late DateTime? _startDate;
  late DateTime? _endDate;
  late TextEditingController _counterpartyController;
  late TextEditingController _minAmountController;
  late TextEditingController _maxAmountController;
  
  final DateFormat _dateFormat = DateFormat('MMM dd, yyyy');
  
  @override
  void initState() {
    super.initState();
    
    // Initialize with existing filter values if available
    _selectedType = widget.initialFilter?.type;
    _selectedDirection = widget.initialFilter?.direction;
    _selectedStatus = widget.initialFilter?.status;
    _startDate = widget.initialFilter?.startDate;
    _endDate = widget.initialFilter?.endDate;
    
    _counterpartyController = TextEditingController(
      text: widget.initialFilter?.counterpartyName ?? '',
    );
    
    _minAmountController = TextEditingController(
      text: widget.initialFilter?.minAmount?.toString() ?? '',
    );
    
    _maxAmountController = TextEditingController(
      text: widget.initialFilter?.maxAmount?.toString() ?? '',
    );
  }
  
  @override
  void dispose() {
    _counterpartyController.dispose();
    _minAmountController.dispose();
    _maxAmountController.dispose();
    super.dispose();
  }

  void _resetFilters() {
    setState(() {
      _selectedType = null;
      _selectedDirection = null;
      _selectedStatus = null;
      _startDate = null;
      _endDate = null;
      _counterpartyController.clear();
      _minAmountController.clear();
      _maxAmountController.clear();
    });
  }
  
  void _applyFilters() {
    // Parse amount inputs
    double? minAmount;
    double? maxAmount;
    
    if (_minAmountController.text.isNotEmpty) {
      try {
        minAmount = double.parse(_minAmountController.text.trim());
      } catch (_) {}
    }
    
    if (_maxAmountController.text.isNotEmpty) {
      try {
        maxAmount = double.parse(_maxAmountController.text.trim());
      } catch (_) {}
    }
    
    // Create filter
    final filter = TransactionFilter(
      type: _selectedType,
      direction: _selectedDirection,
      status: _selectedStatus,
      startDate: _startDate,
      endDate: _endDate,
      counterpartyName: _counterpartyController.text.isNotEmpty 
          ? _counterpartyController.text.trim() 
          : null,
      minAmount: minAmount,
      maxAmount: maxAmount,
    );
    
    // Apply filter using BLoC
    context.read<TransactionsBloc>().add(
      TransactionsEvent.filtered(filter: filter),
    );
    
    Navigator.of(context).pop();
  }
  
  Future<void> _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        _startDate = picked;
        // If end date is before start date, reset it
        if (_endDate != null && _endDate!.isBefore(_startDate!)) {
          _endDate = null;
        }
      });
    }
  }
  
  Future<void> _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
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
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Filter Transactions',
                    style: GoogleFonts.outfit(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            
            SizedBox(height: 8.h),
            
            // Filters in a scrollable container
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Transaction Type filter
                    _buildSectionTitle('Transaction Type'),
                    Wrap(
                      spacing: 8.w,
                      children: [
                        _buildFilterChip(
                          label: 'All',
                          selected: _selectedType == null,
                          onSelected: (_) => setState(() => _selectedType = null),
                        ),
                        _buildFilterChip(
                          label: 'External Transfer',
                          selected: _selectedType == TransactionType.externalTransfer,
                          onSelected: (_) => setState(() => _selectedType = TransactionType.externalTransfer),
                        ),
                        _buildFilterChip(
                          label: 'Internal Transfer',
                          selected: _selectedType == TransactionType.internalTransfer,
                          onSelected: (_) => setState(() => _selectedType = TransactionType.internalTransfer),
                        ),
                        _buildFilterChip(
                          label: 'Top-up',
                          selected: _selectedType == TransactionType.topUp,
                          onSelected: (_) => setState(() => _selectedType = TransactionType.topUp),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    // Direction filter
                    _buildSectionTitle('Direction'),
                    Wrap(
                      spacing: 8.w,
                      children: [
                        _buildFilterChip(
                          label: 'All',
                          selected: _selectedDirection == null,
                          onSelected: (_) => setState(() => _selectedDirection = null),
                        ),
                        _buildFilterChip(
                          label: 'Incoming',
                          selected: _selectedDirection == TransactionDirection.incoming,
                          onSelected: (_) => setState(() => _selectedDirection = TransactionDirection.incoming),
                        ),
                        _buildFilterChip(
                          label: 'Outgoing',
                          selected: _selectedDirection == TransactionDirection.outgoing,
                          onSelected: (_) => setState(() => _selectedDirection = TransactionDirection.outgoing),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    // Status filter
                    _buildSectionTitle('Status'),
                    Wrap(
                      spacing: 8.w,
                      children: [
                        _buildFilterChip(
                          label: 'All',
                          selected: _selectedStatus == null,
                          onSelected: (_) => setState(() => _selectedStatus = null),
                        ),
                        _buildFilterChip(
                          label: 'Completed',
                          selected: _selectedStatus == TransactionStatus.completed,
                          onSelected: (_) => setState(() => _selectedStatus = TransactionStatus.completed),
                        ),
                        _buildFilterChip(
                          label: 'Pending',
                          selected: _selectedStatus == TransactionStatus.pending,
                          onSelected: (_) => setState(() => _selectedStatus = TransactionStatus.pending),
                        ),
                        _buildFilterChip(
                          label: 'Failed',
                          selected: _selectedStatus == TransactionStatus.failed,
                          onSelected: (_) => setState(() => _selectedStatus = TransactionStatus.failed),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    // Date Range
                    _buildSectionTitle('Date Range'),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: _selectStartDate,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(8.r),
                          ),
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 18.sp,
                                    color: primaryColor,
                        ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                          child: Text(
                                      _startDate != null 
                                          ? _dateFormat.format(_startDate!) 
                                          : 'Start Date',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        color: _startDate != null 
                                            ? Colors.black 
                                            : Colors.grey[600],
                            ),
                                      overflow: TextOverflow.ellipsis,
                          ),
                        ),
                                  if (_startDate != null)
                                    InkWell(
                                      onTap: () => setState(() => _startDate = null),
                                      child: Icon(
                                        Icons.clear,
                                        size: 16.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(width: 8.w),
                        
                        Expanded(
                          child: InkWell(
                            onTap: _selectEndDate,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 18.sp,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Text(
                                      _endDate != null 
                                          ? _dateFormat.format(_endDate!) 
                                          : 'End Date',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14.sp,
                                        color: _endDate != null 
                                            ? Colors.black 
                                            : Colors.grey[600],
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (_endDate != null)
                                    InkWell(
                                      onTap: () => setState(() => _endDate = null),
                                      child: Icon(
                                        Icons.clear,
                                        size: 16.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    // Counterparty Name filter
                    _buildSectionTitle('Counterparty'),
                    TextFormField(
                      controller: _counterpartyController,
                      decoration: InputDecoration(
                      hintText: 'Search by name',
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: primaryColor),
                        ),
                        suffixIcon: _counterpartyController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  size: 16.sp,
                                  color: Colors.grey[600],
                                ),
                                onPressed: () => setState(() => _counterpartyController.clear()),
                              )
                          : null,
                    ),
                      style: GoogleFonts.outfit(fontSize: 14.sp),
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    // Amount Range
                    _buildSectionTitle('Amount Range'),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _minAmountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Min',
                              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(color: primaryColor),
                              ),
                            ),
                            style: GoogleFonts.outfit(fontSize: 14.sp),
                          ),
                        ),
                        
                        SizedBox(width: 8.w),
                        
                        Expanded(
                          child: TextFormField(
                            controller: _maxAmountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Max',
                              contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(color: primaryColor),
                              ),
                            ),
                            style: GoogleFonts.outfit(fontSize: 14.sp),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 24.h),
            
            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: _resetFilters,
                    style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    ),
                    child: Text(
                      'Reset',
                      style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                    ),
                  ),
                ),
                
                SizedBox(width: 8.w),
                
                ElevatedButton(
                    onPressed: _applyFilters,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                    'Apply',
                      style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
          title,
          style: GoogleFonts.outfit(
          fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
    );
  }
  
  Widget _buildFilterChip({
    required String label, 
    required bool selected,
    required Function(bool) onSelected,
  }) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    
    return FilterChip(
      label: Text(
            label,
            style: GoogleFonts.outfit(
          fontSize: 12.sp,
          color: selected ? Colors.white : Colors.black87,
            ),
      ),
      selected: selected,
      onSelected: onSelected,
      backgroundColor: Colors.grey[200],
      selectedColor: primaryColor,
      checkmarkColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}