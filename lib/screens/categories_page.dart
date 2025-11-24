import 'package:flutter/material.dart';
import '../data/api_data.dart';
import '../models/category.dart';
import '../widgets/category_card.dart';
import 'meals_page.dart';
import 'meal_detail_page.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Category> categories = [];
  List<Category> filtered = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    categories = await ApiService.getCategories();
    filtered = categories;
    setState(() {});
  }

  void search(String query) {
    filtered = categories
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: () async {
              final meal = await ApiService.getRandomMeal();
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => MealDetailPage(meal: meal)));
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search categories...",
                border: OutlineInputBorder(),
              ),
              onChanged: search,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                return CategoryCard(
                  category: filtered[i],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                          MealsPage(category: filtered[i].name),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
