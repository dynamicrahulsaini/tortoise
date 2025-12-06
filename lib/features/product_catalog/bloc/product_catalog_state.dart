import 'package:equatable/equatable.dart';
import 'package:tortoise_assignment/core/models/catalog_product_info.dart';
import '../../../core/models/product.dart';

abstract class ProductCatalogState extends Equatable {
  const ProductCatalogState();

  @override
  List<Object?> get props => [];
}

class ProductCatalogInitial extends ProductCatalogState {
  const ProductCatalogInitial();
}

class ProductCatalogLoading extends ProductCatalogState {
  const ProductCatalogLoading();
}

class ProductCatalogLoaded extends ProductCatalogState {
  final List<CatalogProductInfo> products;
  final String? selectedBrand;
  final String searchQuery;

  const ProductCatalogLoaded({
    required this.products,
    this.selectedBrand,
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [products, selectedBrand, searchQuery];

  ProductCatalogLoaded copyWith({
    List<CatalogProductInfo>? products,
    String? selectedBrand,
    String? searchQuery,
  }) {
    return ProductCatalogLoaded(
      products: products ?? this.products,
      selectedBrand: selectedBrand ?? this.selectedBrand,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class ProductCatalogError extends ProductCatalogState {
  final String message;

  const ProductCatalogError(this.message);

  @override
  List<Object?> get props => [message];
}
