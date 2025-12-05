import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../managers/favorites_manager.dart';
import '../services/meal_api_service.dart';
import '../models/meal_detail.dart';
import 'meal_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  Future<List<MealDetail>> fetchMealsByIds(
      MealApiService api, List<String> ids) async {
    final List<MealDetail> result = [];

    for (final id in ids) {
      final detail = await api.getMealDetail(id);
      result.add(detail);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final fav = Provider.of<FavoritesManager>(context);
    final api = MealApiService();

    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: FutureBuilder<List<MealDetail>>(
        future: fetchMealsByIds(api, fav.favoriteIds),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No favorite meals yet."));
          }

          final meals = snapshot.data!;

          return ListView.builder(
            itemCount: meals.length,
            itemBuilder: (_, i) {
              final meal = meals[i];
              return ListTile(
                leading: Image.network(
                  meal.thumbnail,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                title: Text(meal.name),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MealDetailScreen(mealDetail: meal),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
