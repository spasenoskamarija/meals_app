import 'package:flutter/material.dart';
import '../data/api_data.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_page.dart';

class MealsPage extends StatefulWidget {
  final String category;
  const MealsPage({required this.category, super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  List<Meal> meals = [];
  List<Meal> filtered = [];

  @override
  void initState() {
    super.initState();
    load();
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
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                return MealCard(
                  meal: filtered[i],
                  onTap: () async {
                    final detail = await ApiService.getMealDetail(filtered[i].id);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MealDetailPage(meal: detail),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
