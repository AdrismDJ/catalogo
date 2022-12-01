import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movies.dart';

class MovieDetailScreen extends StatelessWidget {
  // final String title;
  // final double year;

  // MovieDetailScreen(this.title, this.year);
  static const routeName = '/movie-detail';

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context).settings.arguments as String;
    final loadedMovie = Provider.of<Movies>(
      context,
      listen: false,
    ).findById(movieId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedMovie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // IMAGEN
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(loadedMovie.imageUrl, fit: BoxFit.cover),
            ),
            // ESPACIO
            SizedBox(height: 20),
            // TITULO
            Text(
              'Título: ${loadedMovie.title}',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            // ESPACIO
            SizedBox(height: 20),
            // AÑO
            Text(
              'Año: ${loadedMovie.year}',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            // ESPACIO
            SizedBox(height: 20),
            // DIRECTOR
            Text(
              'Director: ${loadedMovie.director}',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            // ESPACIO
            SizedBox(height: 20),
            // GENERO
            Text(
              'Genero: ${loadedMovie.gender}',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            // ESPACIO
            SizedBox(height: 20),
            // SINOPSIS
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: Text('Sinopsis: ${loadedMovie.sinopsis}',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(color: Colors.grey, fontSize: 20)),
            ),
            // ESPACIO
            SizedBox(height: 20),
            // PRECIO
            Text(
              'Precio: \$${loadedMovie.price}',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            // ESPACIO
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
