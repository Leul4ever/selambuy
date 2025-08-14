import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState(items: [])) {
    on<AddItemToCart>(_onAddItemToCart);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
    on<ClearCart>(_onClearCart);
  }

  void _onAddItemToCart(
    AddItemToCart event,
    Emitter<CartState> emit,
  ) {
    final currentItems = List<CartItem>.from(state.items);
    currentItems.add(event.item);
    emit(CartState(items: currentItems));
  }

  void _onRemoveItemFromCart(
    RemoveItemFromCart event,
    Emitter<CartState> emit,
  ) {
    final currentItems = List<CartItem>.from(state.items);
    currentItems.removeWhere((item) => item.id == event.itemId);
    emit(CartState(items: currentItems));
  }

  void _onClearCart(
    ClearCart event,
    Emitter<CartState> emit,
  ) {
    emit(const CartState(items: []));
  }
}
