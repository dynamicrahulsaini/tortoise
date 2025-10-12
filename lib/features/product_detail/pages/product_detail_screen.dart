import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tortoise_assignment/features/product_detail/repositories/product_detail_repository.dart';
import '../../../core/navigation/navigation_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/tax_slab.dart';
import '../bloc/product_detail_bloc.dart';
import '../bloc/product_detail_event.dart';
import '../bloc/product_detail_state.dart';
import '../widgets/image_carousel.dart';
import '../widgets/config_selector.dart';
import '../widgets/specifications_section.dart';
import '../widgets/description_images_section.dart';
import '../widgets/price_bottom_bar.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  static route(String productId) => NavigationService.push(MaterialPageRoute(
        builder: (context) => BlocProvider<ProductDetailBloc>(
          create: (context) => ProductDetailBloc(
            ProductDetailRepository(),
          ),
          child: ProductDetailScreen(productId: productId),
        ),
      ));

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailBloc>().add(LoadProductDetail(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailBloc, ProductDetailState>(
      listener: (context, state) {
        if (state is ProductDetailError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final bloc = context.read<ProductDetailBloc>();

        return Scaffold(
          appBar: bloc.product != null
              ? AppBar(
                  backgroundColor: Colors.white,
                  leading: GestureDetector(
                    onTap: () => NavigationService.pop(),
                    child: const PhosphorIcon(
                      PhosphorIconsFill.caretCircleLeft,
                      color: AppColors.black3,
                      size: 24,
                    ),
                  ),
                  centerTitle: true,
                  title: Text(
                    bloc.product!.name,
                    style: const TextStyle(
                      fontSize: 20,
                      height: 42 / 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                )
              : null,
          body: (bloc.product == null)
              ? (state is ProductDetailLoading)
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : _buildErrorState()
              : Stack(
                  children: [
                    _buildProductDetail(),
                    if (state is ProductDetailLoading)
                      Container(
                        color: Colors.black.withOpacity(0.3),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: AppColors.error,
          ),
          const SizedBox(height: 16),
          const Text(
            'Failed to load product details',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<ProductDetailBloc>().add(LoadProductDetail(widget.productId));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetail() {
    final product = context.read<ProductDetailBloc>().product!;
    final state = context.read<ProductDetailBloc>().state;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              spacing: 30,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildShippingInfo(product.deliveryInfo),
                    _buildImageCarousel(product.imageUrls),
                    _buildProtectedStrip(),
                  ],
                ),
                ConfigSelector(
                  config: product.config,
                  selectedColorId: product.selectedColorId,
                  selectedStorageId: product.selectedStorageId,
                  onColorSelected: (colorId) {
                    context.read<ProductDetailBloc>().add(SelectColor(colorId));
                  },
                  onStorageSelected: (storageId) {
                    context.read<ProductDetailBloc>().add(SelectStorage(storageId));
                  },
                ),
                SpecificationsSection(
                  specifications: product.specifications,
                  isExpanded: state.isSpecificationsExpanded,
                  onToggleExpanded: () {
                    context.read<ProductDetailBloc>().add(const ToggleSpecificationsExpanded());
                  },
                ),
                DescriptionImagesSection(
                  imageUrls: product.descriptionImageUrls,
                  isExpanded: state.isDescriptionImagesExpanded,
                  onToggleExpanded: () {
                    context.read<ProductDetailBloc>().add(const ToggleDescriptionImagesExpanded());
                  },
                ),
                const SizedBox(height: 100), // Space for bottom bar
              ],
            ),
          ),
        ),
        PriceBottomBar(
          product: product,
          onAddToCart: () {
            _showAddToCartDialog(product);
          },
          onTaxSlabTap: () {
            _showTaxSlabDialog(product.pricing.currentTaxSlab);
          },
        ),
      ],
    );
  }

  Widget _buildShippingInfo(dynamic deliveryInfo) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFFFAF4EA),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const PhosphorIcon(
            PhosphorIconsRegular.truck,
            color: AppColors.yellow9,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            deliveryInfo.message,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.yellow9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCarousel(List<String> imageUrls) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ImageCarousel(imageUrls: imageUrls),
    );
  }

  Widget _buildProtectedStrip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: AppColors.primary10,
      child: Row(
        spacing: 18,
        children: [
          SvgPicture.asset(
            'assets/icons/protected_shield.svg',
          ),
          const Text(
            'Protected with Tortoise Corporate Care',
            style: TextStyle(
              fontSize: 14,
              height: 20 / 14,
              color: AppColors.primary3,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddToCartDialog(dynamic product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add to Cart'),
        content: Text('${product.name} has been added to your cart!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showTaxSlabDialog(TaxSlab currentTaxSlab) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('EFFECTIVE PRICE'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'The effective price is the device\'s cost after savings, based on your payroll structure.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.grey100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tax slab'),
                      DropdownButton<TaxSlab>(
                        value: currentTaxSlab,
                        items: TaxSlab.availableTaxSlabs.map((slab) {
                          return DropdownMenuItem(
                            value: slab,
                            child: Text(slab.name),
                          );
                        }).toList(),
                        onChanged: (TaxSlab? newSlab) {
                          if (newSlab != null) {
                            context.read<ProductDetailBloc>().add(UpdateTaxSlab(newSlab));
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Effective price of the device'),
                      Text(
                        '₹ ${currentTaxSlab.impactOnMonthlySalary.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}*',
                        style: const TextStyle(
                          color: AppColors.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Impact in monthly in-hand'),
                      Text(
                        '₹ ${currentTaxSlab.impactOnMonthlySalary.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}*',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Okay! Understood'),
          ),
        ],
      ),
    );
  }
}
