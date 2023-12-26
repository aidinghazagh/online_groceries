import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/style/app_text_styles.dart';

class OrderAcceptScreen extends StatelessWidget {
  const OrderAcceptScreen({super.key, required this.goToHome});
  final Function goToHome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/blur.png'), fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset('assets/images/accpeted-tick.png'),
                const SizedBox(height: 66),
                Text(
                  'Your Order has been \n accepted',
                  style: AppTextStyle.titleLarge(),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Your items has been placcd and is on \n it’s way to being processed',
                  style: AppTextStyle.searchHint(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                    fixedSize: const Size(364, 67),
                    backgroundColor: AppColors.primary(),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Track Order',
                    style: AppTextStyle.welcomeLarge().copyWith(
                      fontSize: 18,
                    ),
                  ),
                ),
                TextButton(
                    style: TextButton.styleFrom(fixedSize: const Size(364, 67)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      goToHome();
                    },
                    child: Text(
                      'Back to home',
                      style: AppTextStyle.cardTitle(),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
