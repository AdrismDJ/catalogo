//import 'dart:html';
//import 'package:flutter/semantics.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

//import 'package:catalogo/providers/movies.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

import '../widgets/movies_grid.dart';
//import '../providers/movies.dart';

enum FilterOptions {
  Favorites,
  All,
}

class MoviesOverviewScreen extends StatefulWidget {
  @override
  _MoviesOverviewScreenState createState() => _MoviesOverviewScreenState();
}

class _MoviesOverviewScreenState extends State<MoviesOverviewScreen> {
  //const MoviesOverviewScreen({super.key});
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    //final moviesContainer = Provider.of<Movies>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Películas'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
        ],
      ),
      body: MoviesGrid(_showOnlyFavorites),
    );
  }
}
