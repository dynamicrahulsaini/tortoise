import 'package:flutter/material.dart';
import '../../../core/models/specification.dart';
import '../../../core/theme/app_colors.dart';

class SpecificationsSection extends StatelessWidget {
  final List<Specification> specifications;
  final bool isExpanded;
  final VoidCallback onToggleExpanded;

  const SpecificationsSection({
    super.key,
    required this.specifications,
    required this.isExpanded,
    required this.onToggleExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final displaySpecs = isExpanded ? specifications : specifications.take(5).toList();
    final hasMoreSpecs = specifications.length > 5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SPECIFICATIONS',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        ...displaySpecs.map((spec) => _buildSpecificationItem(spec)).toList(),
        if (hasMoreSpecs) ...[
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onToggleExpanded,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isExpanded ? 'Show less' : 'More details',
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

  Widget _buildSpecificationItem(Specification spec) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              _getSpecificationIcon(spec.iconUrl),
              size: 16,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  spec.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  spec.value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getSpecificationIcon(String iconUrl) {
    switch (iconUrl) {
      case 'expand_icon':
        return Icons.open_in_full;
      case 'camera_icon':
        return Icons.camera_alt;
      case 'storage_icon':
        return Icons.storage;
      case 'battery_icon':
        return Icons.battery_full;
      case 'signal_icon':
        return Icons.signal_cellular_alt;
      case 'processor_icon':
        return Icons.memory;
      case 'display_icon':
        return Icons.display_settings;
      case 'water_icon':
        return Icons.water_drop;
      default:
        return Icons.info_outline;
    }
  }
}

