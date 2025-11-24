import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;

  const MealCard({required this.meal, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.network(meal.img, height: 130, fit: BoxFit.cover),
          SizedBox(height: 6),
          Text(meal.name, maxLines: 2, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
