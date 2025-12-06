import 'package:equatable/equatable.dart';

class AvailableBrand extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final String slug;

  const AvailableBrand({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.slug,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, slug];

  factory AvailableBrand.fromJson(Map<String, dynamic> json) {
    return AvailableBrand(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
      slug: json['slug'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'slug': slug,
    };
  }
  // TODO: can remove this method
  AvailableBrand copyWith({
    int? id,
    String? name,
    String? imageUrl,
    String? slug,
  }) {
    return AvailableBrand(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      slug: slug ?? this.slug,
    );
  }
}
