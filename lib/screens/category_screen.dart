import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/data/cart_items.dart';
import 'package:online_groceries/data/generic_lists.dart';
import 'package:online_groceries/models/cart_item.dart';
import 'package:online_groceries/models/product.dart';
import 'package:online_groceries/screens/product_detail.dart';
import 'package:online_groceries/style/app_text_styles.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen(
      {super.key,
      required this.categeory,
      required this.goToCart,
      required this.itemAdded});
  final Category categeory;
  final Function goToCart;
  final Function itemAdded;
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(19)),
        enableDrag: false,
        backgroundColor: Colors.transparent, (contex) {
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
                      widget.goToCart;
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

  late final searchedItems = allItems
      .where((element) => element.category == widget.categeory)
      .toList();

  String title = '';

  @override
  Widget build(BuildContext context) {
    switch (widget.categeory) {
      case Category.fruit:
        title = 'Frash Fruits & Vegetable';
        break;
      case Category.oil:
        title = 'Cooking Oil & Ghee';
        break;
      case Category.meat:
        title = 'Meat & Fish';
        break;
      case Category.bakeryAndSnacks:
        title = 'Bakery & Snacks';
        break;
      case Category.dairyAndEggs:
        title = 'Dairy & Eggs';
        break;
      case Category.bevreges:
        title = 'Beverages';
        break;
      case Category.groceries:
        title = 'Groceries';
        break;
    }

    Widget content = Flexible(
      child: GridView.count(
        padding: const EdgeInsets.only(bottom: 25),
        childAspectRatio: 0.75,
        crossAxisCount: 2,
        children: List.generate(searchedItems.length, (index) {
          return Padding(
            padding: EdgeInsets.only(
                left: index % 2 == 0 ? 25 : 7.5,
                right: index % 2 != 0 ? 25 : 7.5,
                top: 15),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductDetail(
                          itemAdded: itemAdded,
                          product: searchedItems[index],
                        )));
              },
              child: Stack(
                children: [
                  Container(
                    width: 180,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.cardBorder())),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 33,
                          ),
                          Image.asset(
                            'assets/images/${searchedItems[index].image}',
                            width: 103,
                            height: 62,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            searchedItems[index].name,
                            style: AppTextStyle.cardTitle(),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${searchedItems[index].quantityPerPrice}, Price',
                            style: AppTextStyle.cardQuantityPrice(),
                          ),
                          const Spacer(),
                          Text(
                            '\$${searchedItems[index].price.toStringAsFixed(2)}',
                            style: AppTextStyle.cardPrice(),
                          ),
                          const SizedBox(height: 25),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: IconButton(
                      onPressed: () {
                        itemAdded();
                        setState(() {
                          cartItems.add(CartItem(
                            product: allItems[index],
                            amonut: 1,
                          ));
                        });
                      },
                      icon: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: AppColors.primary(),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );

    if (searchedItems.isEmpty) {
      content = Center(
        child: Text(
          'No items found',
          style: AppTextStyle.titleLarge(),
        ),
      );
    }

    return SafeArea(
      child: PopScope(
        onPopInvoked: (b) {
          bottomSheetOpen = false;
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  Text(
                    title,
                    style: AppTextStyle.titleLarge().copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/images/filter.png'),
                  )
                ],
              ),
            ),
          ),
          body: content,
        ),
      ),
    );
  }
}
