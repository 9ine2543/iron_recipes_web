import 'package:flutter/material.dart';
import 'package:iron_recipes/utils/screen.dart';

class MyText {
  MyText._();

  static TextStyle topics = TextStyle(
      fontSize: Screen.width * 0.022,
      fontWeight: FontWeight.w500,
      color: Colors.black);

  static TextStyle subTopics = TextStyle(
      fontSize: Screen.width * 0.018,
      fontWeight: FontWeight.w300,
      color: Color(0xffb4b4b4));

  static TextStyle howTo = TextStyle(
      fontSize: Screen.width * 0.022,
      fontWeight: FontWeight.w300,
      color: Colors.black);
}
