// import 'package:flutter/material.dart';
// import 'services/meal_api_service.dart';
// import 'screens/categories_screen.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final apiService = MealApiService();
//
//     return MaterialApp(
//       title: 'Meals App',
//       theme: ThemeData(
//         useMaterial3: true,
//         colorSchemeSeed: Colors.deepOrange,
//       ),
//       home: CategoriesScreen(apiService: apiService),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/meal_api_service.dart';
import 'screens/categories_screen.dart';
import 'managers/favorites_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize favorites manager and load saved favorites
  final favoritesManager = FavoritesManager();
  await favoritesManager.load();

  runApp(MyApp(favoritesManager: favoritesManager));
}

class MyApp extends StatelessWidget {
  final FavoritesManager favoritesManager;

  const MyApp({super.key, required this.favoritesManager});

  @override
  Widget build(BuildContext context) {
    final apiService = MealApiService();

    return ChangeNotifierProvider.value(
      value: favoritesManager,
      child: MaterialApp(
        title: 'Meals App',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.deepOrange,
        ),
        home: CategoriesScreen(apiService: apiService),
      ),
    );
  }
}
