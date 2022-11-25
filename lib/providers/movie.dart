import 'package:flutter/foundation.dart';

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
    required this.id,
    required this.title,
    required this.year,
    required this.price,
    required this.director,
    required this.gender,
    required this.sinopsis,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
