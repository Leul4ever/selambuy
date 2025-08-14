import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/navigation/navigation_bloc.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/promotional/promotional_bloc.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import 'demo_home_page.dart';
import 'categories_page.dart';
import 'cart_page.dart';
import 'wishlist_page.dart';
import 'profile_page.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
        BlocProvider<PromotionalBloc>(
          create: (context) => PromotionalBloc(),
        ),
      ],
      child: const _MainNavigationScreenBody(),
    );
  }
}

class _MainNavigationScreenBody extends StatelessWidget {
  const _MainNavigationScreenBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.selectedIndex,
            children: [
              DemoHomePage(),
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
