import 'package:equatable/equatable.dart';

class TaxSlab extends Equatable {
  final String id;
  final String name;
  final double percentage;
  final int impactOnMonthlySalary;

  const TaxSlab({
    required this.id,
    required this.name,
    required this.percentage,
    required this.impactOnMonthlySalary,
  });

  @override
  List<Object?> get props => [id, name, percentage, impactOnMonthlySalary];

  factory TaxSlab.fromJson(Map<String, dynamic> json) {
    return TaxSlab(
      id: json['id'] as String,
      name: json['name'] as String,
      percentage: (json['percentage'] as num).toDouble(),
      impactOnMonthlySalary: json['impactOnMonthlySalary'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'percentage': percentage,
      'impactOnMonthlySalary': impactOnMonthlySalary,
    };
  }

  static const List<TaxSlab> availableTaxSlabs = [
    TaxSlab(
      id: '10',
      name: '10%',
      percentage: 10.0,
      impactOnMonthlySalary: 5120,
    ),
    TaxSlab(
      id: '20',
      name: '20%',
      percentage: 20.0,
      impactOnMonthlySalary: 6400,
    ),
    TaxSlab(
      id: '30',
      name: '30%',
      percentage: 30.0,
      impactOnMonthlySalary: 7706,
    ),
  ];
}

