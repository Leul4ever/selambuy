import '../bloc/promotional/promotional_bloc.dart';

class PromotionalDataService {
  static List<PromotionalBanner> getSampleBanners() {
    return [
      const PromotionalBanner(
        id: 'banner_1',
        imageUrl: 'assets/images/image.png',
        title: 'New Collection',
        subtitle: 'Discover the latest trends',
        actionText: 'Shop Now',
        actionRoute: '/collection',
      ),
      const PromotionalBanner(
        id: 'banner_2',
        imageUrl: 'assets/images/image.png',
        title: 'Seasonal Sale',
        subtitle: 'Up to 50% off selected items',
        actionText: 'View Offers',
        actionRoute: '/sale',
      ),
      const PromotionalBanner(
        id: 'banner_3',
        imageUrl: 'assets/images/image.png',
        title: 'Free Shipping',
        subtitle: 'On orders over \$50',
        actionText: 'Learn More',
        actionRoute: '/shipping',
      ),
    ];
  }

  static List<PromotionalItem> getSampleNewArrivals() {
    return [
      const PromotionalItem(
        id: 'new_1',
        imageUrl: 'assets/images/image.png',
        title: 'Premium Cotton T-Shirt',
        subtitle: 'Comfortable and stylish',
        originalPrice: 29.99,
        discountedPrice: 24.99,
        discountPercentage: 17,
        badgeText: 'NEW',
        badgeColor: 'primary',
      ),
      const PromotionalItem(
        id: 'new_2',
        imageUrl: 'assets/images/image.png',
        title: 'Designer Jeans',
        subtitle: 'Perfect fit for any occasion',
        originalPrice: 89.99,
        badgeText: 'NEW',
        badgeColor: 'secondary',
      ),
      const PromotionalItem(
        id: 'new_3',
        imageUrl: 'assets/images/image.png',
        title: 'Casual Sneakers',
        subtitle: 'Comfort meets style',
        originalPrice: 79.99,
        discountedPrice: 59.99,
        discountPercentage: 25,
        badgeText: 'NEW',
        badgeColor: 'accent',
      ),
    ];
  }

  static List<PromotionalItem> getSampleSeasonalOffers() {
    return [
      const PromotionalItem(
        id: 'seasonal_1',
        imageUrl: 'assets/images/image.png',
        title: 'Winter Jacket',
        subtitle: 'Stay warm this season',
        originalPrice: 199.99,
        discountedPrice: 149.99,
        discountPercentage: 25,
        badgeText: 'SEASONAL',
        badgeColor: 'secondary',
      ),
      const PromotionalItem(
        id: 'seasonal_2',
        imageUrl: 'assets/images/image.png',
        title: 'Holiday Sweater',
        subtitle: 'Festive and cozy',
        originalPrice: 69.99,
        discountedPrice: 49.99,
        discountPercentage: 29,
        badgeText: 'SEASONAL',
        badgeColor: 'accent',
      ),
    ];
  }

  static List<PromotionalItem> getSampleDiscountDeals() {
    return [
      const PromotionalItem(
        id: 'deal_1',
        imageUrl: 'assets/images/image.png',
        title: 'Flash Sale Item',
        subtitle: 'Limited time offer',
        originalPrice: 49.99,
        discountedPrice: 29.99,
        discountPercentage: 40,
        badgeText: 'FLASH',
        badgeColor: 'error',
      ),
      const PromotionalItem(
        id: 'deal_2',
        imageUrl: 'assets/images/image.png',
        title: 'Clearance Product',
        subtitle: 'While supplies last',
        originalPrice: 129.99,
        discountedPrice: 79.99,
        discountPercentage: 38,
        badgeText: 'CLEARANCE',
        badgeColor: 'error',
      ),
      const PromotionalItem(
        id: 'deal_3',
        imageUrl: 'assets/images/image.png',
        title: 'Bundle Deal',
        subtitle: 'Buy 2 get 1 free',
        originalPrice: 99.99,
        discountedPrice: 66.66,
        discountPercentage: 33,
        badgeText: 'BUNDLE',
        badgeColor: 'primary',
      ),
    ];
  }

  static void loadSampleData(PromotionalBloc promotionalBloc) {
    promotionalBloc.add(
      PromotionalContentLoaded(
        banners: getSampleBanners(),
        newArrivals: getSampleNewArrivals(),
        seasonalOffers: getSampleSeasonalOffers(),
        discountDeals: getSampleDiscountDeals(),
      ),
    );
  }
}
