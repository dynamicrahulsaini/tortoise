import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tortoise_assignment/core/models/available_brand.dart';
import 'package:tortoise_assignment/core/models/catalog_product_info.dart';
import '../repositories/product_catalog_repository.dart';
import 'product_catalog_event.dart';
import 'product_catalog_state.dart';

class ProductCatalogBloc extends Bloc<ProductCatalogEvent, ProductCatalogState> {
  final ProductCatalogRepository _repository;

  List<AvailableBrand> availableBrands = [];
  final List<CatalogProductInfo> products = [];

  ProductCatalogBloc(this._repository) : super(const ProductCatalogInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<FilterByBrand>(_onFilterByBrand);
    on<SearchProducts>(_onSearchProducts);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductCatalogState> emit,
  ) async {
    emit(const ProductCatalogLoading());

    try {
      final products = await _repository.getAllProducts();
      this.products
        ..clear()
        ..addAll(products);
      availableBrands = await _repository.getAvailableBrands();
      emit(ProductCatalogLoaded(
        products: products,
        selectedBrand: null,
        searchQuery: '',
      ));
    } catch (e) {
      emit(ProductCatalogError('Failed to load products: ${e.toString()}'));
    }
  }

  Future<void> _onFilterByBrand(
    FilterByBrand event,
    Emitter<ProductCatalogState> emit,
  ) async {
    if (state is! ProductCatalogLoaded) return;

    final currentState = state as ProductCatalogLoaded;
    emit(const ProductCatalogLoading());

    try {
      // final products = this.products.where((product) => product.)
      // final products = await _repository.getProductsByBrand(event.brand);
      emit(currentState.copyWith(
        products: this.products,
        selectedBrand: event.brand,
      ));
    } catch (e) {
      emit(ProductCatalogError('Failed to filter products: ${e.toString()}'));
    }
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductCatalogState> emit,
  ) async {
    if (state is! ProductCatalogLoaded) return;

    final currentState = state as ProductCatalogLoaded;

    // For now, we'll do client-side filtering
    // In a real app, this would be an API call
    final filteredProducts = currentState.products.where((product) {
      return product.name.toLowerCase().contains(event.query.toLowerCase());
    }).toList();

    emit(currentState.copyWith(
      products: filteredProducts,
      searchQuery: event.query,
    ));
  }
}
