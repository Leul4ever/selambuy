part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<String> items;

  const CartState({required this.items});

  int get itemCount => items.length;

  CartState copyWith({List<String>? items}) {
    return CartState(
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [items];
}
