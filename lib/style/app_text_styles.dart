import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle welcomeLarge() {
    return _textStyle('Gilroy', Colors.white, 48, FontWeight.bold);
  }

  static TextStyle welcomeSmall() {
    return _textStyle('Gilroy', const Color.fromRGBO(252, 252, 252, 0.7), 16,
        FontWeight.w100);
  }

  static TextStyle titleLarge() {
    return _textStyle('Gilroy', Colors.black, 26, FontWeight.bold);
  }

  static TextStyle hintDropDown() {
    return _textStyle(
        'Gilroy', const Color.fromRGBO(177, 177, 177, 1), 18, FontWeight.w100);
  }

  static TextStyle labelDropDown() {
    return _textStyle('Gilroy', const Color.fromRGBO(124, 124, 124, 1), 16,
        FontWeight.normal);
  }

  static TextStyle subtitle() {
    return _textStyle(
        'Gilroy', const Color.fromRGBO(24, 23, 37, 1), 14, FontWeight.w100);
  }

  static TextStyle pageTitle() {
    return _textStyle(
        'Gilroy', const Color.fromRGBO(24, 23, 37, 1), 20, FontWeight.bold);
  }

  static TextStyle searchHint() {
    return _textStyle(
        'Gilroy', const Color.fromRGBO(124, 124, 124, 1), 14, FontWeight.bold);
  }

  static TextStyle cardTitle() {
    return _textStyle(
        'Gilroy', const Color.fromRGBO(24, 23, 37, 1), 16, FontWeight.bold);
  }

  static TextStyle cardPrice() {
    return _textStyle(
        'Gilroy', const Color.fromRGBO(24, 23, 37, 1), 18, FontWeight.bold);
  }

  static TextStyle cardQuantityPrice() {
    return _textStyle('Gilroy', const Color.fromRGBO(124, 124, 124, 1), 14,
        FontWeight.normal);
  }

  static TextStyle _textStyle(
      String fontFamily, Color color, double size, FontWeight fontWeight) {
    return TextStyle(
      fontFamily: fontFamily,
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    );
  }
}
