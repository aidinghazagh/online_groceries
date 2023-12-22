import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/screens/sign_screen.dart';
import 'package:online_groceries/style/app_text_styles.dart';

const List<String> zone = <String>['Banarsee', 'Two', 'Three', 'Four'];
const List<String> area = <String>['One', 'Two', 'Three', 'Four'];

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  String? dropdownValue;
  String? dropdownValue1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 2),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/location.png'),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Select Your Location',
                    style: AppTextStyle.titleLarge(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Swithch on your location to stay in tune with',
                    style: AppTextStyle.labelDropDown(),
                  ),
                  Text(
                    'what’s happening in your area',
                    style: AppTextStyle.labelDropDown(),
                  )
                ],
              ),
              const SizedBox(
                height: 140,
              ),
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Zone',
                        style: AppTextStyle.labelDropDown(),
                      ),
                      DropdownButton(
                          value: dropdownValue,
                          isExpanded: true,
                          hint: Text(
                            'Types of your Zone',
                            style: AppTextStyle.hintDropDown(),
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: zone
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          }),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Your Area',
                        style: AppTextStyle.labelDropDown(),
                      ),
                      DropdownButton(
                          value: dropdownValue1,
                          isExpanded: true,
                          hint: Text(
                            'Types of your Area',
                            style: AppTextStyle.hintDropDown(),
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: zone
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              dropdownValue1 = value!;
                            });
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19),
                      ),
                      fixedSize: const Size(364, 67),
                      backgroundColor: AppColors.primary(),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignScreen()));
                    },
                    child: Text(
                      'Submit',
                      style: AppTextStyle.welcomeLarge().copyWith(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
