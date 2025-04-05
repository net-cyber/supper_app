import 'package:intl/intl.dart';
import 'package:super_app/features/mortgages/domain/entities/property.dart';

class PropertyModel extends Property {
  const PropertyModel({
    required super.id,
    required super.title,
    required super.price,
    required super.location,
    required super.specifications,
    required super.images,
    required super.tags,
    required super.dateAdded,
    required super.mortgageEligible,
    required super.monthlyPaymentEstimate,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'] as String,
      title: json['title'] as String,
      price: json['price'] as double,
      location: PropertyLocationModel.fromJson(json['location'] as Map<String, dynamic>),
      specifications: PropertySpecificationsModel.fromJson(json['specifications'] as Map<String, dynamic>),
      images: List<String>.from(json['images'] as Iterable<dynamic>),
      tags: List<String>.from(json['tags'] as Iterable<dynamic>),
      dateAdded: DateTime.parse(json['date_added'] as String),
      mortgageEligible: json['mortgage_eligible'] as bool,
      monthlyPaymentEstimate: json['monthly_payment_estimate'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'location': (location as PropertyLocationModel).toJson(),
      'specifications': (specifications as PropertySpecificationsModel).toJson(),
      'images': images,
      'tags': tags,
      'date_added': DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(dateAdded),
      'mortgage_eligible': mortgageEligible,
      'monthly_payment_estimate': monthlyPaymentEstimate,
    };
  }
}

class PropertyLocationModel extends PropertyLocation {
  const PropertyLocationModel({
    required super.neighborhood,
    required super.city,
    super.latitude,
    super.longitude,
  });

  factory PropertyLocationModel.fromJson(Map<String, dynamic> json) {
    return PropertyLocationModel(
      neighborhood: json['neighborhood'] as String,
      city: json['city'] as String,
      latitude: json['coordinates']?['latitude'] as double?,
      longitude: json['coordinates']?['longitude'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'neighborhood': neighborhood,
      'city': city,
      'coordinates': {
        'latitude': latitude,
        'longitude': longitude,
      },
    };
  }
}

class PropertySpecificationsModel extends PropertySpecifications {
  const PropertySpecificationsModel({
    required super.bedrooms,
    required super.bathrooms,
    required super.size,
    required super.propertyType,
  });

  factory PropertySpecificationsModel.fromJson(Map<String, dynamic> json) {
    return PropertySpecificationsModel(
      bedrooms: json['bedrooms'] as int,
      bathrooms: json['bathrooms'] as int,
      size: json['size'] as double,
      propertyType: json['property_type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'size': size,
      'property_type': propertyType,
    };
  }
}
