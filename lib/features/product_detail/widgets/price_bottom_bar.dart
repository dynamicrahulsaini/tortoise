import 'package:flutter/material.dart';
import '../../../core/models/product_pricing.dart';
import '../../../core/theme/app_colors.dart';

class PriceBottomBar extends StatelessWidget {
  final ProductPricing pricing;
  final VoidCallback onAddToCart;
  final VoidCallback? onTaxSlabTap;

  const PriceBottomBar({
    super.key,
    required this.pricing,
    required this.onAddToCart,
    this.onTaxSlabTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.textPrimary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPriceComparison(),
          const SizedBox(height: 16),
          _buildAddToCartButton(),
        ],
      ),
    );
  }

  Widget _buildPriceComparison() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'DEVICE PRICE',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey400,
                ),
              ),
              Text(
                '${pricing.currency}${_formatPrice(pricing.devicePrice)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                'Monthly deduction ${pricing.currency}${_formatPrice(pricing.monthlyDeduction)}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.grey400,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'EFFECTIVE PRICE',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.success,
                    ),
                  ),
                  if (onTaxSlabTap != null) ...[
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: onTaxSlabTap,
                      child: const Icon(
                        Icons.info_outline,
                        size: 16,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ],
              ),
              Text(
                '${pricing.currency}${_formatPrice(pricing.effectivePrice)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.success,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Impact in net-salary',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.grey400,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.trending_up,
                    size: 12,
                    color: AppColors.success,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAddToCartButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onAddToCart,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.textPrimary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
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
