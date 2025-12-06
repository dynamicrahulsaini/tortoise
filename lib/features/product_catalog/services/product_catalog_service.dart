import 'dart:async';
import 'package:dio/dio.dart';
import 'package:tortoise_assignment/core/models/available_brand.dart';
import 'package:tortoise_assignment/core/models/catalog_product_info.dart';
import '../../../core/models/product.dart';
import '../../product_detail/repositories/product_detail_repository.dart';

class ProductCatalogService {
  static const String _baseUrl = 'https://procodev.tortoise.pro'; // Replace with actual API base URL
  static const Duration _timeout = Duration(seconds: 30);

  late final Dio _dio;

  ProductCatalogService() {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      sendTimeout: _timeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // Add authentication headers if needed
        'authorization': 'ESmMsCnNom1j8AwoCBOYyqEWc6Db2RvR',
      },
    ));

    // Add interceptors for logging and error handling
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => print('Dio: $obj'),
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {
        // Handle common errors
        if (error.response?.statusCode == 401) {
          // Handle unauthorized access
          print('Unauthorized access - redirect to login');
        }
        handler.next(error);
      },
    ));
  }

  /// Get all available brands from the API
  Future<List<AvailableBrand>> getAvailableBrands() async {
    try {
      final response = await _dio.get('/v1/brand');

      if (response.statusCode == 200) {
        final data = response.data;
        return (data as List).map((e) => AvailableBrand.fromJson(e)).toList();
      } else {
        throw _handleDioError(response);
      }
    } on DioException catch (e) {
      print('API Error getting brands: ${e.message}');
      // Fallback to mock data if API fails
      return [];
    } catch (e) {
      print('Unexpected error getting brands: $e');
      return [];
    }
  }

  /// Get all products from the API
  Future<List<CatalogProductInfo>> getAllProducts() async {
    try {
      final response = await _dio.get('/v2/product', queryParameters: {"limit": 10, "is_featured": true});

      if (response.statusCode == 200) {
        final data = response.data;
        return (data['results'] as List).map((json) => CatalogProductInfo.fromJson(json)).toList();
      } else {
        throw _handleDioError(response);
      }
    } on DioException catch (e) {
      print('API Error getting products: ${e.message}');
      // Fallback to mock data if API fails
      return [];
    } catch (e) {
      print('Unexpected error getting products: $e');
      return [];
    }
  }

  /// Get products filtered by brand from the API
  Future<List<Product>> getProductsByBrand(String brand) async {
    try {
      final response = await _dio.get('/products', queryParameters: {
        'brand': brand,
      });

      if (response.statusCode == 200) {
        final data = response.data;
        return (data['products'] as List).map((json) => Product.fromJson(json)).toList();
      } else {
        throw _handleDioError(response);
      }
    } on DioException catch (e) {
      print('API Error getting products by brand: ${e.message}');
      // Fallback to mock data if API fails
      return _getMockProductsByBrand(brand);
    } catch (e) {
      print('Unexpected error getting products by brand: $e');
      return _getMockProductsByBrand(brand);
    }
  }

  /// Get a specific product by ID from the API
  Future<Product> getProductById(String productId) async {
    try {
      final response = await _dio.get('/products/$productId');

      if (response.statusCode == 200) {
        final data = response.data;
        return Product.fromJson(data['product']);
      } else {
        throw _handleDioError(response);
      }
    } on DioException catch (e) {
      print('API Error getting product by ID: ${e.message}');
      // Fallback to mock data if API fails
      return _getMockProductById(productId);
    } catch (e) {
      print('Unexpected error getting product by ID: $e');
      return _getMockProductById(productId);
    }
  }

  /// Get product categories from the API
  Future<List<String>> getProductCategories() async {
    try {
      final response = await _dio.get('/categories');

      if (response.statusCode == 200) {
        final data = response.data;
        return List<String>.from(data['categories'] ?? []);
      } else {
        throw _handleDioError(response);
      }
    } on DioException catch (e) {
      print('API Error getting categories: ${e.message}');
      // Fallback to mock data if API fails
      return [];
    } catch (e) {
      print('Unexpected error getting categories: $e');
      return [];
    }
  }

  /// Handle Dio API errors
  Exception _handleDioError(Response response) {
    String message;
    switch (response.statusCode) {
      case 400:
        message = 'Bad Request: Invalid parameters';
        break;
      case 401:
        message = 'Unauthorized: Authentication required';
        break;
      case 403:
        message = 'Forbidden: Access denied';
        break;
      case 404:
        message = 'Not Found: Resource not available';
        break;
      case 500:
        message = 'Internal Server Error: Server error occurred';
        break;
      default:
        message = 'API Error: Status code ${response.statusCode}';
    }
    return Exception('$message\nResponse: ${response.data}');
  }

  List<Product> _getMockProductsByBrand(String brand) {
    final products = ProductDetailRepository.generateMockProducts().values.toList();
    if (brand.toLowerCase() == 'all') {
      return products;
    }
    return products.where((product) => product.brand.toLowerCase() == brand.toLowerCase()).toList();
  }

  Product _getMockProductById(String productId) {
    final products = ProductDetailRepository.generateMockProducts();
    if (products.containsKey(productId)) {
      return products[productId]!;
    }
    throw Exception('Product not found: $productId');
  }
}
