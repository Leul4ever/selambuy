part of 'promotional_bloc.dart';

abstract class PromotionalEvent extends Equatable {
  const PromotionalEvent();

  @override
  List<Object> get props => [];
}

class PromotionalBannerChanged extends PromotionalEvent {
  final int index;

  const PromotionalBannerChanged(this.index);

  @override
  List<Object> get props => [index];
}

class PromotionalAutoScrollToggled extends PromotionalEvent {
  final bool isAutoScrolling;

  const PromotionalAutoScrollToggled(this.isAutoScrolling);

  @override
  List<Object> get props => [isAutoScrolling];
}

class PromotionalContentLoaded extends PromotionalEvent {
  final List<PromotionalBanner> banners;
  final List<PromotionalItem> newArrivals;
  final List<PromotionalItem> seasonalOffers;
  final List<PromotionalItem> discountDeals;

  const PromotionalContentLoaded({
    required this.banners,
    required this.newArrivals,
    required this.seasonalOffers,
    required this.discountDeals,
  });

  @override
  List<Object> get props => [banners, newArrivals, seasonalOffers, discountDeals];
}
