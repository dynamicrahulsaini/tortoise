import 'package:flutter/material.dart';
import 'package:inner_shadow_container/inner_shadow_container.dart';
import 'package:tortoise_assignment/core/constants.dart';
import 'package:tortoise_assignment/core/theme/text_style.dart';
import '../../../core/models/product_config.dart';
import '../../../core/theme/app_colors.dart';

class ConfigSelector extends StatelessWidget {
  final ProductConfig config;
  final String? selectedColorId;
  final String? selectedStorageId;
  final Function(String) onColorSelected;
  final Function(String) onStorageSelected;

  const ConfigSelector({
    super.key,
    required this.config,
    required this.selectedColorId,
    required this.selectedStorageId,
    required this.onColorSelected,
    required this.onStorageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      child: Column(
        spacing: 36,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildColorSelector(),
          _buildStorageSelector(),
        ],
      ),
    );
  }

  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'FINISH',
          style: AppTypography.sectionHeader,
        ),
        const Text(
          'Pick a color',
          style: TextStyle(
            fontSize: 16,
            height: 22 / 16,
            fontWeight: FontWeight.w500,
            color: AppColors.grey900,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: config.colors.map((color) {
            final isSelected = selectedColorId == color.id;
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () => onColorSelected(color.id),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: !designOne
                        ? Border.all(
                            color: isSelected ? AppColors.primary8 : Colors.white,
                            width: isSelected ? 2 : 0,
                          )
                        : null,
                  ),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(int.parse(color.hexColor.replaceFirst('#', '0xFF'))),
                      border: Border.all(
                        color: isSelected && designOne ? AppColors.primary8 : Colors.white,
                        width: isSelected && designOne ? 4 : 2,
                      ),
                    ),
                    child: InnerShadowContainer(
                      width: 40,
                      height: 40,
                      borderRadius: 50,
                      isShadowTopLeft: true,
                      isShadowTopRight: true,
                      blur: 2,
                      backgroundColor: Color(int.parse(color.hexColor.replaceFirst('#', '0xFF'))),
                      offset: const Offset(0, 1.5),
                      shadowColor: Colors.black.withAlpha(20),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStorageSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'STORAGE',
          style: AppTypography.sectionHeader,
        ),
        const Text(
          'How much space do you need?',
          style: TextStyle(
            fontSize: 16,
            height: 22 / 16,
            fontWeight: FontWeight.w500,
            color: AppColors.grey900,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: config.storageOptions.map((storage) {
            final isSelected = selectedStorageId == storage.id;
            return GestureDetector(
              onTap: () => onStorageSelected(storage.id),
              child: Container(
                padding: const EdgeInsets.all(16),
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppColors.green8 : Colors.black.withAlpha(10),
                    width: isSelected ? 2 : 1,
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
                child: Row(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: isSelected ? 5 : 1,
                            color: isSelected ? AppColors.green8 : AppColors.grey300,
                          )),
                    ),
                    Text(
                      storage.capacity,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
