import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/data/true_false.dart';
import 'package:online_groceries/screens/welcome_screen.dart';
import 'package:online_groceries/style/app_text_styles.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordShow = false;

  void goNext() {
    loggedList.logged = true;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => const WelcomeScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Loging',
                style: AppTextStyle.titleLarge(),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Enter your emails and password',
                style: AppTextStyle.labelDropDown(),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  value;
                },
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  label: Text(
                    'Email',
                    style: AppTextStyle.labelDropDown(),
                  ),
                  fillColor: AppColors.primary(),
                  focusColor: AppColors.primary(),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(226, 226, 226, 1),
                    ),
                  ),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(226, 226, 226, 1),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  TextField(
                    obscureText: !passwordShow,
                    enableSuggestions: false,
                    autocorrect: false,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      value;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      label: Text(
                        'Password',
                        style: AppTextStyle.labelDropDown(),
                      ),
                      fillColor: AppColors.primary(),
                      focusColor: AppColors.primary(),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(226, 226, 226, 1),
                        ),
                      ),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(226, 226, 226, 1),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordShow = !passwordShow;
                          });
                        },
                        icon: passwordShow
                            ? const Icon(Icons.remove_red_eye_rounded)
                            : const Icon(Icons.remove_red_eye_outlined)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: AppTextStyle.subtitle(),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(19),
            ),
            fixedSize: const Size(364, 67),
            backgroundColor: AppColors.primary(),
          ),
          onPressed: goNext,
          child: Text(
            'Log in',
            style: AppTextStyle.welcomeLarge().copyWith(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
