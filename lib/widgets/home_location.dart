import 'package:flutter/material.dart';
import 'package:online_groceries/style/app_text_styles.dart';

class HomeLocation extends StatelessWidget {
  const HomeLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/location-ic.png'),
        const SizedBox(
          width: 7,
        ),
        Text(
          'Dhaka, Banassre',
          style: AppTextStyle.titleLarge().copyWith(fontSize: 18),
        ),
      ],
    );
  }
}
