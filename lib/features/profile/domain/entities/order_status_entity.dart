import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class OrderStatusEntity extends Equatable {
  final String id;
  final String title;
  final String iconPath;
  final Color color;
  final int count;

  const OrderStatusEntity({
    required this.id,
    required this.title,
    required this.iconPath,
    required this.color,
    required this.count,
  });

  @override
  List<Object?> get props => [id, title, iconPath, color, count];
}
