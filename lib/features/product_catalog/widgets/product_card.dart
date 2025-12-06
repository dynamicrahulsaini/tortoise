import 'package:flutter/material.dart';
import 'package:tortoise_assignment/core/models/catalog_product_info.dart';
import '../../../core/models/product.dart';
import '../../../core/theme/app_colors.dart';

class ProductCard extends StatelessWidget {
  final CatalogProductInfo product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // elevation: 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          // First Drop Shadow (Top) - Light grey with 35% opacity
          BoxShadow(
            color: const Color(0xFFEEEEEE).withOpacity(0.35),
            offset: const Offset(0, 6.54),
            blurRadius: 19.61,
            spreadRadius: 0,
          ),
          // Second Drop Shadow (Middle) - Dark grey with 6% opacity
          BoxShadow(
            color: const Color(0xFF42474C).withOpacity(0.06),
            offset: const Offset(0, 3.27),
            blurRadius: 6.54,
            spreadRadius: 0,
          ),
          // Third Drop Shadow (Bottom) - Dark grey with 32% opacity
          BoxShadow(
            color: const Color(0xFF42474C).withOpacity(0.32),
            offset: const Offset(0, 0),
            blurRadius: 0.82,
            spreadRadius: 0,
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              height: 48,
              product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.grey200,
                  child: const Icon(
                    Icons.image_not_supported,
                    color: AppColors.grey400,
                    size: 40,
                  ),
                );
              },
            ),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
