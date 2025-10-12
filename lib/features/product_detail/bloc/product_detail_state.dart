import 'package:equatable/equatable.dart';

abstract class ProductDetailState extends Equatable {
  final bool isSpecificationsExpanded;
  final bool isDescriptionImagesExpanded;

  const ProductDetailState({
    this.isSpecificationsExpanded = false,
    this.isDescriptionImagesExpanded = false,
  });

  @override
  List<Object?> get props => [isSpecificationsExpanded, isDescriptionImagesExpanded];
}

class ProductDetailInitial extends ProductDetailState {
  const ProductDetailInitial() : super();
}

class ProductDetailLoading extends ProductDetailState {
  const ProductDetailLoading() : super();
}

class ProductDetailLoaded extends ProductDetailState {
  const ProductDetailLoaded({
    super.isSpecificationsExpanded = false,
    super.isDescriptionImagesExpanded = false,
  });

  ProductDetailLoaded copyWith({
    bool? isSpecificationsExpanded,
    bool? isDescriptionImagesExpanded,
  }) {
    return ProductDetailLoaded(
      isSpecificationsExpanded: isSpecificationsExpanded ?? this.isSpecificationsExpanded,
      isDescriptionImagesExpanded: isDescriptionImagesExpanded ?? this.isDescriptionImagesExpanded,
    );
  }
}

class ProductDetailError extends ProductDetailState {
  final String message;

  const ProductDetailError(this.message) : super();

  @override
  List<Object?> get props => [message, isSpecificationsExpanded, isDescriptionImagesExpanded];
}
