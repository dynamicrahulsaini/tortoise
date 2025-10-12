import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tortoise_assignment/core/theme/text_style.dart';
import '../../../core/theme/app_colors.dart';

class DescriptionImagesSection extends StatelessWidget {
  final List<String> imageUrls;
  final bool isExpanded;
  final VoidCallback onToggleExpanded;

  const DescriptionImagesSection({
    super.key,
    required this.imageUrls,
    required this.isExpanded,
    required this.onToggleExpanded,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return const SizedBox.shrink();
    }

    final displayImages = isExpanded ? imageUrls : [imageUrls.first];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22),
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black.withAlpha(10),
          width: 1,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 0,
            spreadRadius: 0,
            color: Colors.black.withAlpha(10),
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: displayImages.length,
            itemBuilder: (context, index) => _buildDescriptionImage(
              displayImages[index],
              topRadius: index == 0,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 4, left: 4, right: 4, top: 2),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.black1),
              color: Colors.white,
            ),
            child: GestureDetector(
              onTap: onToggleExpanded,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        isExpanded ? 'Show less' : 'View more',
                        key: ValueKey(isExpanded),
                        style: AppTypography.p3Semibold.copyWith(color: AppColors.primary9),
                      ),
                    ),
                    const SizedBox(width: 4),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 300),
                      turns: isExpanded ? 0.5 : 0.0,
                      child: const PhosphorIcon(
                        PhosphorIconsFill.caretCircleDown,
                        color: AppColors.primary9,
                        size: 20,
                      ),
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

  Widget _buildDescriptionImage(
    String imageUrl, {
    required bool topRadius,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: topRadius ? const Radius.circular(8) : Radius.zero,
        ),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 200,
              color: AppColors.grey200,
              child: const Center(
                child: Icon(
                  Icons.image_not_supported,
                  color: AppColors.grey400,
                  size: 40,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
