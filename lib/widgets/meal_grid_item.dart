// import 'package:flutter/material.dart';
// import '../models/meal_summary.dart';
//
// class MealGridItem extends StatelessWidget {
//   final MealSummary meal;
//   final VoidCallback onTap;
//
//   const MealGridItem({
//     super.key,
//     required this.meal,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: GridTile(
//         footer: Container(
//           color: Colors.black54,
//           padding: const EdgeInsets.all(4),
//           child: Text(
//             meal.name,
//             style: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             textAlign: TextAlign.center,
//           ),
//         ),
//         child: Image.network(
//           meal.thumbnail,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/meal_summary.dart';
import '../managers/favorites_manager.dart';

class MealGridItem extends StatelessWidget {
  final MealSummary meal;
  final VoidCallback onTap;

  const MealGridItem({
    super.key,
    required this.meal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fav = Provider.of<FavoritesManager>(context);

    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          GridTile(
            footer: Container(
              color: Colors.black54,
              padding: const EdgeInsets.all(4),
              child: Text(
                meal.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            child: Image.network(
              meal.thumbnail,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // HEART ICON (top-right)
          Positioned(
            top: 6,
            right: 6,
            child: GestureDetector(
              onTap: () {
                fav.toggle(meal.id);
              },
              child: Icon(
                fav.isFavorite(meal.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: fav.isFavorite(meal.id) ? Colors.red : Colors.white,
                size: 26,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
