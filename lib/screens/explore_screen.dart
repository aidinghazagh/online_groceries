import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/data/cart_items.dart';
import 'package:online_groceries/data/generic_lists.dart';
import 'package:online_groceries/models/cart_item.dart';
import 'package:online_groceries/screens/product_detail.dart';
import 'package:online_groceries/style/app_text_styles.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen(
      {super.key, required this.autofocus, required this.goToCart});
  final bool autofocus;
  final Function goToCart;

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
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

  final FocusNode _focus = FocusNode();
  bool _searchBoolean = false;
  @override
  void dispose() {
    _focus.removeListener(_onFocusChange);
    _focus.dispose();

    _queryController;
    super.dispose();
  }

  void _serached() {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    _focus.addListener(_onFocusChange);
    super.initState();
  }

  void _onFocusChange() {
    if (_focus.hasFocus) {
      setState(() {
        _searchBoolean = true;
      });
    }
  }

  String _query = '';

  final _queryController = TextEditingController();

  void _onQueryChanged(String newQuery) {
    setState(() {
      _query = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Text(
      'Categories place holder',
      style: AppTextStyle.titleLarge(),
    );

    if (_query.isNotEmpty) {
      final searchedItems = allItems
          .where((element) =>
              element.name.toLowerCase().contains(_query.toLowerCase()))
          .toList();
      if (searchedItems.isEmpty) {
        content = Text(
          'No items found',
          style: AppTextStyle.titleLarge(),
        );
      } else {
        content = Flexible(
          child: GridView.count(
            padding: const EdgeInsets.only(bottom: 25),
            childAspectRatio: 0.8,
            crossAxisCount: 2,
            children: List.generate(searchedItems.length, (index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: index % 2 == 0 ? 25 : 0,
                    right: index % 2 != 0 ? 25 : 0,
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
                        width: 173,
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
                                '\$${searchedItems[index].price}',
                                style: AppTextStyle.cardPrice(),
                              ),
                              const SizedBox(height: 25),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 14,
                        child: IconButton(
                            onPressed: () {
                              itemAdded();
                              _focus.unfocus();
                              setState(() {
                                cartItems.add(CartItem(
                                  product: allItems[index],
                                  amonut: 1,
                                ));
                              });
                            },
                            icon: Image.asset('assets/images/add-ic.png')),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      }
    }

    return Scaffold(
      body: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: _searchBoolean ? 0 : 50,
            child: Text(
              'Find Products',
              style: AppTextStyle.pageTitle(),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 52,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 25, right: _searchBoolean ? 0 : 25),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.searchField(),
                          ),
                          width: _searchBoolean
                              ? MediaQuery.of(context).size.width - 80
                              : MediaQuery.of(context).size.width - 50,
                          height: 51,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 43),
                            child: TextField(
                              focusNode: _focus,
                              onEditingComplete: _serached,
                              controller: _queryController,
                              onChanged: _onQueryChanged,
                              autofocus: widget.autofocus,
                              onTapOutside: (event) {
                                _serached();
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
                            onPressed: _serached,
                          ),
                        ),
                        if (_searchBoolean)
                          Positioned(
                            top: 0,
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _query = '';
                                  _queryController.clear();
                                  _searchBoolean = false;
                                });
                              },
                              icon: Image.asset('assets/images/close.png'),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (_searchBoolean)
                    IconButton(
                        onPressed: () {},
                        icon: Image.asset('assets/images/filter.png')),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          content,
        ],
      ),
    );
  }
}
