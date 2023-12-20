import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/screens/enter_number_screen.dart';
import 'package:online_groceries/text_styles/app_text_styles.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController phoneController = TextEditingController();

  String initalConuntry = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String startingCountry = 'US';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset('assets/images/signin.png'),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Get your groceries',
                        style: AppTextStyle.titleLarge(),
                      ),
                      Text(
                        'with nectar',
                        style: AppTextStyle.titleLarge(),
                      ),
                      IntlPhoneField(
                        showDropdownIcon: false,
                        onCountryChanged: (value) {
                          startingCountry = value.code.toString();
                        },
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => EnterNumberScreen(
                                        startingCountry: startingCountry,
                                      )))
                              .then((value) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          });
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          counterText: '',
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
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Or connect with social media',
                    style: AppTextStyle.welcomeSmall().copyWith(
                      fontSize: 12,
                      color: AppColors.onbackground2(),
                    ),
                  ),
                  const SizedBox(
                    height: 37.8,
                  ),
                  ElevatedButton.icon(
                    icon: Image.asset('assets/images/google.png'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19),
                      ),
                      fixedSize: const Size(364, 67),
                      backgroundColor: const Color.fromRGBO(83, 131, 236, 1),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignInScreen()));
                    },
                    label: Text(
                      'Continue with Google',
                      style: AppTextStyle.welcomeLarge().copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    icon: Image.asset('assets/images/facebook.png'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19),
                      ),
                      fixedSize: const Size(364, 67),
                      backgroundColor: const Color.fromRGBO(74, 102, 172, 1),
                    ),
                    onFocusChange: (value) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onPressed: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },
                    label: Text(
                      'Continue with Facebook',
                      style: AppTextStyle.welcomeLarge().copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
