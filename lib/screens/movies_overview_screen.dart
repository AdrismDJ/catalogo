//import 'package:catalogo/providers/cart.dart';
//import 'package:catalogo/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/movies_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import './cart_screen.dart';
import '../providers/movies.dart';

enum FilterOptions {
  Favorites,
  All,
}

class MoviesOverviewScreen extends StatefulWidget {
  @override
  _MoviesOverviewScreenState createState() => _MoviesOverviewScreenState();
}

class _MoviesOverviewScreenState extends State<MoviesOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Movies>(context).fetchAndSetMovies(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Movies>(context).fetchAndSetMovies();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Movies>(context).fetchAndSetMovies().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //final moviesContainer = Provider.of<Movies>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Películas'),
        /*actions: <Widget>[
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
                child: Text('Solo Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Mostrar TODO'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
              color: Colors.black,
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],*/
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : MoviesGrid(_showOnlyFavorites),
    );
  }
}
