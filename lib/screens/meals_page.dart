import 'package:flutter/material.dart';
import '../data/api_data.dart';
import '../data/favorite_service.dart';
import '../models/favorite_model.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import 'favorites_page.dart';
import 'meal_detail_page.dart';
//
class MealsPage extends StatefulWidget {
  final String category;
  const MealsPage({required this.category, super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  List<Meal> meals = [];
  List<Meal> filtered = [];
  Set<String> favoriteIds = {};

  final FavoriteService favoriteService = FavoriteService();

  @override
  void initState() {
    super.initState();
    load();

    favoriteService.getFavorites().listen((favList) {
      setState(() {
        favoriteIds = favList.map((f) => f.mealId).toSet();
      });
    });
  }

  void load() async {
    meals = await ApiService.getMealsByCategory(widget.category);
    filtered = meals;
    setState(() {});
  }

  void search(String query) async {
    if (query.isEmpty) {
      filtered = meals;
    } else {
      filtered = await ApiService.searchMeals(query);
    }
    setState(() {});
  }

  void toggleFavorite(String mealId) async {
    final meal = meals.firstWhere((m) => m.id == mealId);

    setState(() {
      if (favoriteIds.contains(mealId)) {
        favoriteIds.remove(mealId);
      } else {
        favoriteIds.add(mealId);
      }
    });

    final favorite = Favorite(
      mealId: meal.id,
      name: meal.name,
      imageUrl: meal.img,
    );

    if (favoriteIds.contains(mealId)) {
      await favoriteService.addFavorite(favorite);
    } else {
      await favoriteService.removeFavorite(mealId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search meals...",
                border: OutlineInputBorder(),
              ),
              onChanged: search,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                final meal = filtered[i];
                return MealCard(
                  meal: meal,
                  isFavorite: favoriteIds.contains(meal.id),
                  onTap: () async {
                    final detail = await ApiService.getMealDetail(meal.id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MealDetailPage(meal: detail),
                      ),
                    );
                  },
                  onFavoriteToggle: () => toggleFavorite(meal.id),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite),
        onPressed: () {
          final favorites =
          meals.where((m) => favoriteIds.contains(m.id)).toList();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FavoritesPage(
                favoriteMeals: favorites,
                onFavoriteToggle: toggleFavorite,
              ),
            ),
          );
        },
      ),
    );
  }
}
