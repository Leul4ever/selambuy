part of 'promotional_bloc.dart';

class PromotionalState extends Equatable {
  final int currentBannerIndex;
  final bool isAutoScrolling;
  final List<PromotionalBanner> banners;
  final List<PromotionalItem> newArrivals;
  final List<PromotionalItem> seasonalOffers;
  final List<PromotionalItem> discountDeals;

  const PromotionalState({
    this.currentBannerIndex = 0,
    this.isAutoScrolling = true,
    this.banners = const [],
    this.newArrivals = const [],
    this.seasonalOffers = const [],
    this.discountDeals = const [],
  });

  PromotionalState copyWith({
    int? currentBannerIndex,
    bool? isAutoScrolling,
    List<PromotionalBanner>? banners,
    List<PromotionalItem>? newArrivals,
    List<PromotionalItem>? seasonalOffers,
    List<PromotionalItem>? discountDeals,
  }) {
    return PromotionalState(
      currentBannerIndex: currentBannerIndex ?? this.currentBannerIndex,
      isAutoScrolling: isAutoScrolling ?? this.isAutoScrolling,
      banners: banners ?? this.banners,
      newArrivals: newArrivals ?? this.newArrivals,
      seasonalOffers: seasonalOffers ?? this.seasonalOffers,
      discountDeals: discountDeals ?? this.discountDeals,
    );
  }

  @override
  List<Object> get props => [
        currentBannerIndex,
        isAutoScrolling,
        banners,
        newArrivals,
        seasonalOffers,
        discountDeals,
      ];
}

class PromotionalBanner extends Equatable {
  final String id;
  final String imageUrl;
  final String title;
  final String subtitle;
  final String? actionText;
  final String? actionRoute;

  const PromotionalBanner({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    this.actionText,
    this.actionRoute,
  });

  @override
  List<Object?> get props => [id, imageUrl, title, subtitle, actionText, actionRoute];
}

class PromotionalItem extends Equatable {
  final String id;
  final String imageUrl;
  final String title;
  final String subtitle;
  final double? originalPrice;
  final double? discountedPrice;
  final double? discountPercentage;
  final String? badgeText;
  final String? badgeColor;

  const PromotionalItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    this.originalPrice,
    this.discountedPrice,
    this.discountPercentage,
    this.badgeText,
    this.badgeColor,
  });

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        title,
        subtitle,
        originalPrice,
        discountedPrice,
        discountPercentage,
        badgeText,
        badgeColor,
      ];
}
