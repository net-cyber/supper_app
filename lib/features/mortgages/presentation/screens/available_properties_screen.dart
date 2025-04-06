import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/features/mortgages/domain/entities/property.dart';
import 'package:super_app/features/mortgages/presentation/widgets/property_card.dart';
import 'package:super_app/features/mortgages/presentation/widgets/filter_bar.dart';
import 'package:super_app/features/mortgages/presentation/widgets/property_skeleton.dart';
import 'package:super_app/features/mortgages/data/models/property_model.dart';
import 'package:super_app/core/theme/app_colors.dart';

class AvailablePropertiesScreen extends StatefulWidget {
  const AvailablePropertiesScreen({super.key});

  @override
  State<AvailablePropertiesScreen> createState() => _AvailablePropertiesScreenState();
}

class _AvailablePropertiesScreenState extends State<AvailablePropertiesScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;
  List<Property> _properties = [];
  List<String> _selectedFilters = [];
  final List<String> _filterOptions = [
    'All',
    'Apartment',
    'Villa',
    'Condominium',
    'House',
    'Bole',
    'CMC',
    'Kazanchis',
    'Ayat',
  ];
  final Set<String> _favoritePropertyIds = {};
  
  @override
  void initState() {
    super.initState();
    _loadProperties();
    
    // Add scroll listener for pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadMoreProperties();
      }
    });
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  
  Future<void> _loadProperties() async {
    setState(() {
      _isLoading = true;
    });
    
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));
    
    // Load dummy data
    final properties = _getDummyProperties();
    
    setState(() {
      _properties = properties;
      _isLoading = false;
    });
  }
  
  Future<void> _loadMoreProperties() async {
    // Simulate loading more properties
    setState(() {
      _isLoading = true;
    });
    
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Add more dummy properties
    final moreProperties = _getDummyProperties().take(3).toList();
    
    setState(() {
      _properties.addAll(moreProperties);
      _isLoading = false;
    });
  }
  
  void _toggleFavorite(String propertyId) {
    setState(() {
      if (_favoritePropertyIds.contains(propertyId)) {
        _favoritePropertyIds.remove(propertyId);
      } else {
        _favoritePropertyIds.add(propertyId);
      }
    });
  }
  
  void _onFilterSelected(String filter) {
    setState(() {
      if (filter == 'All') {
        _selectedFilters = [];
      } else if (_selectedFilters.contains(filter)) {
        _selectedFilters.remove(filter);
      } else {
        _selectedFilters.add(filter);
      }
    });
  }
  
  void _showAdvancedFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(24.w),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Advanced Filters',
                    style: GoogleFonts.outfit(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: 24.sp),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Text(
                'Price Range',
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              // Price range slider would go here
              
              SizedBox(height: 24.h),
              Text(
                'Property Type',
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              // Property type checkboxes would go here
              
              SizedBox(height: 24.h),
              Text(
                'Bedrooms',
                style: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8.h),
              // Bedroom selection would go here
              
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        side: const BorderSide(color: AppColors.primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Reset',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Apply Filters',
                        style: GoogleFonts.outfit(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  
  List<Property> get filteredProperties {
    if (_selectedFilters.isEmpty) {
      return _properties;
    }
    
    return _properties.where((property) {
      final matchesPropertyType = _selectedFilters.contains(property.specifications.propertyType);
      final matchesLocation = _selectedFilters.contains(property.location.neighborhood);
      return matchesPropertyType || matchesLocation;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available Properties',
              style: GoogleFonts.outfit(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              'Find your dream home',
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none_rounded, color: Colors.grey[800]),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_outline_rounded, color: Colors.grey[800]),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey[200]!),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey[400], size: 20.sp),
                  SizedBox(width: 12.w),
                  Text(
                    'Search properties',
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      color: Colors.grey[400],
                      letterSpacing: -0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Filter bar
          FilterBar(
            filterOptions: _filterOptions,
            selectedFilters: _selectedFilters,
            onFilterSelected: _onFilterSelected,
            onAdvancedFilterTap: _showAdvancedFilterModal,
          ),
          
          // Property list
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadProperties,
              child: _isLoading && _properties.isEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.only(top: 8.h),
                      itemCount: 3,
                      itemBuilder: (context, index) => const PropertySkeleton(),
                    )
                  : filteredProperties.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
                          itemCount: filteredProperties.length + (_isLoading ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == filteredProperties.length) {
                              return const PropertySkeleton();
                            }
                            
                            final property = filteredProperties[index];
                            return PropertyCard(
                              property: property,
                              onTap: () => _navigateToPropertyDetail(property),
                              onFavoriteToggle: () => _toggleFavorite(property.id),
                              isFavorite: _favoritePropertyIds.contains(property.id),
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.home_work_outlined,
            size: 80.sp,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16.h),
          Text(
            'No properties found',
            style: GoogleFonts.outfit(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Try adjusting your filters',
            style: GoogleFonts.outfit(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedFilters = [];
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Clear Filters',
              style: GoogleFonts.outfit(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _navigateToPropertyDetail(Property property) {
    // Navigate to property detail screen
    context.pushNamed(RouteName.propertyDetail, extra: property);
    
    // For now, just show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected property: ${property.title}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
  
  List<Property> _getDummyProperties() {
    return [
      PropertyModel(
        id: 'prop001',
        title: 'Modern Apartment in Bole',
        price: 4800000,
        location: const PropertyLocationModel(
          neighborhood: 'Bole',
          city: 'Addis Ababa',
          latitude: 9.0127,
          longitude: 38.7795,
        ),
        specifications: const PropertySpecificationsModel(
          bedrooms: 2,
          bathrooms: 2,
          size: 85,
          propertyType: 'Apartment',
        ),
        images: const [
          'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
          'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
        ],
        tags: const ['featured'],
        dateAdded: DateTime.now().subtract(const Duration(days: 5)),
        mortgageEligible: true,
        monthlyPaymentEstimate: 38000,
      ),
      PropertyModel(
        id: 'prop002',
        title: 'Luxury Villa in CMC',
        price: 12500000,
        location: const PropertyLocationModel(
          neighborhood: 'CMC',
          city: 'Addis Ababa',
          latitude: 9.0350,
          longitude: 38.7650,
        ),
        specifications: const PropertySpecificationsModel(
          bedrooms: 5,
          bathrooms: 4,
          size: 320,
          propertyType: 'Villa',
        ),
        images: const [
          'https://images.unsplash.com/photo-1613977257363-707ba9348227?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
          'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
        ],
        tags: const ['new', 'premium'],
        dateAdded: DateTime.now().subtract(const Duration(days: 2)),
        mortgageEligible: true,
        monthlyPaymentEstimate: 95000,
      ),
      PropertyModel(
        id: 'prop003',
        title: 'Cozy Condominium in Kazanchis',
        price: 3200000,
        location: const PropertyLocationModel(
          neighborhood: 'Kazanchis',
          city: 'Addis Ababa',
          latitude: 9.0200,
          longitude: 38.7500,
        ),
        specifications: const PropertySpecificationsModel(
          bedrooms: 1,
          bathrooms: 1,
          size: 65,
          propertyType: 'Condominium',
        ),
        images: const [
          'https://images.unsplash.com/photo-1493809842364-78817add7ffb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
          'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2080&q=80',
        ],
        tags: const [],
        dateAdded: DateTime.now().subtract(const Duration(days: 10)),
        mortgageEligible: true,
        monthlyPaymentEstimate: 25000,
      ),
      PropertyModel(
        id: 'prop004',
        title: 'Spacious Family House in Ayat',
        price: 6800000,
        location: const PropertyLocationModel(
          neighborhood: 'Ayat',
          city: 'Addis Ababa',
          latitude: 9.0400,
          longitude: 38.8100,
        ),
        specifications: const PropertySpecificationsModel(
          bedrooms: 4,
          bathrooms: 3,
          size: 220,
          propertyType: 'House',
        ),
        images: const [
          'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2074&q=80',
          'https://images.unsplash.com/photo-1583608205776-bfd35f0d9f83?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
        ],
        tags: const ['featured'],
        dateAdded: DateTime.now().subtract(const Duration(days: 7)),
        mortgageEligible: true,
        monthlyPaymentEstimate: 52000,
      ),
      PropertyModel(
        id: 'prop005',
        title: 'Modern Apartment with City View',
        price: 5200000,
        location: const PropertyLocationModel(
          neighborhood: 'Bole',
          city: 'Addis Ababa',
          latitude: 9.0150,
          longitude: 38.7820,
        ),
        specifications: const PropertySpecificationsModel(
          bedrooms: 3,
          bathrooms: 2,
          size: 110,
          propertyType: 'Apartment',
        ),
        images: const [
          'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
          'https://images.unsplash.com/photo-1484154218962-a197022b5858?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2074&q=80',
        ],
        tags: const ['new'],
        dateAdded: DateTime.now().subtract(const Duration(days: 3)),
        mortgageEligible: true,
        monthlyPaymentEstimate: 42000,
      ),
    ];
  }
}
