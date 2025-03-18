import 'package:equatable/equatable.dart';

class Property extends Equatable {
  final String id;
  final String title;
  final double price;
  final PropertyLocation location;
  final PropertySpecifications specifications;
  final List<String> images;
  final List<String> tags;
  final DateTime dateAdded;
  final bool mortgageEligible;
  final double monthlyPaymentEstimate;

  const Property({
    required this.id,
    required this.title,
    required this.price,
    required this.location,
    required this.specifications,
    required this.images,
    required this.tags,
    required this.dateAdded,
    required this.mortgageEligible,
    required this.monthlyPaymentEstimate,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        location,
        specifications,
        images,
        tags,
        dateAdded,
        mortgageEligible,
        monthlyPaymentEstimate,
      ];
}

class PropertyLocation extends Equatable {
  final String neighborhood;
  final String city;
  final double? latitude;
  final double? longitude;

  const PropertyLocation({
    required this.neighborhood,
    required this.city,
    this.latitude,
    this.longitude,
  });

  @override
  List<Object?> get props => [neighborhood, city, latitude, longitude];
}

class PropertySpecifications extends Equatable {
  final int bedrooms;
  final int bathrooms;
  final double size;
  final String propertyType;

  const PropertySpecifications({
    required this.bedrooms,
    required this.bathrooms,
    required this.size,
    required this.propertyType,
  });

  @override
  List<Object?> get props => [bedrooms, bathrooms, size, propertyType];
}
