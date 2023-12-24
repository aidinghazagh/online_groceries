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
  bool autofocus = false;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void goToExploreFocus() {
    autofocus = true;
    setState((() => _selectedPageIndex = 1));
  }

  void goToExplore() {
    setState((() => _selectedPageIndex = 1));
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = SafeArea(
        child: HomeScreen(
      goToExplore: () => goToExploreFocus(),
    ));

    if (_selectedPageIndex == 1) {
      activePage = SafeArea(
          child: ExploreScreen(
        autofocus: autofocus,
      ));
    }
    if (_selectedPageIndex == 2) {
      activePage = SafeArea(
          child: CartScreen(
        goToExplore: () => goToExplore(),
      ));
    }
    if (_selectedPageIndex == 3) {
      activePage = const SafeArea(child: FavoriteScreen());
    }
    if (_selectedPageIndex == 4) {
      activePage = const SafeArea(child: AccountScreen());
    }

    autofocus = false;

    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        selectedItemColor: AppColors.primary(),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle:
            AppTextStyle.subtitle().copyWith(fontWeight: FontWeight.normal),
        selectedLabelStyle:
            AppTextStyle.subtitle().copyWith(fontWeight: FontWeight.normal),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                'assets/images/Home.png',
                color: _selectedPageIndex == 0 ? AppColors.primary() : null,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                'assets/images/explore.png',
                color: _selectedPageIndex == 1 ? AppColors.primary() : null,
              ),
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                'assets/images/cart.png',
                color: _selectedPageIndex == 2 ? AppColors.primary() : null,
              ),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                'assets/images/favorite.png',
                color: _selectedPageIndex == 3 ? AppColors.primary() : null,
              ),
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Image.asset(
                'assets/images/account.png',
                color: _selectedPageIndex == 4 ? AppColors.primary() : null,
              ),
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
