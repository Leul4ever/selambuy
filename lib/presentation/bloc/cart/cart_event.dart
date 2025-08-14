part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartItemAdded extends CartEvent {
  final String itemName;

  const CartItemAdded(this.itemName);

  @override
  List<Object> get props => [itemName];
}

class CartItemRemoved extends CartEvent {
  final String itemName;

  const CartItemRemoved(this.itemName);

  @override
  List<Object> get props => [itemName];
}

class CartCleared extends CartEvent {}
