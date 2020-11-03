import 'dart:js';

import 'package:flutter/material.dart';
import 'package:iron_recipes/pages/home.dart';
import 'package:iron_recipes/data.dart';
import 'package:iron_recipes/pages/recipePage.dart';
import 'pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Map<String, Widget Function(BuildContext)> routingPath = {
    '/': (context) => HomePage(),
    for (var i = 0; i < Data.allData.length; i++)
      for (var j = 0; j < Data.allData[i].length; j++)
        '/article/$i$j': (context) =>
            RecipePage(indexCategory: i, indexMenu: j),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iron Recipes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Kanit',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: routingPath,
    );
  }
}
