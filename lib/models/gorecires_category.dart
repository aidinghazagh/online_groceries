import 'package:flutter/material.dart';
import 'package:online_groceries/models/product.dart';

class GroceriesCategory {
  const GroceriesCategory(
      {required this.image,
      required this.title,
      required this.color,
      required this.category});

  final Category category;
  final String image;
  final String title;
  final Color color;
}
