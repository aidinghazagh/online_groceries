import 'package:flutter/material.dart';
import 'package:online_groceries/data/true_false.dart';
import 'package:online_groceries/screens/home_screen.dart';
import 'package:online_groceries/widgets/get_started.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loggedList.logged ? const HomeScreen() : const GetStarted());
  }
}
