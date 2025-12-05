import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/meal_detail.dart';
import '../managers/favorites_manager.dart';

class MealDetailScreen extends StatelessWidget {
  final MealDetail mealDetail;

  const MealDetailScreen({super.key, required this.mealDetail});

  @override
  Widget build(BuildContext context) {
    final fav = Provider.of<FavoritesManager>(context);

    final bool isFav = fav.isFavorite(mealDetail.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(mealDetail.name),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : null,
            ),
            onPressed: () {
              fav.toggle(mealDetail.id);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              mealDetail.thumbnail,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          mealDetail.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : null,
                        ),
                        onPressed: () {
                          fav.toggle(mealDetail.id);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Ingredients',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  ...mealDetail.ingredients.map(
                        (ing) => Text('- ${ing.name} (${ing.measure})'),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Instructions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(mealDetail.instructions),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
