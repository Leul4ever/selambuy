import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState(items: [])) {
    on<CartItemAdded>(_onCartItemAdded);
    on<CartItemRemoved>(_onCartItemRemoved);
    on<CartCleared>(_onCartCleared);
  }

  void _onCartItemAdded(CartItemAdded event, Emitter<CartState> emit) {
    final updatedItems = List<String>.from(state.items)..add(event.itemName);
    emit(state.copyWith(items: updatedItems));
  }

  void _onCartItemRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    final updatedItems = List<String>.from(state.items)..remove(event.itemName);
    emit(state.copyWith(items: updatedItems));
  }

  void _onCartCleared(CartCleared event, Emitter<CartState> emit) {
    emit(const CartState(items: []));
  }
}
