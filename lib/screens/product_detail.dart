import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/models/product.dart';
import 'package:online_groceries/style/app_text_styles.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  late final imgList = [
    'assets/images/${widget.product.image}',
    'assets/images/${widget.product.image}',
    'assets/images/${widget.product.image}',
  ];

  bool hearted = false;
  bool detailShow = true;
  int amount = 1;

  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 414,
                      height: 372,
                      decoration: BoxDecoration(
                        color: AppColors.productDetailImageContainer(),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: CarouselSlider(
                        carouselController: _controller,
                        options: CarouselOptions(
                            height: 271.5,
                            autoPlay: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                        items: [1, 2, 3].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 20,
                                        child: Container(
                                          width: 295,
                                          height: 171,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                'assets/images/${widget.product.image}',
                                              ),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 25, sigmaY: 25),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Image.asset(
                                          'assets/images/${widget.product.image}',
                                          fit: BoxFit.contain,
                                          height: 200,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imgList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: _current == entry.key ? 17 : 4,
                              height: 4,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: _current == entry.key ? 0 : 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: _current == entry.key
                                      ? AppColors.primary()
                                      : const Color.fromRGBO(0, 0, 0, 1)
                                          .withOpacity(0.3)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.name,
                            style: AppTextStyle.titleLarge()
                                .copyWith(fontSize: 24),
                          ),
                          Container(
                            transform: Matrix4.translationValues(15, 0, 0),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  hearted = !hearted;
                                });
                              },
                              icon: hearted
                                  ? Image.asset(
                                      'assets/images/heart-filled.png',
                                      width: 24,
                                    )
                                  : Image.asset(
                                      'assets/images/heart-empty.png',
                                      width: 24,
                                    ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.product.quantityPerPrice}, Price',
                            style: AppTextStyle.cardQuantityPrice()
                                .copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            transform: Matrix4.translationValues(-15, 0, 0),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (amount > 1) {
                                      setState(() {
                                        amount--;
                                      });
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    size: 35,
                                  ),
                                  color: AppColors.remove(),
                                ),
                                Container(
                                  width: 45.67,
                                  height: 45.67,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(17),
                                      border: Border.all(
                                          color: AppColors.cardBorder())),
                                  child: Center(
                                    child: Text(
                                      amount.toString(),
                                      style: AppTextStyle.titleLarge()
                                          .copyWith(fontSize: 18),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        amount++;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: AppColors.primary(),
                                      size: 35,
                                    )),
                              ],
                            ),
                          ),
                          Text(
                            widget.product.price,
                            style: AppTextStyle.titleLarge()
                                .copyWith(fontSize: 24),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top:
                                    BorderSide(color: AppColors.cardBorder()))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Product Detail',
                              style: AppTextStyle.detailSectionTitle(),
                            ),
                            Container(
                              transform: Matrix4.translationValues(15, 0, 0),
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      detailShow = !detailShow;
                                    });
                                  },
                                  icon: detailShow
                                      ? const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 35,
                                        )
                                      : const Icon(
                                          Icons.arrow_back_ios,
                                          size: 23,
                                        )),
                            )
                          ],
                        ),
                      ),
                      AnimatedContainer(
                        width: double.infinity,
                        height: detailShow ? 63 : 0,
                        duration: const Duration(milliseconds: 100),
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                widget.product.detail,
                                style: AppTextStyle.searchHint(),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top:
                                    BorderSide(color: AppColors.cardBorder()))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nutritions',
                              style: AppTextStyle.detailSectionTitle(),
                            ),
                            Container(
                              transform: Matrix4.translationValues(15, 0, 0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 33.61,
                                    height: 18,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors
                                            .detailNuiritionContainer()),
                                    child: Center(
                                      child: Text(
                                        widget.product.nutritions,
                                        style: AppTextStyle.searchHint()
                                            .copyWith(fontSize: 9),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.arrow_forward_ios))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top:
                                    BorderSide(color: AppColors.cardBorder()))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Review',
                              style: AppTextStyle.detailSectionTitle(),
                            ),
                            Container(
                              transform: Matrix4.translationValues(15, 0, 0),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      for (var i = 0;
                                          i < widget.product.review;
                                          i++)
                                        Icon(
                                          Icons.star,
                                          color: AppColors.detailStar(),
                                        ),
                                      for (var i = 0;
                                          i < (5 - widget.product.review);
                                          i++)
                                        const Icon(
                                          Icons.star,
                                        ),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.arrow_forward_ios))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19),
                          ),
                          fixedSize: const Size(364, 67),
                          backgroundColor: AppColors.primary(),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Add to Basket',
                          style: AppTextStyle.welcomeLarge().copyWith(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 38),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 25,
            top: 50,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          Positioned(
              right: 20,
              top: 50,
              child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.ios_share)))
        ],
      ),
    );
  }
}
