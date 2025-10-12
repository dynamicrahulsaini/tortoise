import 'package:flutter/material.dart';
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ...displayImages.map((imageUrl) {
        //   return _buildDescriptionImage(imageUrl);
        // }),
        ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: displayImages.length,
          itemBuilder: (context, index) => _buildDescriptionImage(
            displayImages[index],
            topRadius: index == 0,
            bottomRadius: index == displayImages.length - 1,
          ),
        ),
        if (imageUrls.length > 1) ...[
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onToggleExpanded,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isExpanded ? 'Show less' : 'View more',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDescriptionImage(
    String imageUrl, {
    required bool topRadius,
    required bool bottomRadius,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 0), // No gaps between images
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: topRadius ? const Radius.circular(8) : Radius.zero,
          bottom: bottomRadius ? const Radius.circular(8) : Radius.zero,
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
