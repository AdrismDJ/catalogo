import 'package:catalogo/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/cart_screen.dart';
import './screens/movies_overview_screen.dart';
import './screens/movie_detail_screen.dart';
import './providers/movies.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_movies_screen.dart';
import './screens/edit_movie_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Movies(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
          title: 'Catálogo de Películas',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
                .copyWith(secondary: Colors.deepOrange),
            fontFamily: 'Lato',
          ),
          home: MoviesOverviewScreen(),
          routes: {
            MovieDetailScreen.routeName: (ctx) => MovieDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserMoviesScreen.routeName: (ctx) => UserMoviesScreen(),
            EditMovieScreen.routeName: (ctx) => EditMovieScreen(),
          }),
    );
  }
}
