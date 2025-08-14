import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/navigation_bloc.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../../../../features/home/presentation/pages/home_page.dart';
import '../../../../features/cart/presentation/bloc/cart_bloc.dart';
import 'categories_page.dart';
import 'cart_page.dart';
import 'wishlist_page.dart';
import 'profile_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({Key? key}) : super(key: key);

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  @override
  void initState() {
    super.initState();
    // Add some demo items to cart for testing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cartBloc = context.read<CartBloc>();
      // Add demo items if cart is empty
      if (cartBloc.state.items.isEmpty) {
        cartBloc.add(AddItemToCart(const CartItem(
          id: 'demo1',
          name: 'Eco Cotton T-Shirt',
          price: 20.00,
          imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=300&q=80',
        )));
        cartBloc.add(AddItemToCart(const CartItem(
          id: 'demo2',
          name: 'Organic Denim Jeans',
          price: 45.00,
          imageUrl: 'https://images.unsplash.com/photo-1542272604-787c3835535d?auto=format&fit=crop&w=300&q=80',
        )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.selectedIndex,
            children: const [
              HomePage(),
              CategoriesPage(),
              CartPage(),
              WishlistPage(),
              ProfilePage(),
            ],
          ),
          bottomNavigationBar: const BottomNavigationBarWidget(),
        );
      },
    );
  }
}
