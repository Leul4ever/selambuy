import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_profile_model.dart';
import '../models/order_status_model.dart';
import '../models/profile_menu_item_model.dart';

abstract class ProfileLocalDataSource {
  Future<UserProfileModel?> getUserProfile();
  Future<void> saveUserProfile(UserProfileModel profile);
  Future<List<OrderStatusModel>> getOrderStatuses();
  Future<List<ProfileMenuItemModel>> getProfileMenuItems();
  Future<void> clearProfileData();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  static const String _profileKey = 'user_profile';
  static const String _orderStatusesKey = 'order_statuses';
  static const String _profileMenuItemsKey = 'profile_menu_items';

  @override
  Future<UserProfileModel?> getUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final profileJson = prefs.getString(_profileKey);
      if (profileJson != null) {
        return UserProfileModel.fromJson(json.decode(profileJson));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveUserProfile(UserProfileModel profile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_profileKey, json.encode(profile.toJson()));
    } catch (e) {
      throw Exception('Failed to save profile data');
    }
  }

  @override
  Future<List<OrderStatusModel>> getOrderStatuses() async {
    // Return mock data for now
    return [
      const OrderStatusModel(
        id: 'pending_payment',
        title: 'Pending Payment',
        iconPath: 'assets/icons/wallet.svg',
        color: Color(0xFF2196F3),
        count: 2,
      ),
      const OrderStatusModel(
        id: 'delivered',
        title: 'Delivered',
        iconPath: 'assets/icons/delivery.svg',
        color: Color(0xFFFF9800),
        count: 5,
      ),
      const OrderStatusModel(
        id: 'processing',
        title: 'Processing',
        iconPath: 'assets/icons/processing.svg',
        color: Color(0xFFE91E63),
        count: 1,
      ),
      const OrderStatusModel(
        id: 'cancelled',
        title: 'Cancelled',
        iconPath: 'assets/icons/cancelled.svg',
        color: Color(0xFF4CAF50),
        count: 0,
      ),
      const OrderStatusModel(
        id: 'wishlist',
        title: 'Wishlist',
        iconPath: 'assets/icons/heart.svg',
        color: Color(0xFFE91E63),
        count: 8,
      ),
      const OrderStatusModel(
        id: 'customer_care',
        title: 'Customer Care',
        iconPath: 'assets/icons/support.svg',
        color: Color(0xFF9C27B0),
        count: 0,
      ),
    ];
  }

  @override
  Future<List<ProfileMenuItemModel>> getProfileMenuItems() async {
    // Return mock data for now
    return [
      const ProfileMenuItemModel(
        id: 'edit_profile',
        title: 'Edit Profile',
        iconPath: 'assets/icons/person.svg',
        route: '/edit-profile',
      ),
      const ProfileMenuItemModel(
        id: 'shipping_address',
        title: 'Shipping Address',
        iconPath: 'assets/icons/location.svg',
        route: '/shipping-address',
      ),
    ];
  }

  @override
  Future<void> clearProfileData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_profileKey);
    } catch (e) {
      throw Exception('Failed to clear profile data');
    }
  }
}
