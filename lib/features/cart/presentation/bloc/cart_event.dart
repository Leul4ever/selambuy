part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddItemToCart extends CartEvent {
  final CartItem item;

  const AddItemToCart(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveItemFromCart extends CartEvent {
  final String itemId;

  const RemoveItemFromCart(this.itemId);

  @override
  List<Object> get props => [itemId];
}

class ClearCart extends CartEvent {}
