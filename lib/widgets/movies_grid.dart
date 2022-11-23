import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movies.dart';
import './movie_item.dart';

class MoviesGrid extends StatelessWidget {
  final bool showFavs;

  MoviesGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final movieData = Provider.of<Movies>(context);
    final movies = showFavs ? movieData.favoriteItems : movieData.items;
    //final movies = movieData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: movies.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        //create: (c) => movies[i],
        value: movies[i],
        child: MovieItem(
            // movies[i].id,
            // movies[i].title,
            // movies[i].imageUrl,
            ),
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
