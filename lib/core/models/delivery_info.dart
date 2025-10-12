import 'package:equatable/equatable.dart';

// TODO: can remove icon url
class DeliveryInfo extends Equatable {
  final String message;
  final String iconUrl;
  final DateTime? startDate;

  const DeliveryInfo({
    required this.message,
    required this.iconUrl,
    this.startDate,
  });

  @override
  List<Object?> get props => [message, iconUrl, startDate];

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) {
    return DeliveryInfo(
      message: json['message'] as String,
      iconUrl: json['iconUrl'] as String,
      startDate: json['startDate'] != null ? DateTime.parse(json['startDate'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'iconUrl': iconUrl,
      'startDate': startDate?.toIso8601String(),
    };
  }
}

