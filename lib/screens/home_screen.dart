import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/data/generic_lists.dart';
import 'package:online_groceries/data/groceries_categories.dart';
import 'package:online_groceries/style/app_text_styles.dart';
import 'package:online_groceries/widgets/exclusive_offer.dart';
import 'package:online_groceries/widgets/groceries_category.dart';
import 'package:online_groceries/widgets/home_location.dart';
import 'package:online_groceries/widgets/seeall.dart';

final List<String> imgList = [
  'assets/images/banner.png',
  'assets/images/banner.png',
  'assets/images/banner.png',
];

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, required this.goToExplore, required this.goToCart});
  final Function goToExplore;
  final Function goToCart;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    showBottomSheet(
        enableDrag: false,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (contex) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Container(
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
                        style: AppTextStyle.checkOutButtonPrice()
                            .copyWith(fontSize: 18),
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
                        style: AppTextStyle.checkOutButtonPrice()
                            .copyWith(fontSize: 14),
                      ),
                      onPressed: () {
                        bottomSheetOpen = false;
                        Navigator.of(context).pop();
                        Future.delayed(
                          const Duration(milliseconds: 250),
                          () {
                            widget.goToCart();
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
            ),
          );
        });
  }

  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (b) {
        bottomSheetOpen = false;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset('assets/images/carrot-home.png'),
                  const SizedBox(
                    height: 8,
                  ),
                  const HomeLocation(),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.searchField(),
                        ),
                        width: double.infinity,
                        height: 51,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 43),
                          child: TextField(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              widget.goToExplore();
                            },
                            style: AppTextStyle.titleLarge()
                                .copyWith(fontSize: 16),
                            decoration: InputDecoration(
                                hintStyle: AppTextStyle.searchHint(),
                                hintText: 'Search Store',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none),
                            cursorColor: Colors.black,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: Image.asset('assets/images/search-ic.png'),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      CarouselSlider(
                        carouselController: _controller,
                        options: CarouselOptions(
                            height: 114,
                            autoPlay: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                        items: [1, 2, 3].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'assets/images/banner.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Positioned(
                        bottom: 5,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imgList.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: _current == entry.key ? 14 : 7,
                                height: 7,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: _current == entry.key ? 0 : 4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: _current == entry.key
                                        ? AppColors.primary()
                                        : const Color.fromRGBO(0, 0, 0, 1)
                                            .withOpacity(0.3)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SeeAll(title: 'Exclusive Offer'),
                  HorizantalBuilder(
                    goToCart: widget.goToCart,
                    listName: exclusiveOffer,
                    itemAdded: () {
                      itemAdded();
                    },
                  ),
                  const SeeAll(title: 'Best Selling'),
                  HorizantalBuilder(
                      itemAdded: () {
                        itemAdded();
                      },
                      goToCart: widget.goToCart,
                      listName: bestSelling),
                  const SeeAll(title: 'Groceries'),
                  SizedBox(
                    width: double.infinity,
                    height: 110,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: groceriesCategories.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              GroceriesCategory(
                                  image: groceriesCategories[index].image,
                                  title: groceriesCategories[index].title,
                                  color: groceriesCategories[index].color),
                              if (index != groceriesCategories.length - 1)
                                const SizedBox(
                                  width: 15,
                                ),
                            ],
                          );
                        }),
                  ),
                  const SizedBox(height: 20),
                  HorizantalBuilder(
                      itemAdded: () {
                        itemAdded();
                      },
                      goToCart: widget.goToCart,
                      listName: groceries),
                  const SizedBox(height: 27),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
