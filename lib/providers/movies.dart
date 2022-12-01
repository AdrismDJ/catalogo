import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
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

  Future<void> fetchAndSetMovies() async {
    final url = Uri.https(
        'flutter-db-89319-default-rtdb.firebaseio.com', '/movies.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Movie> loadedMovies = [];
      extractedData.forEach((movId, movData) {
        loadedMovies.add(Movie(
          id: movId,
          title: movData['title'],
          year: movData['year'],
          price: movData['price'],
          director: movData['director'],
          gender: movData['gender'],
          sinopsis: movData['sinopsis'],
          isFavorite: movData['isFavorite'],
          imageUrl: movData['imageUrl'],
        ));
      });
      _items = loadedMovies;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addMovie(Movie movie) async {
    final url = Uri.https(
        'https:flutter-db-89319-default-rtdb.firebaseio.com/movies.json');
    //final url = Uri.https('flutter-db-89319-default-rtdb.firebaseio.com', '/movies.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': movie.title,
          'year': movie.year,
          'price': movie.price,
          'director': movie.director,
          'gender': movie.gender,
          'sinopsis': movie.sinopsis,
          'imageUrl': movie.imageUrl,
          'isFavorite': movie.isFavorite,
        }),
      );
      final newMovie = Movie(
        title: movie.title,
        year: movie.year,
        price: movie.price,
        director: movie.director,
        gender: movie.gender,
        sinopsis: movie.sinopsis,
        imageUrl: movie.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newMovie);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateMovie(String id, Movie newMovie) async {
    final movIndex = _items.indexWhere((mov) => mov.id == id);
    if (movIndex >= 0) {
      final url = Uri.https(
          'flutter-db-89319-default-rtdb.firebaseio.com', '/movies/$id.json');
      await http.patch(url,
          body: json.encode({
            'title': newMovie.title,
            'year': newMovie.year,
            'price': newMovie.price,
            'director': newMovie.director,
            'gender': newMovie.gender,
            'sinopsis': newMovie.sinopsis,
            'imageUrl': newMovie.imageUrl,
          }));
      _items[movIndex] = newMovie;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteMovie(String id) async {
    final url = Uri.https(
        'flutter-db-89319-default-rtdb.firebaseio.com', '/movies/$id.json');
    final existingMovieIndex = _items.indexWhere((mov) => mov.id == id);
    var existingMovie = _items[existingMovieIndex];
    _items.removeAt(existingMovieIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingMovieIndex, existingMovie);
      notifyListeners();
      throw HttpException('Could not delete movie.');
    }
    existingMovie = null;
  }
}
