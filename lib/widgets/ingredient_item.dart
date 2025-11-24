import 'package:flutter/material.dart';

class IngredientItem extends StatelessWidget {
  final String ingredient;
  final String measure;

  const IngredientItem({required this.ingredient, required this.measure, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.check),
      title: Text(ingredient),
      trailing: Text(measure),
    );
  }
}
