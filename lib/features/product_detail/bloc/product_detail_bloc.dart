import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tortoise_assignment/core/models/product.dart';
import '../repositories/product_detail_repository.dart';
import 'product_detail_event.dart';
import 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailRepository _repository;
  Product? product;

  ProductDetailBloc(this._repository) : super(const ProductDetailInitial()) {
    on<LoadProductDetail>(_onLoadProductDetail);
    on<SelectColor>(_onSelectColor);
    on<SelectStorage>(_onSelectStorage);
    on<UpdateTaxSlab>(_onUpdateTaxSlab);
    on<ToggleSpecificationsExpanded>(_onToggleSpecificationsExpanded);
    on<ToggleDescriptionImagesExpanded>(_onToggleDescriptionImagesExpanded);
  }

  Future<void> _onLoadProductDetail(
    LoadProductDetail event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(const ProductDetailLoading());

    try {
      product = await _repository.getProductById(event.productId);
      emit(const ProductDetailLoaded());
    } catch (e) {
      emit(ProductDetailError('Failed to load product: ${e.toString()}'));
    }
  }

  Future<void> _onSelectColor(
    SelectColor event,
    Emitter<ProductDetailState> emit,
  ) async {
    if (product == null) return;

    emit(const ProductDetailLoading());

    try {
      product = await _repository.updateProductConfiguration(
        productId: product!.id,
        selectedColorId: event.colorId,
      );
      emit(ProductDetailLoaded(
        isSpecificationsExpanded: state.isSpecificationsExpanded,
        isDescriptionImagesExpanded: state.isDescriptionImagesExpanded,
      ));
    } catch (e) {
      emit(ProductDetailError('Failed to update color: ${e.toString()}'));
    }
  }

  Future<void> _onSelectStorage(
    SelectStorage event,
    Emitter<ProductDetailState> emit,
  ) async {
    if (product == null) return;

    emit(const ProductDetailLoading());

    try {
      product = await _repository.updateProductConfiguration(
        productId: product!.id,
        selectedStorageId: event.storageId,
      );
      emit(ProductDetailLoaded(
        isSpecificationsExpanded: state.isSpecificationsExpanded,
        isDescriptionImagesExpanded: state.isDescriptionImagesExpanded,
      ));
    } catch (e) {
      emit(ProductDetailError('Failed to update storage: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateTaxSlab(
    UpdateTaxSlab event,
    Emitter<ProductDetailState> emit,
  ) async {
    if (product == null) return;

    emit(const ProductDetailLoading());

    try {
      product = await _repository.updateProductConfiguration(
        productId: product!.id,
        taxSlab: event.taxSlab,
      );
      emit(ProductDetailLoaded(
        isSpecificationsExpanded: state.isSpecificationsExpanded,
        isDescriptionImagesExpanded: state.isDescriptionImagesExpanded,
      ));
    } catch (e) {
      emit(ProductDetailError('Failed to update tax slab: ${e.toString()}'));
    }
  }

  void _onToggleSpecificationsExpanded(
    ToggleSpecificationsExpanded event,
    Emitter<ProductDetailState> emit,
  ) {
    if (product == null) return;

    if (state is ProductDetailLoaded) {
      final currentState = state as ProductDetailLoaded;
      emit(currentState.copyWith(
        isSpecificationsExpanded: !currentState.isSpecificationsExpanded,
      ));
    } else {
      // Handle other states that have product data
      emit(ProductDetailLoaded(
        isSpecificationsExpanded: !state.isSpecificationsExpanded,
        isDescriptionImagesExpanded: state.isDescriptionImagesExpanded,
      ));
    }
  }

  void _onToggleDescriptionImagesExpanded(
    ToggleDescriptionImagesExpanded event,
    Emitter<ProductDetailState> emit,
  ) {
    if (product == null) return;

    if (state is ProductDetailLoaded) {
      final currentState = state as ProductDetailLoaded;
      emit(currentState.copyWith(
        isDescriptionImagesExpanded: !currentState.isDescriptionImagesExpanded,
      ));
    } else {
      // Handle other states that have product data
      emit(ProductDetailLoaded(
        isSpecificationsExpanded: state.isSpecificationsExpanded,
        isDescriptionImagesExpanded: !state.isDescriptionImagesExpanded,
      ));
    }
  }
}
