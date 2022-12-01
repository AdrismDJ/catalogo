import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Movie with ChangeNotifier {
  final String id;
  final String title;
  final int year;
  final double price;
  final String director;
  final String gender;
  final String sinopsis;
  final String imageUrl;
  bool isFavorite;

  Movie({
    @required this.id,
    @required this.title,
    @required this.year,
    @required this.price,
    @required this.director,
    @required this.gender,
    @required this.sinopsis,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.https('flutter-update.firebaseio.com', '/movies/$id.json');
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
