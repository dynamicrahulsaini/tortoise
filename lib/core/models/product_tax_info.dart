import 'package:equatable/equatable.dart';
import 'tax_slab.dart';

class ProductTaxInfo extends Equatable {
  final TaxSlab taxSlab;
  final int effectivePrice;
  final int monthlyDeduction;
  final int taxAmount;
  final int corporateDiscount;

  const ProductTaxInfo({
    required this.taxSlab,
    required this.effectivePrice,
    required this.monthlyDeduction,
    required this.taxAmount,
    required this.corporateDiscount,
  });

  @override
  List<Object?> get props => [
        taxSlab,
        effectivePrice,
        monthlyDeduction,
        taxAmount,
        corporateDiscount,
      ];

  factory ProductTaxInfo.fromJson(Map<String, dynamic> json) {
    return ProductTaxInfo(
      taxSlab: TaxSlab.fromJson(json['taxSlab'] as Map<String, dynamic>),
      effectivePrice: json['effectivePrice'] as int,
      monthlyDeduction: json['monthlyDeduction'] as int,
      taxAmount: json['taxAmount'] as int,
      corporateDiscount: json['corporateDiscount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taxSlab': taxSlab.toJson(),
      'effectivePrice': effectivePrice,
      'monthlyDeduction': monthlyDeduction,
      'taxAmount': taxAmount,
      'corporateDiscount': corporateDiscount,
    };
  }

  ProductTaxInfo copyWith({
    TaxSlab? taxSlab,
    int? effectivePrice,
    int? monthlyDeduction,
    int? taxAmount,
    int? corporateDiscount,
  }) {
    return ProductTaxInfo(
      taxSlab: taxSlab ?? this.taxSlab,
      effectivePrice: effectivePrice ?? this.effectivePrice,
      monthlyDeduction: monthlyDeduction ?? this.monthlyDeduction,
      taxAmount: taxAmount ?? this.taxAmount,
      corporateDiscount: corporateDiscount ?? this.corporateDiscount,
    );
  }
}
