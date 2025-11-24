import 'package:flutter/material.dart';
import '../models/category.dart';


class CategoryCard extends StatelessWidget{
  final Category category;
  final VoidCallback onTap;

  const CategoryCard({required this.category,required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Column(
          children: [
            Image.network(category.img, height: 120, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(category.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Text(
              category.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
