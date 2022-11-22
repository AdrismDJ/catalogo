import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movies.dart';

class MovieDetailScreen extends StatelessWidget {
  // final String title;
  // final double year;

  // MovieDetailScreen(this.title, this.year);
  static const routeName = 'product-detail';

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedMovie = Provider.of<Movies>(
      context,
      listen: false,
    ).findById(movieId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedMovie.title),
      ),
    );
  }
}
