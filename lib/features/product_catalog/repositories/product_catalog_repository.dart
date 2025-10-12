import 'dart:async';
import 'package:tortoise_assignment/features/product_detail/repositories/product_detail_repository.dart';

import '../../../core/models/product.dart';

class ProductCatalogRepository {
  static final List<Product> _mockProducts = _generateMockProducts();

  Future<List<Product>> getProductsByBrand(String brand) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    if (brand.toLowerCase() == 'all') {
      return List.from(_mockProducts);
    }

    return _mockProducts.where((product) => product.brand.toLowerCase() == brand.toLowerCase()).toList();
  }

  Future<List<Product>> getAllProducts() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    return List.from(_mockProducts);
  }

  static List<Product> _generateMockProducts() {
    return ProductDetailRepository.generateMockProducts().values.toList();
  }
}
