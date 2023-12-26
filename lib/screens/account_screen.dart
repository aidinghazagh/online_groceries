import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/style/app_text_styles.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    listBuilder(String img, String text, String border) {
      return InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: AppColors.cardBorder()))),
          width: border == 'full'
              ? double.infinity
              : MediaQuery.of(context).size.width - 40,
          height: 62,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (border == 'full')
                    SizedBox(
                        width: MediaQuery.of(context).size.width -
                            (MediaQuery.of(context).size.width - 20)),
                  Image.asset('assets/images/$img'),
                  const SizedBox(width: 20),
                  Text(
                    text,
                    style: AppTextStyle.cardTitle(),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  if (border == 'full')
                    SizedBox(
                        width: MediaQuery.of(context).size.width -
                            (MediaQuery.of(context).size.width - 20)),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: AppColors.cardBorder()))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 30, left: 25, right: 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Image.asset('assets/images/user.png'),
                      ),
                      const SizedBox(width: 11),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Afsar Hossen',
                                style: AppTextStyle.titleLarge()
                                    .copyWith(fontSize: 20),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit_outlined,
                                    color: AppColors.primary(),
                                  ))
                            ],
                          ),
                          Text(
                            'Imshuvo97@gmail.com',
                            style: AppTextStyle.searchHint()
                                .copyWith(fontSize: 16, height: -0.2),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  listBuilder('orders.png', 'Orders', 'full'),
                  listBuilder('details.png', 'My Details', 'g'),
                  listBuilder('delivery.png', 'Delivery Address', 'g'),
                  listBuilder('payment.png', 'Payment Methods', 'full'),
                  listBuilder('promo.png', 'Promo', 'full'),
                  listBuilder('notifications.png', 'Notifications', 'full'),
                  listBuilder('help.png', 'Help', 'full'),
                  listBuilder('about.png', 'About', 'full'),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Stack(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19),
                    ),
                    fixedSize: const Size(364, 67),
                    backgroundColor: AppColors.productDetailImageContainer(),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Logout',
                    style: AppTextStyle.welcomeLarge().copyWith(
                      color: AppColors.primary(),
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    bottom: 0,
                    left: 25,
                    child: Icon(
                      Icons.logout,
                      color: AppColors.primary(),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
