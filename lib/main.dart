import 'package:flutter/material.dart';
import 'screens/categories_page.dart';

void main() {
  runApp(MealApp());
}

class MealApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TheMealDB Recipes",
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: CategoriesPage(),
    );
  }
}
