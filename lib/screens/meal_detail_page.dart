import 'package:flutter/material.dart';
import '../models/meal_detail.dart';
import '../widgets/ingredient_item.dart';
import 'package:url_launcher/url_launcher.dart';


class MealDetailPage extends StatelessWidget {
  final MealDetail meal;

  const MealDetailPage({required this.meal, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meal.name)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              meal.img,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 15),
            Text(meal.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Instructions", style: TextStyle(fontSize: 20)),
            SizedBox(height: 5),
            Text(meal.instructions),
            SizedBox(height: 20),
            Text("Ingredients", style: TextStyle(fontSize: 20)),
            ...meal.ingredients.map(
                  (i) => IngredientItem(
                ingredient: i['ingredient']!,
                measure: i['measure']!,
              ),
            ),
            if (meal.linkYT.isNotEmpty) ...[
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  launchUrl(Uri.parse(meal.linkYT));
                },
                child: Text("Watch on YouTube"),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
