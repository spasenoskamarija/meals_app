// import 'package:flutter/material.dart';
// import '../data/favorite_service.dart';
// import '../models/meal.dart';
//
// class MealCard extends StatelessWidget {
//   final Meal meal;
//   final VoidCallback onTap;
//
//   const MealCard({required this.meal, required this.onTap, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Image.network(meal.img, height: 130, fit: BoxFit.cover),
//           SizedBox(height: 6),
//           Text(meal.name, maxLines: 2, textAlign: TextAlign.center),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import '../models/meal.dart';
//
// class MealCard extends StatelessWidget {
//   final Meal meal;
//   final VoidCallback onTap;
//   final VoidCallback onFavoriteToggle;
//   final bool isFavorite;
//
//   const MealCard({
//     required this.meal,
//     required this.onTap,
//     required this.onFavoriteToggle,
//     required this.isFavorite,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Stack(
//             children: [
//               Image.network(meal.img, height: 130, fit: BoxFit.cover),
//               Positioned(
//                 top: 8,
//                 right: 8,
//                 child: GestureDetector(
//                   onTap: onFavoriteToggle,
//                   child: Icon(
//                     isFavorite ? Icons.favorite : Icons.favorite_border,
//                     color: Colors.red,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 6),
//           Text(meal.name, maxLines: 2, textAlign: TextAlign.center),
//         ],
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;
  final bool isFavorite;

  const MealCard({
    required this.meal,
    required this.onTap,
    required this.onFavoriteToggle,
    required this.isFavorite,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      meal.img,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onFavoriteToggle,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                meal.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

