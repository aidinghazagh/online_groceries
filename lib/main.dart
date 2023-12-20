import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/screens/welcome_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        splashIconSize: 1000,
        backgroundColor: AppColors.primary(),
        splash: 'assets/images/splash.png',
        nextScreen: const WelcomeScreen(),
      ),
      routes: {
        '/home': (context) => const WelcomeScreen(),
      },
    );
  }
}
