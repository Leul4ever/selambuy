import 'package:equatable/equatable.dart';

class ProfileMenuItemEntity extends Equatable {
  final String id;
  final String title;
  final String iconPath;
  final String route;
  final bool isEnabled;

  const ProfileMenuItemEntity({
    required this.id,
    required this.title,
    required this.iconPath,
    required this.route,
    this.isEnabled = true,
  });

  @override
  List<Object?> get props => [id, title, iconPath, route, isEnabled];
}
