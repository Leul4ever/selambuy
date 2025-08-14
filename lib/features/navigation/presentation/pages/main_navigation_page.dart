import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/navigation_bloc.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../../../../features/home/presentation/pages/home_page.dart';
import '../../../../features/profile/presentation/bloc/profile_bloc.dart';
import '../../../../features/profile/presentation/pages/profile_page.dart';
import '../../../../core/service_locator.dart';
import 'categories_page.dart';
import 'cart_page.dart';
import 'wishlist_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({Key? key}) : super(key: key);

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return BlocProvider(
          create: (context) => sl<ProfileBloc>(),
          child: Scaffold(
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
          ),
        );
      },
    );
  }
}
