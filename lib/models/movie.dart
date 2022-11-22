import 'package:flutter/foundation.dart';

class Movie {
  final String id;
  final String title;
  final double year;
  final String director;
  final String gender;
  final String sinopsis;
  final String imageUrl;
  bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.director,
    required this.gender,
    required this.sinopsis,
    required this.imageUrl,
    this.isFavorite = false,
  });
}

/*
class Movie {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });
}
*/
