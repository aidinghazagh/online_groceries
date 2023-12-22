import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/screens/account_screen.dart';
import 'package:online_groceries/screens/cart_screen.dart';
import 'package:online_groceries/screens/explore_screen.dart';
import 'package:online_groceries/screens/favorite_screen.dart';
import 'package:online_groceries/screens/home_screen.dart';
import 'package:online_groceries/style/app_text_styles.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var activePageTitle = '';

    Widget activePage = const SafeArea(child: HomeScreen());

    if (_selectedPageIndex == 1) {
      activePage = const SafeArea(child: ExploreScreen());
      activePageTitle = 'Find Products';
    }
    if (_selectedPageIndex == 2) {
      activePage = const SafeArea(child: CartScreen());
      activePageTitle = 'My Cart';
    }
    if (_selectedPageIndex == 3) {
      activePage = const SafeArea(child: FavoriteScreen());
      activePageTitle = 'Favorite';
    }
    if (_selectedPageIndex == 4) {
      activePage = const SafeArea(child: AccountScreen());
      activePageTitle = '';
    }

    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        selectedItemColor: AppColors.primary(),
        unselectedLabelStyle: AppTextStyle.subtitle(),
        selectedLabelStyle: AppTextStyle.subtitle(),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/Home.png',
              color: _selectedPageIndex == 0 ? AppColors.primary() : null,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/explore.png',
              color: _selectedPageIndex == 1 ? AppColors.primary() : null,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/cart.png',
              color: _selectedPageIndex == 2 ? AppColors.primary() : null,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/favorite.png',
              color: _selectedPageIndex == 3 ? AppColors.primary() : null,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/account.png',
              color: _selectedPageIndex == 4 ? AppColors.primary() : null,
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
