import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart/cart_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Cart',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${state.itemCount} items in cart',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 24),
                if (state.items.isNotEmpty) ...[
                  Text(
                    'Items:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  ...state.items.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(item),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => context.read<CartBloc>().add(
                            CartItemRemoved(item),
                          ),
                        ),
                      ],
                    ),
                  )),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<CartBloc>().add(CartCleared()),
                    child: const Text('Clear Cart'),
                  ),
                ] else ...[
                  ElevatedButton(
                    onPressed: () => context.read<CartBloc>().add(
                      const CartItemAdded('Sample Item'),
                    ),
                    child: const Text('Add Sample Item'),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
