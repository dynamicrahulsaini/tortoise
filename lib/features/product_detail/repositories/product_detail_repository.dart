import 'dart:async';
import '../../../core/models/product.dart';
import '../../../core/models/delivery_info.dart';
import '../../../core/models/product_config.dart';
import '../../../core/models/specification.dart';
import '../../../core/models/product_pricing.dart';
import '../../../core/models/tax_slab.dart';

class ProductDetailRepository {
  static final Map<String, Product> _mockProducts = _generateMockProducts();

  Future<Product> getProductById(String productId) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    if (_mockProducts.containsKey(productId)) {
      return _mockProducts[productId]!;
    }

    throw Exception('Product not found');
  }

  Future<Product> updateProductConfiguration({
    required String productId,
    String? selectedColorId,
    String? selectedStorageId,
    TaxSlab? taxSlab,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    final product = _mockProducts[productId];
    if (product == null) {
      throw Exception('Product not found');
    }

    // Calculate new pricing based on tax slab
    ProductPricing newPricing = product.pricing;
    if (taxSlab != null) {
      // Simple calculation for effective price based on tax slab
      final taxSavings = (product.pricing.devicePrice * taxSlab.percentage / 100).round();
      newPricing = product.pricing.copyWith(
        currentTaxSlab: taxSlab,
        effectivePrice: product.pricing.devicePrice - taxSavings,
        monthlyDeduction: (taxSavings / 12).round(),
      );
    }

    final updatedProduct = product.copyWith(
      selectedColorId: selectedColorId ?? product.selectedColorId,
      selectedStorageId: selectedStorageId ?? product.selectedStorageId,
      pricing: newPricing,
    );

    // Update the mock data
    _mockProducts[productId] = updatedProduct;

    return updatedProduct;
  }

  static Map<String, Product> _generateMockProducts() {
    final products = <String, Product>{};

    // iPhone 16 Pro
    products['iphone-16-pro'] = Product(
      id: 'iphone-16-pro',
      name: 'iPhone 16 Pro',
      brand: 'Apple',
      category: 'Smartphone',
      imageUrls: const [
        'https://www.figma.com/file/lOmYlCgWmvXpYhCtoWlWGh/image/b7ddebecd3e65907db54f14b5393b27d2595cd42',
        'https://via.placeholder.com/300x300/4A90E2/FFFFFF?text=iPhone+16+Pro+Blue',
        'https://via.placeholder.com/300x300/F2F2F7/000000?text=iPhone+16+Pro+White',
      ],
      deliveryInfo: const DeliveryInfo(
        message: 'Shipping starts from 19th September onwards',
        iconUrl: 'truck_icon',
      ),
      config: const ProductConfig(
        colors: [
          ColorOption(id: 'space-black', name: 'Space Black', hexColor: '#1C1C1E'),
          ColorOption(id: 'natural-titanium', name: 'Natural Titanium', hexColor: '#F2F2F7'),
          ColorOption(id: 'blue-titanium', name: 'Blue Titanium', hexColor: '#4A90E2'),
          ColorOption(id: 'white-titanium', name: 'White Titanium', hexColor: '#F9F9F9'),
        ],
        storageOptions: [
          StorageOption(id: '128gb', capacity: '128 GB'),
          StorageOption(id: '256gb', capacity: '256 GB'),
          StorageOption(id: '512gb', capacity: '512 GB'),
          StorageOption(id: '1tb', capacity: '1 TB'),
        ],
      ),
      specifications: const [
        Specification(
          id: 'screen-size',
          name: 'Screen size',
          value: '6.3 inches',
          iconUrl: 'expand_icon',
        ),
        Specification(
          id: 'camera',
          name: 'Camera',
          value: 'Rear facing: 48 MP',
          iconUrl: 'camera_icon',
        ),
        Specification(
          id: 'storage-ram',
          name: 'Storage and RAM',
          value: '8 GB | 512 GB',
          iconUrl: 'storage_icon',
        ),
        Specification(
          id: 'battery',
          name: 'Battery',
          value: 'Up to 27 hours video playback',
          iconUrl: 'battery_icon',
        ),
        Specification(
          id: 'connectivity',
          name: 'Connectivity',
          value: '5G',
          iconUrl: 'signal_icon',
        ),
        Specification(
          id: 'processor',
          name: 'Processor',
          value: 'A18 Pro chip',
          iconUrl: 'processor_icon',
        ),
        Specification(
          id: 'display',
          name: 'Display',
          value: 'Super Retina XDR',
          iconUrl: 'display_icon',
        ),
        Specification(
          id: 'water-resistance',
          name: 'Water Resistance',
          value: 'IP68',
          iconUrl: 'water_icon',
        ),
      ],
      descriptionImageUrls: const [
        'https://m.media-amazon.com/images/G/31/img25/Wireless/Madhav/Feb/Apple/River/16/iPhone_16_Marketing_Page_Flex_Module_Avail_Amazon_Desktop_1500px__en-IN_01._CB547243914_.jpg',
        'https://m.media-amazon.com/images/G/31/img25/Wireless/Madhav/Feb/Apple/River/16/iPhone_16_Marketing_Page_Flex_Module_Avail_Amazon_Desktop_1500px__en-IN_02._CB547243914_.jpg',
        'https://m.media-amazon.com/images/G/31/img25/Wireless/Madhav/Feb/Apple/River/16/iPhone_16_Marketing_Page_Flex_Module_Avail_Amazon_Desktop_1500px__en-IN_03._CB547243914_.jpg',
        'https://m.media-amazon.com/images/G/31/img25/Wireless/Madhav/Feb/Apple/River/16/iPhone_16_Marketing_Page_Flex_Module_Avail_Amazon_Desktop_1500px__en-IN_04._CB547243914_.jpg',
        'https://m.media-amazon.com/images/G/31/img25/Wireless/Madhav/Feb/Apple/River/16/iPhone_16_Marketing_Page_Flex_Module_Avail_Amazon_Desktop_1500px__en-IN_05._CB547243914_.jpg',
      ],
      pricing: ProductPricing(
        devicePrice: 138963,
        effectivePrice: 92483,
        monthlyDeduction: 8900,
        currentTaxSlab: TaxSlab.availableTaxSlabs[2], // 30%
      ),
      selectedColorId: 'space-black',
      selectedStorageId: '128gb',
    );

    // iPhone 16 Pro Max
    products['iphone-16-pro-max'] = Product(
      id: 'iphone-16-pro-max',
      name: 'iPhone 16 Pro Max',
      brand: 'Apple',
      category: 'Smartphone',
      imageUrls: const [
        'https://via.placeholder.com/300x300/000000/FFFFFF?text=iPhone+16+Pro+Max',
        'https://via.placeholder.com/300x300/4A90E2/FFFFFF?text=iPhone+16+Pro+Max+Blue',
      ],
      deliveryInfo: const DeliveryInfo(
        message: 'Shipping starts from 19th September onwards',
        iconUrl: 'truck_icon',
      ),
      config: const ProductConfig(
        colors: [
          ColorOption(id: 'space-black', name: 'Space Black', hexColor: '#1C1C1E'),
          ColorOption(id: 'natural-titanium', name: 'Natural Titanium', hexColor: '#F2F2F7'),
          ColorOption(id: 'blue-titanium', name: 'Blue Titanium', hexColor: '#4A90E2'),
        ],
        storageOptions: [
          StorageOption(id: '256gb', capacity: '256 GB'),
          StorageOption(id: '512gb', capacity: '512 GB'),
          StorageOption(id: '1tb', capacity: '1 TB'),
        ],
      ),
      specifications: const [
        Specification(
          id: 'screen-size',
          name: 'Screen size',
          value: '6.9 inches',
          iconUrl: 'expand_icon',
        ),
        Specification(
          id: 'camera',
          name: 'Camera',
          value: 'Rear facing: 48 MP',
          iconUrl: 'camera_icon',
        ),
        Specification(
          id: 'storage-ram',
          name: 'Storage and RAM',
          value: '8 GB | 1 TB',
          iconUrl: 'storage_icon',
        ),
        Specification(
          id: 'battery',
          name: 'Battery',
          value: 'Up to 22 hours video playback',
          iconUrl: 'battery_icon',
        ),
        Specification(
          id: 'connectivity',
          name: 'Connectivity',
          value: '5G',
          iconUrl: 'signal_icon',
        ),
      ],
      descriptionImageUrls: const [
        'https://via.placeholder.com/400x600/000000/FFFFFF?text=Pro+Max+Features',
      ],
      pricing: ProductPricing(
        devicePrice: 159963,
        effectivePrice: 106483,
        monthlyDeduction: 10900,
        currentTaxSlab: TaxSlab.availableTaxSlabs[2], // 30%
      ),
      selectedColorId: 'space-black',
      selectedStorageId: '256gb',
    );

    // MacBook Pro 16-inch
    products['macbook-pro-16'] = Product(
      id: 'macbook-pro-16',
      name: 'MacBook Pro 16-inch',
      brand: 'Apple',
      category: 'Laptop',
      imageUrls: const [
        'https://via.placeholder.com/300x300/000000/FFFFFF?text=MacBook+Pro',
      ],
      deliveryInfo: const DeliveryInfo(
        message: 'Shipping will begin in 3-4 weeks',
        iconUrl: 'truck_icon',
      ),
      config: const ProductConfig(
        colors: [
          ColorOption(id: 'space-gray', name: 'Space Gray', hexColor: '#1C1C1E'),
          ColorOption(id: 'silver', name: 'Silver', hexColor: '#F2F2F7'),
        ],
        storageOptions: [
          StorageOption(id: '512gb', capacity: '512 GB'),
          StorageOption(id: '1tb', capacity: '1 TB'),
          StorageOption(id: '2tb', capacity: '2 TB'),
        ],
      ),
      specifications: const [
        Specification(
          id: 'screen-size',
          name: 'Screen size',
          value: '16.2 inches',
          iconUrl: 'expand_icon',
        ),
        Specification(
          id: 'processor',
          name: 'Processor',
          value: 'M3 Pro chip',
          iconUrl: 'processor_icon',
        ),
        Specification(
          id: 'storage-ram',
          name: 'Storage and RAM',
          value: '18 GB | 1 TB',
          iconUrl: 'storage_icon',
        ),
        Specification(
          id: 'battery',
          name: 'Battery',
          value: 'Up to 22 hours',
          iconUrl: 'battery_icon',
        ),
        Specification(
          id: 'connectivity',
          name: 'Connectivity',
          value: 'Wi-Fi 6E, Bluetooth 5.3',
          iconUrl: 'signal_icon',
        ),
      ],
      descriptionImageUrls: const [
        'https://via.placeholder.com/400x600/000000/FFFFFF?text=MacBook+Features',
      ],
      pricing: ProductPricing(
        devicePrice: 249963,
        effectivePrice: 166483,
        monthlyDeduction: 16900,
        currentTaxSlab: TaxSlab.availableTaxSlabs[2], // 30%
      ),
      selectedColorId: 'space-gray',
      selectedStorageId: '1tb',
    );

    // Pixel 8 Pro
    products['pixel-8-pro'] = Product(
      id: 'pixel-8-pro',
      name: 'Pixel 8 Pro',
      brand: 'Google',
      category: 'Smartphone',
      imageUrls: const [
        'https://via.placeholder.com/300x300/4285F4/FFFFFF?text=Pixel+8+Pro',
      ],
      deliveryInfo: const DeliveryInfo(
        message: 'Shipping starts from 15th October onwards',
        iconUrl: 'truck_icon',
      ),
      config: const ProductConfig(
        colors: [
          ColorOption(id: 'obsidian', name: 'Obsidian', hexColor: '#000000'),
          ColorOption(id: 'porcelain', name: 'Porcelain', hexColor: '#FFFFFF'),
          ColorOption(id: 'bay', name: 'Bay', hexColor: '#4285F4'),
        ],
        storageOptions: [
          StorageOption(id: '128gb', capacity: '128 GB'),
          StorageOption(id: '256gb', capacity: '256 GB'),
          StorageOption(id: '512gb', capacity: '512 GB'),
        ],
      ),
      specifications: const [
        Specification(
          id: 'screen-size',
          name: 'Screen size',
          value: '6.7 inches',
          iconUrl: 'expand_icon',
        ),
        Specification(
          id: 'camera',
          name: 'Camera',
          value: 'Rear facing: 50 MP',
          iconUrl: 'camera_icon',
        ),
        Specification(
          id: 'storage-ram',
          name: 'Storage and RAM',
          value: '12 GB | 256 GB',
          iconUrl: 'storage_icon',
        ),
        Specification(
          id: 'battery',
          name: 'Battery',
          value: 'Up to 24 hours',
          iconUrl: 'battery_icon',
        ),
        Specification(
          id: 'connectivity',
          name: 'Connectivity',
          value: '5G',
          iconUrl: 'signal_icon',
        ),
      ],
      descriptionImageUrls: const [
        'https://via.placeholder.com/400x600/4285F4/FFFFFF?text=Google+Features',
      ],
      pricing: ProductPricing(
        devicePrice: 106999,
        effectivePrice: 71299,
        monthlyDeduction: 7200,
        currentTaxSlab: TaxSlab.availableTaxSlabs[2], // 30%
      ),
      selectedColorId: 'obsidian',
      selectedStorageId: '256gb',
    );

    return products;
  }
}
