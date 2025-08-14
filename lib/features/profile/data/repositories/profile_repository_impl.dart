import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/entities/order_status_entity.dart';
import '../../domain/entities/profile_menu_item_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';
import '../models/user_profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, UserProfileEntity>> getUserProfile() async {
    try {
      final profile = await localDataSource.getUserProfile();
      if (profile != null) {
        return Right(profile);
      } else {
        // Return mock data for now
        return Right(UserProfileModel(
          id: '1',
          name: 'Roan Atkinson',
          email: 'roan.atkinson@example.com',
          phone: '+1234567890',
          profileImageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80',
          profession: 'Entrepreneur',
          bio: 'Passionate about innovation and business growth',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ));
      }
    } on CacheException {
      return const Left(CacheFailure('Failed to get profile from cache'));
    }
  }

  @override
  Future<Either<Failure, UserProfileEntity>> updateUserProfile(UserProfileEntity profile) async {
    try {
      final profileModel = UserProfileModel.fromEntity(profile);
      await localDataSource.saveUserProfile(profileModel);
      return Right(profile);
    } on CacheException {
      return const Left(CacheFailure('Failed to update profile'));
    }
  }

  @override
  Future<Either<Failure, List<OrderStatusEntity>>> getOrderStatuses() async {
    try {
      final orderStatuses = await localDataSource.getOrderStatuses();
      return Right(orderStatuses);
    } on CacheException {
      return const Left(CacheFailure('Failed to get order statuses'));
    }
  }

  @override
  Future<Either<Failure, List<ProfileMenuItemEntity>>> getProfileMenuItems() async {
    try {
      final menuItems = await localDataSource.getProfileMenuItems();
      return Right(menuItems);
    } on CacheException {
      return const Left(CacheFailure('Failed to get profile menu items'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearProfileData();
      return const Right(null);
    } on CacheException {
      return const Left(CacheFailure('Failed to logout'));
    }
  }
}
