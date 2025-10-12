import 'dart:async';
import '../../../core/models/product.dart';
import '../../../core/models/delivery_info.dart';
import '../../../core/models/product_config.dart';
import '../../../core/models/specification.dart';
import '../../../core/models/product_pricing.dart';
import '../../../core/models/tax_slab.dart';
import '../../../core/models/product_tax_info.dart';

class ProductDetailRepository {
  static final Map<String, Product> _mockProducts = generateMockProducts();

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
      taxSlabInfo: product.taxSlabInfo, // Preserve tax slab info
    );

    // Update the mock data
    _mockProducts[productId] = updatedProduct;

    return updatedProduct;
  }

  static Map<String, Product> generateMockProducts() {
    final products = <String, Product>{};

    // iPhone 16 Pro
    products['iphone-16-pro'] = Product(
      id: 'iphone-16-pro',
      name: 'iPhone 16 Pro',
      brand: 'Apple',
      category: 'Smartphone',
      imageUrls: const [
        'https://www.figma.com/file/lOmYlCgWmvXpYhCtoWlWGh/image/b7ddebecd3e65907db54f14b5393b27d2595cd42',
        'https://www.figma.com/file/lOmYlCgWmvXpYhCtoWlWGh/image/b7ddebecd3e65907db54f14b5393b27d2595cd42',
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
      taxSlabInfo: [
        ProductTaxInfo(
          taxSlab: TaxSlab.availableTaxSlabs[0], // 10%
          effectivePrice: 152859,
          monthlyDeduction: 5120,
          taxAmount: 13896,
          corporateDiscount: 2000,
        ),
        ProductTaxInfo(
          taxSlab: TaxSlab.availableTaxSlabs[1], // 20%
          effectivePrice: 122770,
          monthlyDeduction: 6400,
          taxAmount: 27793,
          corporateDiscount: 2000,
        ),
        ProductTaxInfo(
          taxSlab: TaxSlab.availableTaxSlabs[2], // 30%
          effectivePrice: 92483,
          monthlyDeduction: 8900,
          taxAmount: 41689,
          corporateDiscount: 2000,
        ),
      ],
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
        'https://www.figma.com/file/lOmYlCgWmvXpYhCtoWlWGh/image/b7ddebecd3e65907db54f14b5393b27d2595cd42',
        'https://www.figma.com/file/lOmYlCgWmvXpYhCtoWlWGh/image/b7ddebecd3e65907db54f14b5393b27d2595cd42',
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
        'https://m.media-amazon.com/images/G/31/img25/Wireless/Madhav/Feb/Apple/River/16/iPhone_16_Marketing_Page_Flex_Module_Avail_Amazon_Desktop_1500px__en-IN_01._CB547243914_.jpg',
        'https://m.media-amazon.com/images/G/31/img25/Wireless/Madhav/Feb/Apple/River/16/iPhone_16_Marketing_Page_Flex_Module_Avail_Amazon_Desktop_1500px__en-IN_02._CB547243914_.jpg',
        'https://m.media-amazon.com/images/G/31/img25/Wireless/Madhav/Feb/Apple/River/16/iPhone_16_Marketing_Page_Flex_Module_Avail_Amazon_Desktop_1500px__en-IN_03._CB547243914_.jpg',
        'https://m.media-amazon.com/images/G/31/img25/Wireless/Madhav/Feb/Apple/River/16/iPhone_16_Marketing_Page_Flex_Module_Avail_Amazon_Desktop_1500px__en-IN_04._CB547243914_.jpg',
        'https://m.media-amazon.com/images/G/31/img25/Wireless/Madhav/Feb/Apple/River/16/iPhone_16_Marketing_Page_Flex_Module_Avail_Amazon_Desktop_1500px__en-IN_05._CB547243914_.jpg',
      ],
      pricing: ProductPricing(
        devicePrice: 159963,
        effectivePrice: 106483,
        monthlyDeduction: 10900,
        currentTaxSlab: TaxSlab.availableTaxSlabs[2], // 30%
      ),
      taxSlabInfo: [
        ProductTaxInfo(
          taxSlab: TaxSlab.availableTaxSlabs[0], // 10%
          effectivePrice: 175959,
          monthlyDeduction: 5120,
          taxAmount: 15996,
          corporateDiscount: 2000,
        ),
        ProductTaxInfo(
          taxSlab: TaxSlab.availableTaxSlabs[1], // 20%
          effectivePrice: 141170,
          monthlyDeduction: 6400,
          taxAmount: 31993,
          corporateDiscount: 2000,
        ),
        ProductTaxInfo(
          taxSlab: TaxSlab.availableTaxSlabs[2], // 30%
          effectivePrice: 106483,
          monthlyDeduction: 10900,
          taxAmount: 47989,
          corporateDiscount: 2000,
        ),
      ],
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
        'https://m.media-amazon.com/images/I/71pKJ+Mjd8L._SX679_.jpg',
        'https://m.media-amazon.com/images/I/61wJeelYVaL._SX679_.jpg',
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
        'https://m.media-amazon.com/images/I/71Ms3-J8bXL._SX679_.jpg',
        'https://m.media-amazon.com/images/I/61dHNAMoiFL._SX679_.jpg',
        'https://m.media-amazon.com/images/I/61ovNoIFFsL._SX679_.jpg',
      ],
      pricing: ProductPricing(
        devicePrice: 249963,
        effectivePrice: 166483,
        monthlyDeduction: 16900,
        currentTaxSlab: TaxSlab.availableTaxSlabs[2], // 30%
      ),
      taxSlabInfo: [
        ProductTaxInfo(
          taxSlab: TaxSlab.availableTaxSlabs[0], // 10%
          effectivePrice: 274959,
          monthlyDeduction: 5120,
          taxAmount: 24996,
          corporateDiscount: 2000,
        ),
        ProductTaxInfo(
          taxSlab: TaxSlab.availableTaxSlabs[1], // 20%
          effectivePrice: 221170,
          monthlyDeduction: 6400,
          taxAmount: 49993,
          corporateDiscount: 2000,
        ),
        ProductTaxInfo(
          taxSlab: TaxSlab.availableTaxSlabs[2], // 30%
          effectivePrice: 166483,
          monthlyDeduction: 16900,
          taxAmount: 74989,
          corporateDiscount: 2000,
        ),
      ],
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
        'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcSBkGTDehNnqnUCLNl_6sqEImwi7Rz-h0HLWVlWle3RB9oba8E',
        'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcSBkGTDehNnqnUCLNl_6sqEImwi7Rz-h0HLWVlWle3RB9oba8E',
      ],
      deliveryInfo: const DeliveryInfo(
        message: 'Shipping starts from 15th October onwards',
        iconUrl: 'truck_icon',
      ),
      config: const ProductConfig(
        colors: [
          ColorOption(id: 'bay', name: 'Bay', hexColor: '#4285F4'),
          ColorOption(id: 'obsidian', name: 'Obsidian', hexColor: '#000000'),
          ColorOption(id: 'porcelain', name: 'Porcelain', hexColor: '#FFFFFF'),
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
        'https://m.media-amazon.com/images/G/31/img25/Wireless/Madhav/Feb/Apple/River/16/iPhone_16_Marketing_Page_Flex_Module_Avail_Amazon_Desktop_1500px__en-IN_01._CB547243914_.jpg',
        'https://m.media-amazon.com/images/G/31/img25/Wireless/Madhav/Feb/Apple/River/16/iPhone_16_Marketing_Page_Flex_Module_Avail_Amazon_Desktop_1500px__en-IN_02._CB547243914_.jpg',
        'https://m.media-amazon.com/images/G/31/img25/Wireless/Madhav/Feb/Apple/River/16/iPhone_16_Marketing_Page_Flex_Module_Avail_Amazon_Desktop_1500px__en-IN_03._CB547243914_.jpg',
        'https://m.media-amazon.com/images/G/31/img25/Wireless/Madhav/Feb/Apple/River/16/iPhone_16_Marketing_Page_Flex_Module_Avail_Amazon_Desktop_1500px__en-IN_04._CB547243914_.jpg',
        'https://m.media-amazon.com/images/G/31/img25/Wireless/Madhav/Feb/Apple/River/16/iPhone_16_Marketing_Page_Flex_Module_Avail_Amazon_Desktop_1500px__en-IN_05._CB547243914_.jpg',
      ],
      pricing: ProductPricing(
        devicePrice: 106999,
        effectivePrice: 71299,
        monthlyDeduction: 7200,
        currentTaxSlab: TaxSlab.availableTaxSlabs[2], // 30%
      ),
      taxSlabInfo: [
        ProductTaxInfo(
          taxSlab: TaxSlab.availableTaxSlabs[0], // 10%
          effectivePrice: 117699,
          monthlyDeduction: 5120,
          taxAmount: 10700,
          corporateDiscount: 2000,
        ),
        ProductTaxInfo(
          taxSlab: TaxSlab.availableTaxSlabs[1], // 20%
          effectivePrice: 94199,
          monthlyDeduction: 6400,
          taxAmount: 21400,
          corporateDiscount: 2000,
        ),
        ProductTaxInfo(
          taxSlab: TaxSlab.availableTaxSlabs[2], // 30%
          effectivePrice: 71299,
          monthlyDeduction: 7200,
          taxAmount: 32100,
          corporateDiscount: 2000,
        ),
      ],
      selectedColorId: 'obsidian',
      selectedStorageId: '256gb',
    );

    return products;
  }
}
