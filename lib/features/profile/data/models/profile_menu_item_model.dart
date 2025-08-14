import '../../domain/entities/profile_menu_item_entity.dart';

class ProfileMenuItemModel extends ProfileMenuItemEntity {
  const ProfileMenuItemModel({
    required super.id,
    required super.title,
    required super.iconPath,
    required super.route,
    super.isEnabled = true,
  });

  factory ProfileMenuItemModel.fromJson(Map<String, dynamic> json) {
    return ProfileMenuItemModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      iconPath: json['iconPath'] ?? '',
      route: json['route'] ?? '',
      isEnabled: json['isEnabled'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'iconPath': iconPath,
      'route': route,
      'isEnabled': isEnabled,
    };
  }

  factory ProfileMenuItemModel.fromEntity(ProfileMenuItemEntity entity) {
    return ProfileMenuItemModel(
      id: entity.id,
      title: entity.title,
      iconPath: entity.iconPath,
      route: entity.route,
      isEnabled: entity.isEnabled,
    );
  }
}
