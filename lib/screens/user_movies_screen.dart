import 'package:catalogo/providers/movies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movie.dart';
import '../widgets/user_movie_item.dart';
import '../widgets/app_drawer.dart';
import './edit_movie_screen.dart';

class UserMoviesScreen extends StatelessWidget {
  static const routeName = '/user-movies';

  @override
  Widget build(BuildContext context) {
    final moviesData = Provider.of<Movies>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Movies'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditMovieScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: moviesData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserMovieItem(
                moviesData.items[i].id,
                moviesData.items[i].title,
                moviesData.items[i].imageUrl,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
