import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tortoise_assignment/core/theme/text_style.dart';
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SPECIFICATIONS',
            style: AppTypography.sectionHeader,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
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
              spacing: 16,
              children: [
                ...specifications.take(5).map((spec) => _buildSpecificationItem(spec)),
                if (hasMoreSpecs) ...[
                  ClipRect(
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      alignment: Alignment.topCenter,
                      heightFactor: isExpanded ? 1.0 : 0.0,
                      child: Column(
                        spacing: 16,
                        children: specifications.skip(5).map((spec) => _buildSpecificationItem(spec)).toList(),
                      ),
                    ),
                  ),
                  const Divider(color: AppColors.black3, height: 1),
                  GestureDetector(
                    onTap: onToggleExpanded,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: Text(
                              isExpanded ? 'Show less' : 'More details',
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
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecificationItem(Specification spec) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Icon(
          _getSpecificationIcon(spec.iconUrl),
          size: 20,
          color: Colors.black,
        ),
        Expanded(
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                spec.name,
                style: AppTypography.p2Semibold,
              ),
              Text(
                spec.value,
                style: const TextStyle(
                  fontSize: 12,
                  height: 18 / 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black7,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getSpecificationIcon(String iconUrl) {
    switch (iconUrl) {
      case 'expand_icon':
        return PhosphorIconsRegular.arrowsOutSimple;
      // return Icons.open_in_full;
      case 'camera_icon':
        return PhosphorIconsRegular.camera;
      case 'storage_icon':
        return PhosphorIconsRegular.database;
      case 'battery_icon':
        return PhosphorIconsRegular.batteryEmpty;
      case 'signal_icon':
        return PhosphorIconsRegular.cellSignalFull;
      case 'processor_icon':
        return PhosphorIconsRegular.cpu;
      case 'display_icon':
        return PhosphorIconsRegular.monitor;
      case 'water_icon':
        return PhosphorIconsRegular.drop;
      default:
        return PhosphorIconsRegular.info;
    }
  }
}
