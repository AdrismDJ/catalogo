import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movies.dart';
import './movie_item.dart';

class MoviesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movieData = Provider.of<Movies>(context);
    final movies = movieData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: movies.length,
      itemBuilder: (ctx, i) => MovieItem(
        movies[i].id,
        movies[i].title,
        movies[i].imageUrl,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1 /*2*/,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
