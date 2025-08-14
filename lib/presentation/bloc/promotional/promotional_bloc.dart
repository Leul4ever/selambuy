import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'promotional_event.dart';
part 'promotional_state.dart';

class PromotionalBloc extends Bloc<PromotionalEvent, PromotionalState> {
  PromotionalBloc() : super(const PromotionalState()) {
    on<PromotionalBannerChanged>(_onPromotionalBannerChanged);
    on<PromotionalAutoScrollToggled>(_onPromotionalAutoScrollToggled);
    on<PromotionalContentLoaded>(_onPromotionalContentLoaded);
  }

  void _onPromotionalBannerChanged(
    PromotionalBannerChanged event,
    Emitter<PromotionalState> emit,
  ) {
    emit(state.copyWith(currentBannerIndex: event.index));
  }

  void _onPromotionalAutoScrollToggled(
    PromotionalAutoScrollToggled event,
    Emitter<PromotionalState> emit,
  ) {
    emit(state.copyWith(isAutoScrolling: event.isAutoScrolling));
  }

  void _onPromotionalContentLoaded(
    PromotionalContentLoaded event,
    Emitter<PromotionalState> emit,
  ) {
    emit(state.copyWith(
      banners: event.banners,
      newArrivals: event.newArrivals,
      seasonalOffers: event.seasonalOffers,
      discountDeals: event.discountDeals,
    ));
  }
}
