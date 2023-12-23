import 'package:flutter/material.dart';
import 'package:online_groceries/style/app_text_styles.dart';

class GroceriesCategory extends StatelessWidget {
  const GroceriesCategory(
      {super.key,
      required this.image,
      required this.title,
      required this.color});
  final String image;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 248,
          height: 105,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        Positioned(
            left: 17, top: 16, child: Image.asset('assets/images/$image')),
        Positioned(
          left: 103,
          top: 40,
          child: Text(
            title,
            style: AppTextStyle.cardTitle().copyWith(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
