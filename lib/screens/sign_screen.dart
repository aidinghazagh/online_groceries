import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/text_styles/app_text_styles.dart';
import 'package:online_groceries/widgets/login.dart';
import 'package:online_groceries/widgets/signup.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (MediaQuery.of(context).viewInsets.bottom == 0)
          Padding(
            padding: const EdgeInsets.only(top: 75),
            child: Image.asset('assets/images/carrot_fill.png'),
          ),
        const Spacer(),
        if (isLogin) const Login(),
        if (!isLogin) const SignUp(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLogin ? "Don't have an account?" : 'Already have an account ?',
              style: AppTextStyle.subtitle().copyWith(),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(
                isLogin ? 'Signup' : 'Login',
                style: AppTextStyle.subtitle()
                    .copyWith(color: AppColors.primary()),
              ),
            ),
          ],
        ),
        const Spacer(),
      ],
    );

    return Scaffold(
      body: SafeArea(child: content),
    );
  }
}
