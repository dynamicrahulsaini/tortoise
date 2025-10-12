import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class BrandFilterChip extends StatelessWidget {
  final String brand;
  final bool isSelected;
  final VoidCallback onTap;

  const BrandFilterChip({
    super.key,
    required this.brand,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 76,
        width: 76,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.black2,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(38),
              offset: Offset.zero,
              spreadRadius: 0,
            ),
          ],
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.black : AppColors.grey300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          spacing: 4,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getBrandIcon(brand),
            Text(
              brand,
              style: const TextStyle(
                fontSize: 12,
                height: 20 / 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBrandIcon(String brand) {
    Color? color;
    switch (brand.toLowerCase()) {
      case 'apple':
        return const Icon(
          Icons.apple,
          size: 24,
          color: AppColors.appleBlack,
        );
      case 'samsung':
        color = AppColors.samsungBlue;
      // color = AppColors.googleBlue;
      case 'oneplus':
        color = AppColors.oneplusRed;
      case 'google':
        color = null;
      default:
        return const Icon(
          Icons.branding_watermark,
          size: 20,
          color: AppColors.grey500,
        );
    }

    return Image.asset(
      color: color,
      colorBlendMode: color != null ? BlendMode.srcIn : null,
      'assets/brands/${brand.toLowerCase()}.png',
      height: 24,
    );
  }
}
