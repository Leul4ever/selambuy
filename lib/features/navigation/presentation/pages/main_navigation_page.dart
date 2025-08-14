import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/navigation_bloc.dart';
import '../widgets/bottom_navigation_bar_widget.dart';
import '../../../../features/home/presentation/pages/home_page.dart';
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
