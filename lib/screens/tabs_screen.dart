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
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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

  void goTo(int page) {
    setState((() => _selectedPageIndex = page));
  }

  void goToExplore(int page) {
    setState((() => _selectedPageIndex = page));
  }

  bool bottomSheetOpen = false;
  void itemAdded() {
    bottomSheetOpen = true;
    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (bottomSheetOpen) {
          Navigator.of(context).pop();
        }
      },
    );
    _scaffoldKey.currentState!.showBottomSheet(
        enableDrag: false, backgroundColor: Colors.transparent, (contex) {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: 364,
        height: 67,
        padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            color: AppColors.addedCart()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 7),
                Text(
                  'Added to Cart',
                  style:
                      AppTextStyle.checkOutButtonPrice().copyWith(fontSize: 18),
                ),
              ],
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                ),
                label: Text(
                  'Open Cart',
                  style:
                      AppTextStyle.checkOutButtonPrice().copyWith(fontSize: 14),
                ),
                onPressed: () {
                  bottomSheetOpen = false;
                  Navigator.of(context).pop();
                  Future.delayed(
                    const Duration(milliseconds: 250),
                    () {
                      goTo(2);
                    },
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 13,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = SafeArea(
        child: HomeScreen(
      itemAdded: itemAdded,
      goToExplore: () => goToExploreFocus(),
      goToCart: () => goTo(2),
    ));

    if (_selectedPageIndex == 1) {
      activePage = SafeArea(
          child: ExploreScreen(
        itemAdded: itemAdded,
        goToCart: () => goTo(2),
        autofocus: autofocus,
      ));
    }
    if (_selectedPageIndex == 2) {
      activePage = SafeArea(
          child: CartScreen(
        goToHome: () => goTo(0),
        goToExplore: () => goToExplore(1),
      ));
    }
    if (_selectedPageIndex == 3) {
      activePage = SafeArea(
          child: FavoriteScreen(
        itemAdded: itemAdded,
        goToExplore: () => goTo(2),
      ));
    }
    if (_selectedPageIndex == 4) {
      activePage = const SafeArea(child: AccountScreen());
    }

    autofocus = false;

    return PopScope(
      onPopInvoked: (b) {
        bottomSheetOpen = false;
      },
      child: Scaffold(
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
        body: Scaffold(
          body: activePage,
          key: _scaffoldKey,
        ),
      ),
    );
  }
}
