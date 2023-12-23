import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/style/app_text_styles.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key, required this.autofocus});
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stack(
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
                autofocus: autofocus,
                onTap: () {},
                style: AppTextStyle.titleLarge().copyWith(fontSize: 16),
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
    ));
  }
}
