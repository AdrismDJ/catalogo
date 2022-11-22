import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:http/http.dart' as http;

import './screens/movies_overview_screen.dart';
import './screens/movie_detail_screen.dart';
import './providers/movies.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (ctx) => Movies(),
        /*builder: for older -provider- versions*/
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
