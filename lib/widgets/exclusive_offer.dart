import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/models/product.dart';
import 'package:online_groceries/screens/product_detail.dart';
import 'package:online_groceries/style/app_text_styles.dart';

class HorizantalBuilder extends StatelessWidget {
  const HorizantalBuilder({super.key, required this.listName});

  final List<Product> listName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listName.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ProductDetail(product: listName[index])));
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
                              'assets/images/${listName[index].image}',
                              width: 103,
                              height: 62,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 33),
                            Text(
                              listName[index].name,
                              style: AppTextStyle.cardTitle(),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${listName[index].quantityPerPrice}, Price',
                              style: AppTextStyle.cardQuantityPrice(),
                            ),
                            const Spacer(),
                            Text(
                              listName[index].price,
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
                          onPressed: () {},
                          icon: Image.asset('assets/images/add-ic.png')),
                    ),
                  ],
                ),
              ),
              if (index != listName.length - 1)
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
