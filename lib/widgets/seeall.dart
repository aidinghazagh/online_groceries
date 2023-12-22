import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/style/app_text_styles.dart';

class SeeAll extends StatelessWidget {
  const SeeAll({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 30, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.pageTitle(),
          ),
          TextButton(
              onPressed: () {},
              child: Text('See all',
                  style: AppTextStyle.titleLarge()
                      .copyWith(color: AppColors.primary(), fontSize: 16)))
        ],
      ),
    );
  }
}
