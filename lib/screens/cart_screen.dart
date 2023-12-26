import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/data/cart_items.dart';
import 'package:online_groceries/screens/order_accpet_screen.dart';
import 'package:online_groceries/style/app_text_styles.dart';

class CartScreen extends StatefulWidget {
  const CartScreen(
      {super.key, required this.goToExplore, required this.goToHome});
  final Function goToExplore;
  final Function goToHome;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool orderAccepted = false;

  final List toRemove = [];
  @override
  void initState() {
    for (var i in cartItems) {
      var index = duplicates
          .indexWhere((element) => element.product.name == i.product.name);
      if (index != -1) {
        duplicates[index].amonut = duplicates[index].amonut + i.amonut;
        toRemove.add(i);
      } else {
        duplicates.add(i);
      }
    }
    cartItems.removeWhere((e) => toRemove.contains(e));
    super.initState();
  }

  bool firstDone = false;
  @override
  Widget build(BuildContext context) {
    double totalAmount = 0;
    for (var i = 0; i < duplicates.length; i++) {
      totalAmount += duplicates[i].amonut * duplicates[i].product.price;
    }
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Items in Cart',
            style: AppTextStyle.titleLarge(),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: TextButton.icon(
                label: Text(
                  'Go Shopping',
                  style: AppTextStyle.subtitle(),
                ),
                onPressed: () {
                  widget.goToExplore();
                },
                icon: Icon(
                  Icons.add_shopping_cart,
                  size: 50,
                  color: AppColors.primary(),
                )),
          )
        ],
      ),
    );

    if (duplicates.isNotEmpty) {
      content = Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: ListView.builder(
              itemCount: duplicates.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: 413,
                      height: 157,
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 25),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 25),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: AppColors.cardBorder()))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/${duplicates[index].product.image}',
                                  width: 70,
                                  height: 65,
                                ),
                                const SizedBox(width: 32.71),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          duplicates[index].product.name,
                                          style: AppTextStyle.cardTitle(),
                                        ),
                                        Text(
                                          '${duplicates[index].product.quantityPerPrice}, Price',
                                          style:
                                              AppTextStyle.cardQuantityPrice(),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 45.67,
                                          height: 45.67,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(17),
                                              border: Border.all(
                                                  color:
                                                      AppColors.cardBorder())),
                                          child: Container(
                                            transform:
                                                Matrix4.translationValues(
                                                    -3, -3, 0),
                                            child: IconButton(
                                              onPressed: () {
                                                if (duplicates[index].amonut >
                                                    1) {
                                                  setState(() {
                                                    duplicates[index].amonut--;
                                                  });
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.remove,
                                                size: 35,
                                              ),
                                              color: AppColors.remove(),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 17.45),
                                          child: Text(
                                            duplicates[index].amonut.toString(),
                                            style: AppTextStyle.titleLarge()
                                                .copyWith(fontSize: 18),
                                          ),
                                        ),
                                        Container(
                                          width: 45.67,
                                          height: 45.67,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(17),
                                              border: Border.all(
                                                  color:
                                                      AppColors.cardBorder())),
                                          child: Container(
                                            transform:
                                                Matrix4.translationValues(
                                                    -3, -3, 0),
                                            child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    duplicates[index].amonut++;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.add,
                                                  color: AppColors.primary(),
                                                  size: 35,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            duplicates
                                                .remove(duplicates[index]);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: AppColors.remove(),
                                        )),
                                    Text(
                                      '\$${(duplicates[index].amonut * duplicates[index].product.price).toStringAsFixed(2)}',
                                      style: AppTextStyle.cardPrice(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            bottom: 25,
            left: 25,
            right: 25,
            child: Stack(
              children: [
                Stack(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19),
                        ),
                        fixedSize: const Size(364, 67),
                        backgroundColor: AppColors.primary(),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 25,
                                              top: 30,
                                              right: 10,
                                              bottom: 30),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: AppColors
                                                          .cardBorder()))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Checkout',
                                                style:
                                                    AppTextStyle.titleLarge(),
                                              ),
                                              IconButton(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: const Icon(
                                                    size: 35,
                                                    Icons.close,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50,
                                          padding: const EdgeInsets.only(
                                              left: 0,
                                              top: 20,
                                              right: 0,
                                              bottom: 20),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: AppColors
                                                          .cardBorder()))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Delivery',
                                                style: AppTextStyle.cardTitle()
                                                    .copyWith(
                                                        color: AppColors
                                                            .checkOutSubTitle()),
                                              ),
                                              Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: TextButton.icon(
                                                    label: Text(
                                                      'Select Method',
                                                      style: AppTextStyle
                                                              .cardTitle()
                                                          .copyWith(
                                                              fontSize: 16),
                                                    ),
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      size: 25,
                                                      Icons.arrow_back_ios,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50,
                                          padding: const EdgeInsets.only(
                                              left: 0,
                                              top: 20,
                                              right: 0,
                                              bottom: 20),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: AppColors
                                                          .cardBorder()))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Pament',
                                                style: AppTextStyle.cardTitle()
                                                    .copyWith(
                                                        color: AppColors
                                                            .checkOutSubTitle()),
                                              ),
                                              Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        size: 25,
                                                        Icons.arrow_back_ios,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Image.asset(
                                                        'assets/images/card.png'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50,
                                          padding: const EdgeInsets.only(
                                              left: 0,
                                              top: 20,
                                              right: 0,
                                              bottom: 20),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: AppColors
                                                          .cardBorder()))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Promo Code',
                                                style: AppTextStyle.cardTitle()
                                                    .copyWith(
                                                        color: AppColors
                                                            .checkOutSubTitle()),
                                              ),
                                              Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: TextButton.icon(
                                                    label: Text(
                                                      'Pick discount',
                                                      style: AppTextStyle
                                                              .cardTitle()
                                                          .copyWith(
                                                              fontSize: 16),
                                                    ),
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      size: 25,
                                                      Icons.arrow_back_ios,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              50,
                                          padding: const EdgeInsets.only(
                                              left: 0,
                                              top: 20,
                                              right: 0,
                                              bottom: 20),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: AppColors
                                                          .cardBorder()))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Total Cost',
                                                style: AppTextStyle.cardTitle()
                                                    .copyWith(
                                                        color: AppColors
                                                            .checkOutSubTitle()),
                                              ),
                                              Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: TextButton.icon(
                                                    label: Text(
                                                      '\$${totalAmount.toStringAsFixed(2)}',
                                                      style: AppTextStyle
                                                              .cardTitle()
                                                          .copyWith(
                                                              fontSize: 16),
                                                    ),
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                      size: 25,
                                                      Icons.arrow_back_ios,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 20),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'By continuing you agree to our',
                                                    style: AppTextStyle
                                                            .labelDropDown()
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: const Text(
                                                      'Terms And Conditions',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 25),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              19),
                                                    ),
                                                    fixedSize:
                                                        const Size(364, 67),
                                                    backgroundColor:
                                                        AppColors.primary(),
                                                  ),
                                                  onPressed: () {
                                                    if (orderAccepted) {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  OrderAcceptScreen(
                                                                    goToHome: () =>
                                                                        widget
                                                                            .goToHome(),
                                                                  )));
                                                      duplicates.removeRange(
                                                          0, duplicates.length);
                                                    } else {
                                                      Navigator.of(context)
                                                          .pop();
                                                      showDialog(
                                                          context: context,
                                                          barrierDismissible:
                                                              false,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                                surfaceTintColor:
                                                                    Colors
                                                                        .transparent,
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                insetPadding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        20),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              18),
                                                                ),
                                                                content: Stack(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          364,
                                                                      height:
                                                                          601,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Column(
                                                                            children: [
                                                                              const SizedBox(height: 49),
                                                                              Image.asset('assets/images/fail.png'),
                                                                              const SizedBox(height: 49),
                                                                              Text(
                                                                                'Oops! Order Failed',
                                                                                style: AppTextStyle.titleLarge(),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                              const SizedBox(height: 20),
                                                                              Text(
                                                                                'Something went tembly wrong.',
                                                                                style: AppTextStyle.searchHint(),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            children: [
                                                                              ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(19),
                                                                                  ),
                                                                                  fixedSize: const Size(313, 67),
                                                                                  backgroundColor: AppColors.primary(),
                                                                                ),
                                                                                onPressed: () {},
                                                                                child: Text(
                                                                                  'Please Try Again',
                                                                                  style: AppTextStyle.welcomeLarge().copyWith(
                                                                                    fontSize: 18,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              TextButton(
                                                                                  style: TextButton.styleFrom(fixedSize: const Size(313, 67)),
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                    widget.goToHome();
                                                                                  },
                                                                                  child: Text(
                                                                                    'Back to home',
                                                                                    style: AppTextStyle.cardTitle(),
                                                                                  ))
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      left: -10,
                                                                      top: -3,
                                                                      child: IconButton(
                                                                          onPressed: () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          icon: const Icon(
                                                                            Icons.close,
                                                                            size:
                                                                                32,
                                                                          )),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ));
                                                    }
                                                  },
                                                  child: Text(
                                                    'Place Order',
                                                    style: AppTextStyle
                                                            .welcomeLarge()
                                                        .copyWith(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Text(
                        'Go to Checkout',
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
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            padding: const EdgeInsets.only(bottom: 32),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: AppColors.cardBorder()))),
            child: Text(
              'My Cart',
              style: AppTextStyle.pageTitle(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: content);
  }
}
