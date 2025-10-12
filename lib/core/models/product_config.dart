import 'package:equatable/equatable.dart';

class ProductConfig extends Equatable {
  final List<ColorOption> colors;
  final List<StorageOption> storageOptions;

  const ProductConfig({
    required this.colors,
    required this.storageOptions,
  });

  @override
  List<Object?> get props => [colors, storageOptions];

  factory ProductConfig.fromJson(Map<String, dynamic> json) {
    return ProductConfig(
      colors: (json['colors'] as List).map((e) => ColorOption.fromJson(e as Map<String, dynamic>)).toList(),
      storageOptions:
          (json['storageOptions'] as List).map((e) => StorageOption.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'colors': colors.map((e) => e.toJson()).toList(),
      'storageOptions': storageOptions.map((e) => e.toJson()).toList(),
    };
  }
}

class ColorOption extends Equatable {
  final String id;
  final String name;
  final String hexColor;
  final bool isAvailable;

  const ColorOption({
    required this.id,
    required this.name,
    required this.hexColor,
    this.isAvailable = true,
  });

  @override
  List<Object?> get props => [id, name, hexColor, isAvailable];

  factory ColorOption.fromJson(Map<String, dynamic> json) {
    return ColorOption(
      id: json['id'] as String,
      name: json['name'] as String,
      hexColor: json['hexColor'] as String,
      isAvailable: json['isAvailable'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'hexColor': hexColor,
      'isAvailable': isAvailable,
    };
  }
}

class StorageOption extends Equatable {
  final String id;
  final String capacity;
  final bool isAvailable;
  final int? priceDifference;

  const StorageOption({
    required this.id,
    required this.capacity,
    this.isAvailable = true,
    this.priceDifference,
  });

  @override
  List<Object?> get props => [id, capacity, isAvailable, priceDifference];

  factory StorageOption.fromJson(Map<String, dynamic> json) {
    return StorageOption(
      id: json['id'] as String,
      capacity: json['capacity'] as String,
      isAvailable: json['isAvailable'] as bool? ?? true,
      priceDifference: json['priceDifference'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'capacity': capacity,
      'isAvailable': isAvailable,
      'priceDifference': priceDifference,
    };
  }
}

