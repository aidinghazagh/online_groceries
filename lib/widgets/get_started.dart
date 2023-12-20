import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/screens/signin_screen.dart';
import 'package:online_groceries/text_styles/app_text_styles.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: -1,
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/onbording.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          child: Column(
            children: [
              Image.asset('assets/images/carrot.png'),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Welcome',
                style: AppTextStyle.welcomeLarge().copyWith(height: 1),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                'to our store',
                style: AppTextStyle.welcomeLarge().copyWith(height: 1),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Get your groceries in as fast as one hour',
                style: AppTextStyle.welcomeSmall(),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(19),
                  ),
                  fixedSize: const Size(353, 67),
                  backgroundColor: AppColors.primary(),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignInScreen()));
                },
                child: Text(
                  'Get Started',
                  style: AppTextStyle.welcomeLarge().copyWith(
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(
                height: 89,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
