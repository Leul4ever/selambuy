part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({required this.items});

  int get itemCount => items.length;

  @override
  List<Object> get props => [items];
}

class CartItem extends Equatable {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  const CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [id, name, price, imageUrl];
}
