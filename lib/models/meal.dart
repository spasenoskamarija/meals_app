class Meal {
  final String id;
  final String name;
  final String img;

  Meal({
    required this.id,
    required this.name,
    required this.img,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      img: json['strMealThumb'],
    );
  }
}
