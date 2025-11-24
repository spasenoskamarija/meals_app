import 'package:meals_app/models/meal.dart';

class MealDetail {
  final String id;
  final String name;
  final String img;
  final String instructions;
  final List<Map<String, String>> ingredients;
  final String linkYT;

  MealDetail({
    required this.id,
    required this.name,
    required this.img,
    required this.instructions,
    required this.ingredients,
    required this.linkYT
  });

  factory MealDetail.fromJson(Map<String,dynamic> data){
    List<Map<String,String>> ingredients = [];

    for(int i=1;i<=20;i++){
      final ing = data['strIngredient$i'];
      final measure = data['strMeasure$i'];

      if(ing != null && ing.toString().trim().isNotEmpty){
        ingredients.add({
          'ingredient' : ing,
          'measure': measure ?? "",
        });
      }
    }

    return MealDetail(
        id: data['idMeal'],
        name: data['strMeal'],
        img: data['strMealThumb'],
        instructions: data['strInstructions'],
        linkYT: data['strYoutube'] ?? "",
        ingredients: ingredients,
    );
  }
}
