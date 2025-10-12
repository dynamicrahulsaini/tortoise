import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tortoise_assignment/core/models/product_tax_info.dart';
import 'package:tortoise_assignment/core/navigation/navigation_service.dart';
import 'package:tortoise_assignment/core/theme/app_colors.dart';
import 'package:tortoise_assignment/core/theme/text_style.dart';
import 'package:tortoise_assignment/core/models/product.dart';

class NetIncomeBottomSheet extends StatefulWidget {
  final Product product;

  const NetIncomeBottomSheet({
    super.key,
    required this.product,
  });

  @override
  State<NetIncomeBottomSheet> createState() => _NetIncomeBottomSheetState();

  static void show(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => NetIncomeBottomSheet(product: product),
    );
  }
}

class _NetIncomeBottomSheetState extends State<NetIncomeBottomSheet> {
  late String selectedTaxSlab;
  bool isExtraInfoExpanded = false;

  @override
  void initState() {
    super.initState();
    selectedTaxSlab = '${widget.product.pricing.currentTaxSlab.percentage}%';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          spacing: 30,
          children: [
            Text(
              'EFFECTIVE PRICE',
              style: AppTypography.leadingText.copyWith(color: AppColors.black5),
            ),
            const Text(
              'The effective price is the device’s cost after savings, based on your payroll structure',
              style: AppTypography.p2Medium,
              textAlign: TextAlign.center,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.black1,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.black1, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFEEEEEE).withOpacity(0.35),
                    offset: const Offset(0, 6.54),
                    blurRadius: 19.61,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: const Color(0xFF42474C).withOpacity(0.06),
                    offset: const Offset(0, 3.27),
                    blurRadius: 6.54,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: const Color(0xFF42474C).withOpacity(0.32),
                    offset: const Offset(0, 0.82),
                    blurRadius: 0.82,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                spacing: 12,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tax slab',
                            style: AppTypography.p2Semibold,
                          ),
                          Text(
                            'Monthly impact: ₹${_getSelectedTaxInfo()?.monthlyDeduction ?? widget.product.pricing.currentTaxSlab.impactOnMonthlySalary}',
                            style: AppTypography.p4Medium.copyWith(
                              color: AppColors.textPrimary.withAlpha(100),
                            ),
                          ),
                        ],
                      ),
                      _buildTaxSlabDropdown(),
                    ],
                  ),
                  divider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Effective price of the device',
                              style: AppTypography.p2Semibold.copyWith(color: AppColors.primary8),
                            ),
                            Text(
                              'Price calculation based on selected tax slab',
                              style: AppTypography.p4Medium.copyWith(color: AppColors.textPrimary.withAlpha(100)),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '₹ ${_getSelectedTaxInfo()?.effectivePrice.toStringAsFixed(0) ?? widget.product.pricing.effectivePrice.toStringAsFixed(0)}',
                        style: AppTypography.p2Semibold.copyWith(color: AppColors.primary8),
                      )
                    ],
                  ),
                  divider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Impact in monthly in-hand',
                              style: AppTypography.p2Semibold,
                            ),
                            Text(
                              'You monthly in-hand salary will be reduced by this amount',
                              style: AppTypography.p4Medium.copyWith(color: AppColors.textPrimary.withAlpha(100)),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '₹ ${_getSelectedTaxInfo()?.monthlyDeduction.toStringAsFixed(0) ?? widget.product.pricing.monthlyDeduction.toStringAsFixed(0)}*',
                        style: AppTypography.p2Semibold.copyWith(color: AppColors.black9),
                      )
                    ],
                  ),
                  // Animated extra information section
                  ClipRect(
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      alignment: Alignment.topCenter,
                      heightFactor: isExtraInfoExpanded ? 1.0 : 0.0,
                      child: _buildExtraInfoSection(),
                    ),
                  ),

                  // Toggle button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExtraInfoExpanded = !isExtraInfoExpanded;
                      });
                    },
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
                              isExtraInfoExpanded ? 'Show less' : 'Know more',
                              key: ValueKey(isExtraInfoExpanded),
                              style: AppTypography.p3Semibold.copyWith(color: AppColors.primary9),
                            ),
                          ),
                          const SizedBox(width: 4),
                          AnimatedRotation(
                            duration: const Duration(milliseconds: 300),
                            turns: isExtraInfoExpanded ? 0.5 : 0.0,
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
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => NavigationService.pop(),
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
                  'Got it!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  divider() => const DottedLine(
        lineThickness: 1,
        dashGapLength: 5,
        dashLength: 5,
        dashColor: AppColors.black3,
      );

  double _calculateTaxAmount() {
    final devicePrice = widget.product.pricing.devicePrice;
    final taxPercentage = widget.product.pricing.currentTaxSlab.percentage;
    return (devicePrice * taxPercentage) / 100;
  }

  ProductTaxInfo? _getSelectedTaxInfo() {
    // Find the tax info for the currently selected tax slab
    final selectedPercentage = double.parse(selectedTaxSlab.replaceAll('%', ''));
    return widget.product.taxSlabInfo.firstWhere(
      (info) => info.taxSlab.percentage == selectedPercentage,
      orElse: () => widget.product.taxSlabInfo.first,
    );
  }

  Widget _buildExtraInfoSection() {
    return Column(
      spacing: 16,
      children: [
        divider(),

        // Additional pricing breakdown
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Base price',
                    style: AppTypography.p2Semibold,
                  ),
                  Text(
                    'Original device cost before discounts',
                    style: AppTypography.p4Medium.copyWith(
                      color: AppColors.textPrimary.withAlpha(100),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '₹ ${widget.product.pricing.devicePrice.toStringAsFixed(0)}',
              style: AppTypography.p2Semibold.copyWith(color: AppColors.black9),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Corporate discount',
                    style: AppTypography.p2Semibold,
                  ),
                  Text(
                    'Savings through corporate partnership',
                    style: AppTypography.p4Medium.copyWith(
                      color: AppColors.textPrimary.withAlpha(100),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '-₹ 2,000',
              style: AppTypography.p2Semibold.copyWith(color: AppColors.green8),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tax (${selectedTaxSlab})',
                    style: AppTypography.p2Semibold,
                  ),
                  Text(
                    'GST applied on device price',
                    style: AppTypography.p4Medium.copyWith(
                      color: AppColors.textPrimary.withAlpha(100),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '₹ ${_getSelectedTaxInfo()?.taxAmount.toStringAsFixed(0) ?? _calculateTaxAmount().toStringAsFixed(0)}',
              style: AppTypography.p2Semibold.copyWith(color: AppColors.black9),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Monthly salary impact (${selectedTaxSlab})',
                    style: AppTypography.p2Semibold,
                  ),
                  Text(
                    'Based on selected tax slab',
                    style: AppTypography.p4Medium.copyWith(
                      color: AppColors.textPrimary.withAlpha(100),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '₹ ${_getSelectedTaxInfo()?.monthlyDeduction.toStringAsFixed(0) ?? widget.product.pricing.currentTaxSlab.impactOnMonthlySalary.toStringAsFixed(0)}',
              style: AppTypography.p2Semibold.copyWith(color: AppColors.green8),
            ),
          ],
        ),
        divider(),
      ],
    );
  }

  Widget _buildTaxSlabDropdown() {
    return GestureDetector(
      onTap: () => _showTaxSlabOptions(),
      child: Row(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            selectedTaxSlab,
            style: AppTypography.p2Semibold,
          ),
          const PhosphorIcon(
            PhosphorIconsFill.caretDown,
            size: 16,
            color: AppColors.textPrimary,
          ),
        ],
      ),
    );
  }

  void _showTaxSlabOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.grey300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select Tax Slab',
              style: AppTypography.h4,
            ),
            const SizedBox(height: 16),
            ...widget.product.taxSlabInfo.map((taxInfo) {
              final slabText = '${taxInfo.taxSlab.percentage}%';
              return ListTile(
                title: Text(
                  slabText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Monthly impact: ₹${taxInfo.monthlyDeduction}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      'Effective price: ₹${taxInfo.effectivePrice}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                trailing: selectedTaxSlab == slabText
                    ? const PhosphorIcon(
                        PhosphorIconsFill.check,
                        color: AppColors.primary,
                        size: 20,
                      )
                    : null,
                onTap: () {
                  setState(() {
                    selectedTaxSlab = slabText;
                  });
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
