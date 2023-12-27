import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/data/cart_items.dart';
import 'package:online_groceries/data/generic_lists.dart';
import 'package:online_groceries/models/cart_item.dart';
import 'package:online_groceries/models/product.dart';
import 'package:online_groceries/screens/product_detail.dart';
import 'package:online_groceries/style/app_text_styles.dart';

class HorizantalBuilder extends StatefulWidget {
  const HorizantalBuilder(
      {super.key, required this.itemAdded, required this.filter});
  final Function itemAdded;
  final String filter;

  @override
  State<HorizantalBuilder> createState() => _HorizantalBuilderState();
}

class _HorizantalBuilderState extends State<HorizantalBuilder> {
  List<Product>? activeItems;

  @override
  Widget build(BuildContext context) {
    if (widget.filter == 'exclusive') {
      activeItems = allItems.where((element) => element.isExclusive).toList();
    }
    if (widget.filter == 'bestselling') {
      activeItems = allItems.where((element) => element.isBestselling).toList();
    }
    if (widget.filter == 'groceries') {
      activeItems = allItems
          .where((element) => element.category == Category.meat)
          .toList();
    }

    return SizedBox(
      width: double.infinity,
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: activeItems!.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductDetail(
                            itemAdded: widget.itemAdded,
                            product: activeItems![index],
                          )));
                },
                child: Stack(
                  children: [
                    Container(
                      width: 166,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.cardBorder())),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 33,
                            ),
                            Image.asset(
                              'assets/images/${activeItems![index].image}',
                              width: 103,
                              height: 62,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 33),
                            Text(
                              activeItems![index].name,
                              style: AppTextStyle.cardTitle(),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${activeItems![index].quantityPerPrice}, Price',
                              style: AppTextStyle.cardQuantityPrice(),
                            ),
                            const Spacer(),
                            Text(
                              '\$${activeItems![index].price.toStringAsFixed(2)}',
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

                          setState(() {
                            cartItems.add(CartItem(
                              product: activeItems![index],
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
              if (index != activeItems!.length - 1)
                const SizedBox(
                  width: 13,
                )
            ],
          );
        },
      ),
    );
  }
}
