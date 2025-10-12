import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tortoise_assignment/core/theme/text_style.dart';
import 'package:tortoise_assignment/features/product_detail/widgets/net_income_bottom_sheet.dart';
import '../../../core/models/product.dart';
import '../../../core/theme/app_colors.dart';

class PriceBottomBar extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;
  final VoidCallback? onTaxSlabTap;

  const PriceBottomBar({
    super.key,
    required this.product,
    required this.onAddToCart,
    this.onTaxSlabTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFEEEEEE).withOpacity(0.35),
            offset: const Offset(0, -6.54),
            blurRadius: 19.61,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0xFF42474C).withOpacity(0.06),
            offset: const Offset(0, -3.27),
            blurRadius: 6.54,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0xFF42474C).withOpacity(0.32),
            offset: const Offset(0, 0),
            blurRadius: 0.82,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPriceComparison(context),
          const SizedBox(height: 16),
          _buildAddToCartButton(),
        ],
      ),
    );
  }

  Widget _buildPriceComparison(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(12),
      //   color: AppColors.black1,
      // ),
      child: Row(
        spacing: 4,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.black1,
              ),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DEVICE PRICE',
                    style: AppTypography.leadingText,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${product.pricing.currency}${_formatPrice(product.pricing.devicePrice)}',
                        style: AppTypography.h4,
                      ),
                      Text(
                        'Monthly deduction ${product.pricing.currency}${_formatPrice(product.pricing.monthlyDeduction)}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black7,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => NetIncomeBottomSheet.show(context, product),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: const GradientBoxBorder(
                    gradient: LinearGradient(colors: AppColors.borderGradient),
                  ),
                  color: AppColors.black1,
                ),
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'EFFECTIVE PRICE',
                          style: AppTypography.leadingText.copyWith(color: AppColors.primary10),
                        ),
                        const PhosphorIcon(
                          PhosphorIconsFill.caretCircleRight,
                          size: 14,
                          color: AppColors.primary9,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${product.pricing.currency}${_formatPrice(product.pricing.effectivePrice)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary9,
                          ),
                        ),
                        const Text(
                          'See impact in net-salary',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primary9,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onAddToCart,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          backgroundColor: AppColors.black10,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(102),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Add to cart',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
