import 'package:equatable/equatable.dart';

class CatalogProductInfo extends Equatable {
  final String id;
  final String name;
  final String shortName;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String deviceType;
  final double mrp;
  final String manufacturerProductCode;
  final Map<String, dynamic> extras;

  const CatalogProductInfo({
    required this.id,
    required this.name,
    required this.shortName,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.deviceType,
    required this.mrp,
    required this.manufacturerProductCode,
    required this.extras,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        shortName,
        imageUrl,
        createdAt,
        updatedAt,
        deviceType,
        mrp,
        manufacturerProductCode,
        extras,
      ];

  factory CatalogProductInfo.fromJson(Map<String, dynamic> json) {
    return CatalogProductInfo(
      id: json['id'] as String,
      name: json['name'] as String,
      shortName: json['short_name'] as String,
      imageUrl: json['image_url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deviceType: json['device_type'] as String,
      mrp: (json['mrp'] as num).toDouble(),
      manufacturerProductCode: json['manufacturer_product_code'] as String,
      extras: json['extras'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'short_name': shortName,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'device_type': deviceType,
      'mrp': mrp,
      'manufacturer_product_code': manufacturerProductCode,
      'extras': extras,
    };
  }

  CatalogProductInfo copyWith({
    String? id,
    String? name,
    String? shortName,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? deviceType,
    double? mrp,
    String? manufacturerProductCode,
    Map<String, dynamic>? extras,
  }) {
    return CatalogProductInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deviceType: deviceType ?? this.deviceType,
      mrp: mrp ?? this.mrp,
      manufacturerProductCode: manufacturerProductCode ?? this.manufacturerProductCode,
      extras: extras ?? this.extras,
    );
  }
}
