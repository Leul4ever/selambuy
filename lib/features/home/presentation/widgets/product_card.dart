import 'package:flutter/material.dart';
import 'verified_badge.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final VoidCallback? onAddToCart;
  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    // Assume user is not logged in for now
    bool isLoggedIn = false;
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(4), // Reduced margin to prevent overflow
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Product Image Section ---
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (_, __, ___) => Container(
                  color: colorScheme.surfaceVariant,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.image_not_supported,
                    size: 40,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ),
          // --- Product Info Section ---
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8), // Reduced padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Product name and price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        price,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  // --- Verified Badge and Add to Cart ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const VerifiedBadge(),
                      IconButton(
                        icon: Icon(
                          Icons.add_shopping_cart,
                          color: colorScheme.primary,
                          size: 20, // Reduced size
                        ),
                        padding: EdgeInsets.zero, // Remove padding
                        constraints: const BoxConstraints(
                          minWidth: 32,
                          minHeight: 32,
                        ),
                        onPressed: () {
                          if (!isLoggedIn) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Authentication Required'),
                                content: const Text(
                                  'You need to log in or register to continue.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushNamed('/login');
                                    },
                                    child: const Text('Login'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context)
                                          .pushNamed('/signup');
                                    },
                                    child: const Text('Register'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            if (onAddToCart != null) onAddToCart!();
                          }
                        },
                        tooltip: 'Add to cart',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
