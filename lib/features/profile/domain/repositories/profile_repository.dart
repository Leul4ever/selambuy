import 'package:dartz/dartz.dart';
import '../entities/user_profile_entity.dart';
import '../entities/order_status_entity.dart';
import '../entities/profile_menu_item_entity.dart';
import '../../../../core/error/failures.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserProfileEntity>> getUserProfile();
  Future<Either<Failure, UserProfileEntity>> updateUserProfile(UserProfileEntity profile);
  Future<Either<Failure, List<OrderStatusEntity>>> getOrderStatuses();
  Future<Either<Failure, List<ProfileMenuItemEntity>>> getProfileMenuItems();
  Future<Either<Failure, void>> logout();
}
