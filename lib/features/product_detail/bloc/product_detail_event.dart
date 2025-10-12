import 'package:equatable/equatable.dart';
import '../../../core/models/tax_slab.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductDetail extends ProductDetailEvent {
  final String productId;

  const LoadProductDetail(this.productId);

  @override
  List<Object?> get props => [productId];
}

class SelectColor extends ProductDetailEvent {
  final String colorId;

  const SelectColor(this.colorId);

  @override
  List<Object?> get props => [colorId];
}

class SelectStorage extends ProductDetailEvent {
  final String storageId;

  const SelectStorage(this.storageId);

  @override
  List<Object?> get props => [storageId];
}

class UpdateTaxSlab extends ProductDetailEvent {
  final TaxSlab taxSlab;

  const UpdateTaxSlab(this.taxSlab);

  @override
  List<Object?> get props => [taxSlab];
}

class ToggleSpecificationsExpanded extends ProductDetailEvent {
  const ToggleSpecificationsExpanded();
}

class ToggleDescriptionImagesExpanded extends ProductDetailEvent {
  const ToggleDescriptionImagesExpanded();
}
