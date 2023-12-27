import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/data/cart_items.dart';
import 'package:online_groceries/data/generic_lists.dart';
import 'package:online_groceries/models/cart_item.dart';
import 'package:online_groceries/screens/product_detail.dart';
import 'package:online_groceries/style/app_text_styles.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen(
      {super.key, required this.itemAdded, required this.goToExplore});
  final Function itemAdded;
  final Function goToExplore;

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  void refresh(dynamic value) {
    return setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No Favorite Items',
                style: AppTextStyle.titleLarge(),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/heart-filled.png',
                    width: 50,
                  )),
            ],
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextButton.icon(
                label: Text(
                  'Go Shopping',
                  style: AppTextStyle.subtitle(),
                ),
                onPressed: () {
                  widget.goToExplore();
                },
                icon: Icon(
                  Icons.add_shopping_cart,
                  size: 50,
                  color: AppColors.primary(),
                )),
          )
        ],
      ),
    );

    final favoriteItems = allItems
        .where(
          (element) => element.isFavorite,
        )
        .toList();
    if (favoriteItems.isNotEmpty) {
      content = Stack(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: ListView.builder(
            itemCount: favoriteItems.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                  product: favoriteItems[index],
                                  itemAdded: widget.itemAdded)))
                          .then(refresh);
                    },
                    child: Container(
                      width: 413,
                      height: 114,
                      padding:
                          const EdgeInsets.only(left: 32, right: 1, top: 15),
                      decoration: index == favoriteItems.length - 1
                          ? BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: AppColors.cardBorder())))
                          : null,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 25),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: AppColors.cardBorder()))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/${favoriteItems[index].image}',
                                          width: 70,
                                          height: 65,
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              favoriteItems[index].name,
                                              style: AppTextStyle.cardTitle(),
                                            ),
                                            Text(
                                              '${favoriteItems[index].quantityPerPrice}, Price',
                                              style: AppTextStyle
                                                  .cardQuantityPrice(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '\$${favoriteItems[index].price.toStringAsFixed(2)}',
                                  style: AppTextStyle.cardPrice(),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 25,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
                fixedSize: const Size(364, 67),
                backgroundColor: AppColors.primary(),
              ),
              onPressed: () {
                for (var i = 0; i < favoriteItems.length; i++) {
                  cartItems.add(CartItem(
                    product: favoriteItems[i],
                    amonut: favoriteItems[i].buyingAmount,
                  ));
                }
                widget.itemAdded();
              },
              child: Text(
                'Add to Basket',
                style: AppTextStyle.welcomeLarge().copyWith(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ]);
    }

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          padding: const EdgeInsets.only(bottom: 32),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: AppColors.cardBorder()))),
          child: Text(
            'Favorite',
            style: AppTextStyle.pageTitle(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: content,
    );
  }
}
