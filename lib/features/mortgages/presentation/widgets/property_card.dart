import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/property.dart';

class PropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;
  final bool isFavorite;

  const PropertyCard({
    Key? key,
    required this.property,
    required this.onTap,
    required this.onFavoriteToggle,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'en_ET',
      symbol: 'ETB ',
      decimalDigits: 0,
    );
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Image with Tags and Favorite Button
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                  child: Image.network(
                    property.images.first,
                    height: 160.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 160.h,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 50.sp,
                          color: Colors.grey[400],
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 160.h,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Tags (New, Featured, etc.)
                if (property.tags.isNotEmpty)
                  Positioned(
                    top: 12.h,
                    left: 12.w,
                    child: Row(
                      children: property.tags.map((tag) {
                        Color tagColor;
                        if (tag.toLowerCase() == 'new') {
                          tagColor = Colors.green;
                        } else if (tag.toLowerCase() == 'featured') {
                          tagColor = Colors.orange;
                        } else if (tag.toLowerCase() == 'premium') {
                          tagColor = Colors.purple;
                        } else {
                          tagColor = Colors.blue;
                        }
                        
                        return Container(
                          margin: EdgeInsets.only(right: 8.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: tagColor,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            tag.toUpperCase(),
                            style: GoogleFonts.outfit(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                // Favorite Button
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: GestureDetector(
                    onTap: onFavoriteToggle,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Property Details
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price
                  Text(
                    currencyFormat.format(property.price),
                    style: GoogleFonts.outfit(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  
                  // Title
                  Text(
                    property.title,
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  
                  // Location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16.sp,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          '${property.location.neighborhood}, ${property.location.city}',
                          style: GoogleFonts.outfit(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  
                  // Specifications
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSpecItem(
                        Icons.king_bed_outlined,
                        '${property.specifications.bedrooms} Beds',
                      ),
                      _buildSpecItem(
                        Icons.bathtub_outlined,
                        '${property.specifications.bathrooms} Baths',
                      ),
                      _buildSpecItem(
                        Icons.square_foot_outlined,
                        '${property.specifications.size} m²',
                      ),
                      _buildSpecItem(
                        Icons.home_outlined,
                        property.specifications.propertyType,
                        isLast: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecItem(IconData icon, String text, {bool isLast = false}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: Colors.grey[600],
        ),
        SizedBox(width: 4.w),
        Text(
          text,
          style: GoogleFonts.outfit(
            fontSize: 12.sp,
            color: Colors.grey[700],
          ),
        ),
        if (!isLast) SizedBox(width: 8.w),
      ],
    );
  }
}
