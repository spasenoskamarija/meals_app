import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';

class FavoritesPage extends StatelessWidget {
  final List<Meal> favoriteMeals;
  final Function(String) onFavoriteToggle;

  const FavoritesPage({
    required this.favoriteMeals,
    required this.onFavoriteToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: favoriteMeals.isEmpty
          ? Center(child: Text('No favorites yet'))
          : GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: favoriteMeals.length,
        itemBuilder: (context, i) {
          final meal = favoriteMeals[i];
          return MealCard(
            meal: meal,
            isFavorite: true,
            onTap: () {},
            onFavoriteToggle: () => onFavoriteToggle(meal.id),
          );
        },
      ),
    );
  }
}
