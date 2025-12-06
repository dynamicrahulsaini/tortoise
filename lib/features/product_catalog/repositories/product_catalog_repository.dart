import 'dart:async';
import 'package:tortoise_assignment/core/models/available_brand.dart';
import 'package:tortoise_assignment/core/models/catalog_product_info.dart';

import '../../../core/models/product.dart';
import '../services/product_catalog_service.dart';

class ProductCatalogRepository {
  final ProductCatalogService _service;

  ProductCatalogRepository({ProductCatalogService? service}) : _service = service ?? ProductCatalogService();

  /// Get all available brands
  Future<List<AvailableBrand>> getAvailableBrands() async {
    return await _service.getAvailableBrands();
  }

  /// Get all available product categories
  Future<List<String>> getProductCategories() async {
    return await _service.getProductCategories();
  }

  /// Get products filtered by brand
  Future<List<Product>> getProductsByBrand(String brand) async {
    return await _service.getProductsByBrand(brand);
  }

  /// Get all products
  Future<List<CatalogProductInfo>> getAllProducts() async {
    return await _service.getAllProducts();
  }

  /// Get a specific product by ID
  Future<Product> getProductById(String productId) async {
    return await _service.getProductById(productId);
  }
}
