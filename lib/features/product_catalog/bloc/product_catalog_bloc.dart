import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/product_catalog_repository.dart';
import 'product_catalog_event.dart';
import 'product_catalog_state.dart';

class ProductCatalogBloc extends Bloc<ProductCatalogEvent, ProductCatalogState> {
  final ProductCatalogRepository _repository;

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
      final products = await _repository.getProductsByBrand(event.brand);
      emit(currentState.copyWith(
        products: products,
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
      return product.name.toLowerCase().contains(event.query.toLowerCase()) ||
          product.brand.toLowerCase().contains(event.query.toLowerCase());
    }).toList();

    emit(currentState.copyWith(
      products: filteredProducts,
      searchQuery: event.query,
    ));
  }
}
