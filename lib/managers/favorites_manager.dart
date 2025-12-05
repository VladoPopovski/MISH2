import 'package:flutter/material.dart';
import '../services/favorites_service.dart';

class FavoritesManager extends ChangeNotifier {
  final FavoritesService _service = FavoritesService();

  List<String> favoriteIds = [];

  Future<void> load() async {
    favoriteIds = await _service.loadFavorites();
    notifyListeners();
  }

  bool isFavorite(String id) {
    return favoriteIds.contains(id);
  }

  void toggle(String id) {
    if (isFavorite(id)) {
      favoriteIds.remove(id);
    } else {
      favoriteIds.add(id);
    }

    _service.saveFavorites(favoriteIds);
    notifyListeners();
  }
}
