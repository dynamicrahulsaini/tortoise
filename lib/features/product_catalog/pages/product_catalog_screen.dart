import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:tortoise_assignment/core/models/catalog_product_info.dart';
import 'package:tortoise_assignment/core/theme/text_style.dart';
import '../../../core/theme/app_colors.dart';
import '../bloc/product_catalog_bloc.dart';
import '../bloc/product_catalog_event.dart';
import '../bloc/product_catalog_state.dart';
import '../widgets/product_card.dart';
import '../widgets/brand_filter_chip.dart';
import '../../product_detail/pages/product_detail_screen.dart';

class ProductCatalogScreen extends StatefulWidget {
  const ProductCatalogScreen({super.key});

  @override
  State<ProductCatalogScreen> createState() => _ProductCatalogScreenState();
}

class _ProductCatalogScreenState extends State<ProductCatalogScreen> {
  final TextEditingController _searchController = TextEditingController();
  int? _selectedBrandId;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCatalogBloc, ProductCatalogState>(
      listener: (context, state) {
        if (state is ProductCatalogError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            toolbarHeight: 72,
            backgroundColor: AppColors.background,
            elevation: 0,
            leading: IconButton(
              icon: const PhosphorIcon(PhosphorIconsFill.caretCircleLeft, color: AppColors.black3),
              onPressed: () {
                // Non-functional back button as per requirements
              },
            ),
            title: SizedBox(
              height: 60,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.black10.withAlpha(13),
                  hintText: 'Search products...',
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  prefixIcon: Row(
                    spacing: 12,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: PhosphorIcon(
                          PhosphorIconsRegular.magnifyingGlass,
                          color: AppColors.black10,
                          size: 20,
                        ),
                      ),
                      if (_selectedBrandId != null)
                        Container(
                          height: 36,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            spacing: 10,
                            children: [
                              Text(
                                context
                                    .read<ProductCatalogBloc>()
                                    .availableBrands
                                    .firstWhere((brand) => brand.id == _selectedBrandId)
                                    .name,
                                style: const TextStyle(
                                  color: AppColors.black10,
                                  fontSize: 16,
                                  height: 20 / 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedBrandId = null;
                                    _searchController.clear();
                                  });
                                  context.read<ProductCatalogBloc>().add(const FilterByBrand('All'));
                                },
                                child: const PhosphorIcon(
                                  PhosphorIconsFill.xCircle,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onChanged: (value) {
                  context.read<ProductCatalogBloc>().add(SearchProducts(value));
                },
              ),
            ),
            centerTitle: true,
          ),
          body: Container(
            padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
            child: Column(
              spacing: 30,
              children: [
                _buildBrandFilters(state),
                Expanded(
                  child: _buildProductsContent(state),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductsContent(ProductCatalogState state) {
    if (state is ProductCatalogLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      );
    }

    if (state is ProductCatalogError) {
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
            Text(
              state.message,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<ProductCatalogBloc>().add(const LoadProducts());
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

    if (state is ProductCatalogLoaded) {
      return _buildProductsGrid(state.products);
    }

    return const SizedBox.shrink();
  }

  Widget _buildBrandFilters(ProductCatalogState state) {
    final bloc = context.read<ProductCatalogBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Search from popular brands',
          style: TextStyle(
            fontFamily: AppTypography.hafferXH,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 76,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: bloc.availableBrands.length,
            itemBuilder: (context, index) {
              final brand = bloc.availableBrands[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: BrandFilterChip(
                  brand: brand.name,
                  isSelected: _selectedBrandId == brand.id,
                  onTap: () {
                    if (state is ProductCatalogLoading) return;
                    setState(() {
                      _selectedBrandId = brand.id;
                    });
                    context.read<ProductCatalogBloc>().add(FilterByBrand(brand.name));
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildProductsGrid(List<CatalogProductInfo> products) {
    if (products.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: AppColors.grey400,
            ),
            SizedBox(height: 16),
            Text(
              'No products found',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Available devices',
          style: TextStyle(
            fontFamily: AppTypography.hafferXH,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                onTap: () => ProductDetailScreen.route(product.id),
              );
            },
          ),
        ),
      ],
    );
  }
}
