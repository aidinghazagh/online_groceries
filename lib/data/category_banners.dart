import 'package:flutter/material.dart';
import 'package:online_groceries/colors/colors.dart';
import 'package:online_groceries/models/gorecires_category.dart';
import 'package:online_groceries/models/product.dart';

final allBaners = [
  GroceriesCategory(
      category: Category.fruit,
      image: 'fresh-fruits-vegteable.png',
      title: 'Frash Fruits & Vegetable',
      color: AppColors.primary()),
  const GroceriesCategory(
      category: Category.oil,
      image: 'cooking-oil-ghee.png',
      title: 'Cooking Oil & Ghee',
      color: Color.fromRGBO(248, 164, 76, 1)),
  const GroceriesCategory(
      category: Category.meat,
      image: 'meat-fish.png',
      title: 'Meat & Fish',
      color: Color.fromRGBO(247, 165, 147, 1)),
  const GroceriesCategory(
      category: Category.bakeryAndSnacks,
      image: 'bakery-snacks.png',
      title: 'Bakery & Snacks',
      color: Color.fromRGBO(211, 176, 224, 1)),
  const GroceriesCategory(
      category: Category.dairyAndEggs,
      image: 'dairy-eggs.png',
      title: 'Dairy & Eggs',
      color: Color.fromRGBO(253, 229, 152, 1)),
  const GroceriesCategory(
      category: Category.bevreges,
      image: 'bevreges.png',
      title: 'Beverages',
      color: Color.fromRGBO(183, 223, 245, 1)),
  GroceriesCategory(
      category: Category.fruit,
      image: 'fresh-fruits-vegteable.png',
      title: 'Frash Fruits & Vegetable',
      color: AppColors.primary()),
  GroceriesCategory(
      category: Category.fruit,
      image: 'fresh-fruits-vegteable.png',
      title: 'Frash Fruits & Vegetable',
      color: AppColors.primary()),
];
