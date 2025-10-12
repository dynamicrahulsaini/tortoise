import 'package:equatable/equatable.dart';
import 'package:tortoise_assignment/core/models/tax_slab.dart';
import 'delivery_info.dart';
import 'product_config.dart';
import 'specification.dart';
import 'product_pricing.dart';
import 'product_tax_info.dart';

// TODO: can remove isProtected field
class Product extends Equatable {
  final String id;
  final String name;
  final String brand;
  final String category;
  final List<String> imageUrls;
  final DeliveryInfo deliveryInfo;
  final ProductConfig config;
  final List<Specification>? specifications;
  final List<String> descriptionImageUrls;
  final ProductPricing pricing;
  final List<ProductTaxInfo> taxSlabInfo;
  final String? selectedColorId;
  final String? selectedStorageId;
  final bool isProtected;

  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.imageUrls,
    required this.deliveryInfo,
    required this.config,
    this.specifications,
    required this.descriptionImageUrls,
    required this.pricing,
    required this.taxSlabInfo,
    this.selectedColorId,
    this.selectedStorageId,
    this.isProtected = true,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        brand,
        category,
        imageUrls,
        deliveryInfo,
        config,
        specifications,
        descriptionImageUrls,
        pricing,
        taxSlabInfo,
        selectedColorId,
        selectedStorageId,
        isProtected,
      ];

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String,
      category: json['category'] as String,
      imageUrls: (json['imageUrls'] as List).cast<String>(),
      deliveryInfo: DeliveryInfo.fromJson(json['deliveryInfo'] as Map<String, dynamic>),
      config: ProductConfig.fromJson(json['config'] as Map<String, dynamic>),
      specifications:
          (json['specifications'] as List).map((e) => Specification.fromJson(e as Map<String, dynamic>)).toList(),
      descriptionImageUrls: (json['descriptionImageUrls'] as List).cast<String>(),
      pricing: ProductPricing.fromJson(json['pricing'] as Map<String, dynamic>),
      taxSlabInfo:
          (json['taxSlabInfo'] as List).map((e) => ProductTaxInfo.fromJson(e as Map<String, dynamic>)).toList(),
      selectedColorId: json['selectedColorId'] as String?,
      selectedStorageId: json['selectedStorageId'] as String?,
      isProtected: json['isProtected'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'category': category,
      'imageUrls': imageUrls,
      'deliveryInfo': deliveryInfo.toJson(),
      'config': config.toJson(),
      'specifications': specifications?.map((e) => e.toJson()).toList(),
      'descriptionImageUrls': descriptionImageUrls,
      'pricing': pricing.toJson(),
      'taxSlabInfo': taxSlabInfo.map((e) => e.toJson()).toList(),
      'selectedColorId': selectedColorId,
      'selectedStorageId': selectedStorageId,
      'isProtected': isProtected,
    };
  }

  Product copyWith({
    String? id,
    String? name,
    String? brand,
    String? category,
    List<String>? imageUrls,
    DeliveryInfo? deliveryInfo,
    ProductConfig? config,
    List<Specification>? specifications,
    List<String>? descriptionImageUrls,
    ProductPricing? pricing,
    List<ProductTaxInfo>? taxSlabInfo,
    String? selectedColorId,
    String? selectedStorageId,
    bool? isProtected,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      imageUrls: imageUrls ?? this.imageUrls,
      deliveryInfo: deliveryInfo ?? this.deliveryInfo,
      config: config ?? this.config,
      specifications: specifications ?? this.specifications,
      descriptionImageUrls: descriptionImageUrls ?? this.descriptionImageUrls,
      pricing: pricing ?? this.pricing,
      taxSlabInfo: taxSlabInfo ?? this.taxSlabInfo,
      selectedColorId: selectedColorId ?? this.selectedColorId,
      selectedStorageId: selectedStorageId ?? this.selectedStorageId,
      isProtected: isProtected ?? this.isProtected,
    );
  }

  ColorOption? get selectedColor {
    if (selectedColorId == null) return null;
    try {
      return config.colors.firstWhere((color) => color.id == selectedColorId);
    } catch (e) {
      return null;
    }
  }

  StorageOption? get selectedStorage {
    if (selectedStorageId == null) return null;
    try {
      return config.storageOptions.firstWhere((storage) => storage.id == selectedStorageId);
    } catch (e) {
      return null;
    }
  }

  /// Get tax information for a specific tax slab
  ProductTaxInfo? getTaxInfoForSlab(TaxSlab taxSlab) {
    try {
      return taxSlabInfo.firstWhere((info) => info.taxSlab.id == taxSlab.id);
    } catch (e) {
      return null;
    }
  }

  /// Get all available tax slabs from the product's tax info
  List<TaxSlab> get availableTaxSlabs {
    return taxSlabInfo.map((info) => info.taxSlab).toList();
  }
}
