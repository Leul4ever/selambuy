import 'package:flutter/material.dart';
import '../widgets/product_card.dart';

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
          'https://images.unsplash.com/photo-1513708927688-890fe8c7b8c3?auto=format&fit=crop&w=400&q=80',
      'name': 'Eco Cotton T-Shirt',
      'price': ' 20.00',
      'category': 'Eco',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?auto=format&fit=crop&w=400&q=80',
      'name': 'Organic Denim Jeans',
      'price': ' 45.00',
      'category': 'Men',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=crop&w=400&q=80',
      'name': 'Handmade Tote Bag',
      'price': ' 35.00',
      'category': 'Women',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?auto=format&fit=crop&w=400&q=80',
      'name': 'Local Leather Wallet',
      'price': ' 25.00',
      'category': 'Local',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=400&q=80',
      'name': 'Eco Sneakers',
      'price': ' 60.00',
      'category': 'Eco',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80',
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
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: isTablet ? 32 : 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 12),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search products',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: colorScheme.surfaceVariant,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
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
                      backgroundColor: colorScheme.surfaceVariant,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Product grid
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isTablet ? 3 : 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio:
                        0.8, // Increased for more vertical space, prevents overflow
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return ProductCard(
                      imageUrl: product['image']!,
                      name: product['name']!,
                      price: product['price']!,
                      onAddToCart: () {},
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
