import 'package:equatable/equatable.dart';
import 'tax_slab.dart';

// TODO: can remove fields other than price
class ProductPricing extends Equatable {
  final int devicePrice;
  final int effectivePrice;
  final int monthlyDeduction;
  final String currency;
  final TaxSlab currentTaxSlab;

  const ProductPricing({
    required this.devicePrice,
    required this.effectivePrice,
    required this.monthlyDeduction,
    this.currency = '₹',
    required this.currentTaxSlab,
  });

  @override
  List<Object?> get props => [
        devicePrice,
        effectivePrice,
        monthlyDeduction,
        currency,
        currentTaxSlab,
      ];

  factory ProductPricing.fromJson(Map<String, dynamic> json) {
    return ProductPricing(
      devicePrice: json['devicePrice'] as int,
      effectivePrice: json['effectivePrice'] as int,
      monthlyDeduction: json['monthlyDeduction'] as int,
      currency: json['currency'] as String? ?? '₹',
      currentTaxSlab: TaxSlab.fromJson(json['currentTaxSlab'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'devicePrice': devicePrice,
      'effectivePrice': effectivePrice,
      'monthlyDeduction': monthlyDeduction,
      'currency': currency,
      'currentTaxSlab': currentTaxSlab.toJson(),
    };
  }

  ProductPricing copyWith({
    int? devicePrice,
    int? effectivePrice,
    int? monthlyDeduction,
    String? currency,
    TaxSlab? currentTaxSlab,
  }) {
    return ProductPricing(
      devicePrice: devicePrice ?? this.devicePrice,
      effectivePrice: effectivePrice ?? this.effectivePrice,
      monthlyDeduction: monthlyDeduction ?? this.monthlyDeduction,
      currency: currency ?? this.currency,
      currentTaxSlab: currentTaxSlab ?? this.currentTaxSlab,
    );
  }
}
