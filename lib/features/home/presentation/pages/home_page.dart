import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/product_card.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../navigation/presentation/bloc/navigation_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> categories = ['All', 'Men', 'Women', 'Eco', 'Local'];
  int selectedCategory = 0;

  final List<Map<String, String>> products = [
    {
      'image':
          'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=300&q=80',
      'name': 'Eco Cotton T-Shirt',
      'price': ' 20.00',
      'category': 'Eco',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1542272604-787c3835535d?auto=format&fit=crop&w=300&q=80',
      'name': 'Organic Denim Jeans',
      'price': ' 45.00',
      'category': 'Men',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1594223274512-ad4803739b7c?auto=format&fit=crop&w=300&q=80',
      'name': 'Handmade Tote Bag',
      'price': ' 35.00',
      'category': 'Women',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1627123424574-724758594e93?auto=format&fit=crop&w=300&q=80',
      'name': 'Local Leather Wallet',
      'price': ' 25.00',
      'category': 'Local',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?auto=format&fit=crop&w=300&q=80',
      'name': 'Eco Sneakers',
      'price': ' 60.00',
      'category': 'Eco',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1582142306909-195724d33ffc?auto=format&fit=crop&w=300&q=80',
      'name': 'Recycled Sunglasses',
      'price': ' 15.00',
      'category': 'Women',
    },
  ];

  List<Map<String, String>> get filteredProducts {
    if (selectedCategory == 0) return products;
    final selected = categories[selectedCategory];
    return products.where((p) => p['category'] == selected).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isTablet = MediaQuery.of(context).size.width > 600;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 32 : 16,
            vertical: 8,
          ),
          child: Column(
            children: [
              // Header section
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/image.png',
                        width: 32,
                        height: 32,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to Gebiya',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface,
                                ),
                          ),
                          Text(
                            'Discover amazing products',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ),
                                         // Notification button
                     IconButton(
                       icon: const Icon(Icons.notifications_none),
                       onPressed: () {
                         Navigator.of(context).pushNamed('/notifications');
                       },
                       tooltip: 'Notifications',
                     ),
                     // Theme toggle button
                     BlocBuilder<ThemeCubit, AppThemeMode>(
                       builder: (context, appThemeMode) {
                         return IconButton(
                           icon: Icon(
                             appThemeMode == AppThemeMode.dark
                                 ? Icons.light_mode
                                 : Icons.dark_mode,
                             color: colorScheme.primary,
                           ),
                           onPressed: () {
                             final newMode = appThemeMode == AppThemeMode.dark
                                 ? AppThemeMode.light
                                 : AppThemeMode.dark;
                             context.read<ThemeCubit>().setTheme(newMode);
                           },
                         );
                       },
                     ),
                  ],
                ),
              ),
              // Search bar
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search products',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              // Category filters
              SizedBox(
                height: 40,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final selected = selectedCategory == index;
                    return ChoiceChip(
                      label: Text(categories[index]),
                      selected: selected,
                      onSelected: (_) =>
                          setState(() => selectedCategory = index),
                      selectedColor: colorScheme.primary.withOpacity(0.15),
                      labelStyle: TextStyle(
                        color: selected
                            ? colorScheme.primary
                            : colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Product grid
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.only(bottom: bottomPadding + 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isTablet ? 3 : 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.6, // Lowered from 0.7 for more height
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return ProductCard(
                      imageUrl: product['image']!,
                      name: product['name']!,
                      price: product['price']!,
                      onAddToCart: () {
                        // Add item to cart for demo purposes
                        final cartItem = CartItem(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: product['name']!,
                          price: double.parse(
                              product['price']!.replaceAll(' ', '')),
                          imageUrl: product['image']!,
                        );
                        context.read<CartBloc>().add(AddItemToCart(cartItem));

                        // Show snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product['name']} added to cart'),
                            duration: const Duration(seconds: 2),
                            action: SnackBarAction(
                              label: 'View Cart',
                              onPressed: () {
                                context
                                    .read<NavigationBloc>()
                                    .add(const NavigationTabChanged(2));
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
