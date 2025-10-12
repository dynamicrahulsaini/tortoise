import 'package:equatable/equatable.dart';

abstract class ProductCatalogEvent extends Equatable {
  const ProductCatalogEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductCatalogEvent {
  const LoadProducts();
}

class FilterByBrand extends ProductCatalogEvent {
  final String brand;

  const FilterByBrand(this.brand);

  @override
  List<Object?> get props => [brand];
}

class SearchProducts extends ProductCatalogEvent {
  final String query;

  const SearchProducts(this.query);

  @override
  List<Object?> get props => [query];
}

