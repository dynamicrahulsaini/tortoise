import 'package:flutter/widgets.dart';
import 'package:tortoise_assignment/core/theme/app_colors.dart';

class AppTypography {
  static const String hafferXH = 'HafferXH';

  static const TextStyle sectionHeader = TextStyle(
    fontFamily: hafferXH,
    fontSize: 12,
    letterSpacing: 0.96,
    fontWeight: FontWeight.w600,
    color: AppColors.subText,
  );

  static const TextStyle p2Semibold = TextStyle(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w600,
    color: AppColors.black7,
  );

  static const TextStyle p2Medium = TextStyle(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w500,
    color: AppColors.black7,
  );

  static const TextStyle p3Semibold = TextStyle(
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle leadingText = TextStyle(
    fontFamily: hafferXH,
    fontSize: 12,
    letterSpacing: 0.96, // 8% of 12px
    fontWeight: FontWeight.w600, // SemiBold
    color: AppColors.textPrimary,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: hafferXH,
    fontSize: 18,
    height: 22 / 18, // Line height: 22px
    letterSpacing: 0, // 0%
    fontWeight: FontWeight.w600, // SemiBold
    color: AppColors.textPrimary,
  );

  static const TextStyle p4Medium = TextStyle(
    fontFamily: hafferXH,
    fontSize: 12,
    height: 1.0, // 100% of font size
    letterSpacing: 0, // 0%
    fontWeight: FontWeight.w500, // Medium
    color: AppColors.textPrimary,
  );
}
