import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/data/cart_items.dart';
import 'package:online_groceries/data/category_banners.dart';
import 'package:online_groceries/data/generic_lists.dart';
import 'package:online_groceries/models/cart_item.dart';
import 'package:online_groceries/models/product.dart';
import 'package:online_groceries/screens/category_screen.dart';
import 'package:online_groceries/screens/product_detail.dart';
import 'package:online_groceries/style/app_text_styles.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen(
      {super.key,
      required this.autofocus,
      required this.goToCart,
      required this.itemAdded});
  final bool autofocus;
  final Function goToCart;
  final Function itemAdded;

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  bool checkBox1 = false;
  bool checkBox2 = false;
  bool checkBox3 = false;
  bool checkBox4 = false;
  bool checkBox5 = false;
  bool checkBox6 = false;
  bool checkBox7 = false;

  bool checkBox8 = false;
  bool checkBox9 = false;
  bool checkBox10 = false;
  bool checkBox11 = false;

  final FocusNode _focus = FocusNode();
  bool _searchBoolean = false;

  void shutCategory() {
    checkBox1 = false;
    checkBox2 = false;
    checkBox3 = false;
    checkBox4 = false;
    checkBox5 = false;
    checkBox6 = false;
    checkBox7 = false;
  }

  void shutBrand() {
    checkBox8 = false;
    checkBox9 = false;
    checkBox10 = false;
    checkBox11 = false;
  }

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

  bool isFiltering = false;

  Category? filteringCategory;
  Brand? filteringBrand;

  void applyFilters() {
    if (checkBox1 ||
        checkBox2 ||
        checkBox3 ||
        checkBox4 ||
        checkBox5 ||
        checkBox6 ||
        checkBox7 ||
        checkBox8 ||
        checkBox9 ||
        checkBox10 ||
        checkBox11) {
      setState(() {
        isFiltering = true;
      });
    } else {
      setState(() {
        isFiltering = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = GridView.count(
      padding: const EdgeInsets.only(bottom: 25),
      crossAxisCount: 2,
      childAspectRatio: 1,
      children: List.generate(allBaners.length, (index) {
        return Padding(
          padding: EdgeInsets.only(
              left: index % 2 == 0 ? 25 : 7.5,
              right: index % 2 != 0 ? 25 : 7.5,
              top: 15),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => CategoryScreen(
                      categeory: allBaners[index].category,
                      goToCart: widget.goToCart,
                      itemAdded: widget.itemAdded))));
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              width: 175,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: allBaners[index].color.withOpacity(0.10),
                  border: Border.all(
                      color: allBaners[index].color.withOpacity(0.70))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/${allBaners[index].image}'),
                  Text(
                    allBaners[index].title,
                    style: AppTextStyle.cardTitle(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
    void setEmpty() {
      content = Text(
        'No items found',
        style: AppTextStyle.titleLarge(),
      );
    }

    void setFull(searchedItems) {
      content = GridView.count(
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
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductDetail(
                          itemAdded: widget.itemAdded,
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
                            height: 80,
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
                        widget.itemAdded();
                        _focus.unfocus();
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
      );
    }

    if (_query.isNotEmpty) {
      if (isFiltering) {
        if (filteringCategory != null && filteringBrand != null) {
          final searchedItems = allItems
              .where((element) => (element.category == filteringCategory &&
                  element.brand == filteringBrand))
              .toList();
          if (searchedItems.isEmpty) {
            setEmpty();
          } else {
            setFull(searchedItems);
          }
        } else if (filteringBrand == null && filteringCategory != null) {
          final searchedItems = allItems
              .where((element) => element.category == filteringCategory)
              .toList();
          if (searchedItems.isEmpty) {
            setEmpty();
          } else {
            setFull(searchedItems);
          }
        } else if (filteringCategory == null && filteringBrand != null) {
          final searchedItems = allItems
              .where((element) => element.brand == filteringBrand)
              .toList();
          if (searchedItems.isEmpty) {
            setEmpty();
          } else {
            setFull(searchedItems);
          }
        }
      } else {
        final searchedItems = allItems
            .where((element) =>
                element.name.toLowerCase().contains(_query.toLowerCase()))
            .toList();
        if (searchedItems.isEmpty) {
          setEmpty();
        } else {
          setFull(searchedItems);
        }
      }
    }

    return Column(
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
                  padding:
                      EdgeInsets.only(left: 25, right: _searchBoolean ? 0 : 25),
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
                      onPressed: () {
                        showModalBottomSheet(
                            shape: Border.all(),
                            useSafeArea: true,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                    size: 30,
                                                  )),
                                              Text(
                                                'Filters',
                                                style: AppTextStyle.titleLarge()
                                                    .copyWith(fontSize: 20),
                                              ),
                                              const SizedBox(
                                                width: 38,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(30),
                                                      topRight:
                                                          Radius.circular(30)),
                                              color:
                                                  AppColors.filterContainer()),
                                          width: 414,
                                          height: 750,
                                          padding: const EdgeInsets.only(
                                              top: 30,
                                              right: 25,
                                              left: 25,
                                              bottom: 0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Categories',
                                                      style: AppTextStyle
                                                          .titleLarge(),
                                                    ),
                                                  ],
                                                ),
                                                CheckboxListTile(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  activeColor:
                                                      AppColors.primary(),
                                                  title: Text(
                                                    "Dairy and eggs",
                                                    style:
                                                        AppTextStyle.cardTitle()
                                                            .copyWith(
                                                      color: checkBox1
                                                          ? AppColors.primary()
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  value: checkBox1,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      shutCategory();
                                                      filteringCategory =
                                                          Category.dairyAndEggs;
                                                      checkBox1 = newValue!;
                                                    });
                                                  },
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                ),
                                                CheckboxListTile(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  activeColor:
                                                      AppColors.primary(),
                                                  title: Text(
                                                    "Cooking Oil & Ghee",
                                                    style:
                                                        AppTextStyle.cardTitle()
                                                            .copyWith(
                                                      color: checkBox2
                                                          ? AppColors.primary()
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  value: checkBox2,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      shutCategory();
                                                      filteringCategory =
                                                          Category.oil;
                                                      checkBox2 = newValue!;
                                                    });
                                                  },
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                ),
                                                CheckboxListTile(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  activeColor:
                                                      AppColors.primary(),
                                                  title: Text(
                                                    "Meat & Fish",
                                                    style:
                                                        AppTextStyle.cardTitle()
                                                            .copyWith(
                                                      color: checkBox3
                                                          ? AppColors.primary()
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  value: checkBox3,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      shutCategory();
                                                      filteringCategory =
                                                          Category.meat;
                                                      checkBox3 = newValue!;
                                                    });
                                                  },
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                ),
                                                CheckboxListTile(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  activeColor:
                                                      AppColors.primary(),
                                                  title: Text(
                                                    "Bakery & Snacks",
                                                    style:
                                                        AppTextStyle.cardTitle()
                                                            .copyWith(
                                                      color: checkBox4
                                                          ? AppColors.primary()
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  value: checkBox4,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      shutCategory();
                                                      filteringCategory =
                                                          Category
                                                              .bakeryAndSnacks;
                                                      checkBox4 = newValue!;
                                                    });
                                                  },
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                ),
                                                CheckboxListTile(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  activeColor:
                                                      AppColors.primary(),
                                                  title: Text(
                                                    "Frash Fruits & Vegetable",
                                                    style:
                                                        AppTextStyle.cardTitle()
                                                            .copyWith(
                                                      color: checkBox5
                                                          ? AppColors.primary()
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  value: checkBox5,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      shutCategory();
                                                      filteringCategory =
                                                          Category.fruit;
                                                      checkBox5 = newValue!;
                                                    });
                                                  },
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                ),
                                                CheckboxListTile(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  activeColor:
                                                      AppColors.primary(),
                                                  title: Text(
                                                    "Beverages",
                                                    style:
                                                        AppTextStyle.cardTitle()
                                                            .copyWith(
                                                      color: checkBox6
                                                          ? AppColors.primary()
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  value: checkBox6,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      shutCategory();
                                                      filteringCategory =
                                                          Category.bevreges;
                                                      checkBox6 = newValue!;
                                                    });
                                                  },
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                ),
                                                CheckboxListTile(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  activeColor:
                                                      AppColors.primary(),
                                                  title: Text(
                                                    "Groceries",
                                                    style:
                                                        AppTextStyle.cardTitle()
                                                            .copyWith(
                                                      color: checkBox7
                                                          ? AppColors.primary()
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  value: checkBox7,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      shutCategory();
                                                      filteringCategory =
                                                          Category.groceries;
                                                      checkBox7 = newValue!;
                                                    });
                                                  },
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                ),
                                                const SizedBox(height: 30),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Brand',
                                                      style: AppTextStyle
                                                          .titleLarge(),
                                                    ),
                                                  ],
                                                ),
                                                CheckboxListTile(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  activeColor:
                                                      AppColors.primary(),
                                                  title: Text(
                                                    "Individual Callection",
                                                    style:
                                                        AppTextStyle.cardTitle()
                                                            .copyWith(
                                                      color: checkBox8
                                                          ? AppColors.primary()
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  value: checkBox8,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      shutBrand();
                                                      filteringBrand =
                                                          Brand.indivisual;
                                                      checkBox8 = newValue!;
                                                    });
                                                  },
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                ),
                                                CheckboxListTile(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  activeColor:
                                                      AppColors.primary(),
                                                  title: Text(
                                                    "Cocola",
                                                    style:
                                                        AppTextStyle.cardTitle()
                                                            .copyWith(
                                                      color: checkBox9
                                                          ? AppColors.primary()
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  value: checkBox9,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      shutBrand();
                                                      filteringBrand =
                                                          Brand.cocola;
                                                      checkBox9 = newValue!;
                                                    });
                                                  },
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                ),
                                                CheckboxListTile(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  activeColor:
                                                      AppColors.primary(),
                                                  title: Text(
                                                    "Ifad",
                                                    style:
                                                        AppTextStyle.cardTitle()
                                                            .copyWith(
                                                      color: checkBox10
                                                          ? AppColors.primary()
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  value: checkBox10,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      shutBrand();
                                                      filteringBrand =
                                                          Brand.ifad;
                                                      checkBox10 = newValue!;
                                                    });
                                                  },
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                ),
                                                CheckboxListTile(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  activeColor:
                                                      AppColors.primary(),
                                                  title: Text(
                                                    "Kazi Farmas",
                                                    style:
                                                        AppTextStyle.cardTitle()
                                                            .copyWith(
                                                      color: checkBox11
                                                          ? AppColors.primary()
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                  value: checkBox11,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      shutBrand();
                                                      filteringBrand =
                                                          Brand.kazi;
                                                      checkBox11 = newValue!;
                                                    });
                                                  },
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                ),
                                                const SizedBox(height: 150),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 25,
                                          right: 0,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              150),
                                      child: Positioned(
                                        bottom: 10,
                                        left: 0,
                                        right: 0,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(19),
                                            ),
                                            fixedSize: const Size(353, 67),
                                            backgroundColor:
                                                AppColors.primary(),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              Navigator.of(context).pop();
                                              applyFilters();
                                            });
                                          },
                                          child: Text(
                                            'Apply Filter',
                                            style: AppTextStyle.welcomeLarge()
                                                .copyWith(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                            });
                      },
                      icon: Image.asset('assets/images/filter.png')),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Flexible(child: content),
      ],
    );
  }
}
