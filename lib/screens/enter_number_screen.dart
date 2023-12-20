import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/screens/enter_code_screen.dart';
import 'package:online_groceries/text_styles/app_text_styles.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class EnterNumberScreen extends StatelessWidget {
  const EnterNumberScreen({super.key, required this.startingCountry});
  final String startingCountry;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String fullPhone = '';

    void goNext() {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const EnterCodeScreen(),
      ));
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: goNext,
          backgroundColor: AppColors.primary(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          )),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 65),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your mobile number',
              style: AppTextStyle.titleLarge(),
            ),
            const SizedBox(
              height: 27,
            ),
            Text(
              'Mobile Number',
              style: AppTextStyle.welcomeSmall().copyWith(
                color: const Color.fromRGBO(124, 124, 124, 1),
              ),
            ),
            IntlPhoneField(
              onSubmitted: (_) {
                goNext();
              },
              initialCountryCode: startingCountry,
              autofocus: true,
              onChanged: (value) {
                value;
              },
              keyboardType: TextInputType.number,
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
      ),
    );
  }
}
