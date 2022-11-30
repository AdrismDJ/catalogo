import 'package:flutter/material.dart';

import './movie.dart';

class Movies with ChangeNotifier {
  List<Movie> _items = [
    Movie(
      id: 'm1',
      title: 'The Terminator',
      year: 1984,
      price: 50,
      director: 'James Cameron',
      gender: 'Science fiction action',
      sinopsis:
          'A cyborg assassin is sent back in time to kill Sarah, a waitress, in a bid to stop her son who will wage a long war against his enemy in the future unless the course of history is altered.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/7/70/Terminator1984movieposter.jpg',
    ),
    Movie(
      id: 'm2',
      title: 'Die Hard',
      year: 1988,
      price: 50,
      director: 'John McTiernan',
      gender: 'Action',
      sinopsis:
          'Hoping to spend Christmas with his estranged wife, detective John McClane arrives in LA. However, he learns about a hostage situation in an office building and his wife is one of the hostages.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/c/ca/Die_Hard_%281988_film%29_poster.jpg',
    ),
    Movie(
      id: 'm3',
      title: 'Rocky',
      year: 1976,
      price: 50,
      director: 'John G. Avildsen',
      gender: 'Sports drama',
      sinopsis:
          'Rocky Balboa, a small-time boxer, gets a chance to fight heavyweight champion Apollo Creed. In a bid to earn respect and glory, Rocky jumps into the ring, unaware of the tough task ahead of him.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/1/18/Rocky_poster.jpg',
    ),
    Movie(
      id: 'm4',
      title: 'Back to the Future',
      year: 1985,
      price: 50,
      director: 'Robert Zemeckis',
      gender: 'Science fiction',
      sinopsis:
          "Marty travels back in time using an eccentric scientist's time machine. However, he must make his high-school-aged parents fall in love in order to return to the present.",
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/en/d/d2/Back_to_the_Future.jpg',
    ),
  ];

  //var _showFavoritesOnly = false;

  List<Movie> get items {
    return [..._items];
    // if (_showFavoritesOnly) {
    //   return _items.where((movItem) => movItem.isFavorite).toList();
    // } else {
    //   return [..._items];
    // }
  }

  List<Movie> get favoriteItems {
    return _items.where((movItem) => movItem.isFavorite).toList();
  }

  Movie findById(String id) {
    return _items.firstWhere((mov) => mov.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addMovie(Movie movie) {
    final newMovie = Movie(
      title: movie.title,
      year: movie.year,
      price: movie.price,
      director: movie.director,
      gender: movie.gender,
      sinopsis: movie.sinopsis,
      imageUrl: movie.imageUrl,
      id: DateTime.now().toString(),
    );
    _items.add(newMovie);
    // _items.insert(0, newMovie); // at the start of the list
    notifyListeners();
  }

  void updateMovie(String id, Movie newMovie) {
    final movIndex = _items.indexWhere((mov) => mov.id == id);
    if (movIndex >= 0) {
      _items[movIndex] = newMovie;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteMovie(String id) {
    _items.removeWhere((mov) => mov.id == id);
    notifyListeners();
  }
}
