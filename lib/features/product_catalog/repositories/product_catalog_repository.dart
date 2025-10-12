import 'dart:async';
import '../../../core/models/product.dart';
import '../../../core/models/delivery_info.dart';
import '../../../core/models/product_config.dart';
import '../../../core/models/specification.dart';
import '../../../core/models/product_pricing.dart';
import '../../../core/models/tax_slab.dart';

class ProductCatalogRepository {
  static final List<Product> _mockProducts = _generateMockProducts();

  Future<List<Product>> getProductsByBrand(String brand) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    if (brand.toLowerCase() == 'all') {
      return List.from(_mockProducts);
    }

    return _mockProducts.where((product) => product.brand.toLowerCase() == brand.toLowerCase()).toList();
  }

  Future<List<Product>> getAllProducts() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    return List.from(_mockProducts);
  }

  static List<Product> _generateMockProducts() {
    return [
      Product(
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
        ],
        descriptionImageUrls: const [
          'https://via.placeholder.com/400x600/000000/FFFFFF?text=Apple+Intelligence',
          'https://via.placeholder.com/400x600/4A90E2/FFFFFF?text=Design+Features',
          'https://via.placeholder.com/400x600/F2F2F7/000000?text=Camera+Control',
        ],
        pricing: ProductPricing(
          devicePrice: 138963,
          effectivePrice: 92483,
          monthlyDeduction: 8900,
          currentTaxSlab: TaxSlab.availableTaxSlabs[2], // 30%
        ),
        selectedColorId: 'space-black',
        selectedStorageId: '128gb',
      ),
      Product(
        id: 'iphone-16-pro-max',
        name: 'iPhone 16 Pro Max',
        brand: 'Apple',
        category: 'Smartphone',
        imageUrls: const [
          'https://www.figma.com/file/lOmYlCgWmvXpYhCtoWlWGh/image/41b7c0c762b471e8bffbf1850985925675d7b315',
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
      ),
      Product(
        id: 'macbook-pro-16',
        name: 'MacBook Pro 16-inch',
        brand: 'Apple',
        category: 'Laptop',
        imageUrls: const [
          'https://www.figma.com/file/lOmYlCgWmvXpYhCtoWlWGh/image/2a3ef41815a26fd48fc2d255fedab2f9e3f9fa19',
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
      ),
      Product(
        id: 'pixel-8-pro',
        name: 'Pixel 8 Pro',
        brand: 'Google',
        category: 'Smartphone',
        imageUrls: const [
          'data:image/webp;base64,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',
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
      ),
    ];
  }
}
