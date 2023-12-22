import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/screens/select_location_screen.dart';
import 'package:online_groceries/style/app_text_styles.dart';

class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({super.key});

  @override
  State<EnterCodeScreen> createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  TextEditingController pinController = TextEditingController();
  int counter = 0;
  String dashes = '- - - - ';

  void goNext() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SelectLocationScreen(),
    ));
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    counter = pinController.text.length.toInt();
    switch (counter) {
      case 0:
        dashes = '- - - - ';
        break;
      case 1:
        dashes = '  - - -';
        break;
      case 2:
        dashes = '    - -';
        break;
      case 3:
        dashes = '      -';
        break;
      case 4:
        dashes = '       ';
        break;
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 65),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter your 4-digit code',
                  style: AppTextStyle.titleLarge(),
                ),
                const SizedBox(
                  height: 27,
                ),
                Text(
                  'Code',
                  style: AppTextStyle.welcomeSmall().copyWith(
                    color: const Color.fromRGBO(124, 124, 124, 1),
                  ),
                ),
                Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 15,
                      child: Text(
                        dashes,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Positioned(
                      child: TextField(
                        cursorColor: Colors.black,
                        onSubmitted: (value) {
                          goNext();
                        },
                        maxLength: 4,
                        onChanged: (value) => setState(() {}),
                        controller: pinController,
                        autofocus: true,
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
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 22),
            child: TextButton(
                onPressed: () {},
                child: Text(
                  'Resend Code',
                  style: TextStyle(color: AppColors.primary()),
                )),
          )
        ],
      ),
    );
  }
}
