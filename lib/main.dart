import 'package:catalogo/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:http/http.dart' as http;

import './screens/movies_overview_screen.dart';
import './screens/movie_detail_screen.dart';
import './providers/movies.dart';
import './providers/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider /*.value*/ (
            create: (ctx) => Movies(),
            //value: Movies(),
          ),
          ChangeNotifierProvider /*.value*/ (
            create: (ctx) => Cart(),
            //value: Cart(),
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
            }));
  }
}
