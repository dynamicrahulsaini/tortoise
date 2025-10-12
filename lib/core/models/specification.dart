import 'package:equatable/equatable.dart';

class Specification extends Equatable {
  final String id;
  final String name;
  final String value;
  final String iconUrl;

  const Specification({
    required this.id,
    required this.name,
    required this.value,
    required this.iconUrl,
  });

  @override
  List<Object?> get props => [id, name, value, iconUrl];

  factory Specification.fromJson(Map<String, dynamic> json) {
    return Specification(
      id: json['id'] as String,
      name: json['name'] as String,
      value: json['value'] as String,
      iconUrl: json['iconUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'iconUrl': iconUrl,
    };
  }
}

