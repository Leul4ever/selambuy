import 'package:flutter/material.dart';
import '../../domain/entities/order_status_entity.dart';

class OrderStatusModel extends OrderStatusEntity {
  const OrderStatusModel({
    required super.id,
    required super.title,
    required super.iconPath,
    required super.color,
    required super.count,
  });

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) {
    return OrderStatusModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      iconPath: json['iconPath'] ?? '',
      color: Color(json['color'] ?? 0xFF000000),
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'iconPath': iconPath,
      'color': color.value,
      'count': count,
    };
  }

  factory OrderStatusModel.fromEntity(OrderStatusEntity entity) {
    return OrderStatusModel(
      id: entity.id,
      title: entity.title,
      iconPath: entity.iconPath,
      color: entity.color,
      count: entity.count,
    );
  }
}
