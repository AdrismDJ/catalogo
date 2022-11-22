import 'package:flutter/material.dart';

import '../screens/movie_detail_screen.dart';

class MovieItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  MovieItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          // ignore: sort_child_properties_last
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                MovieDetailScreen.routeName,
                arguments: id,
              );
            },
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            /*leading: IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {},
              color: Theme.of(context).colorScheme.secondary,
            ),*/
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            /*trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {},
              color: Theme.of(context).colorScheme.secondary,
            ),*/
          ),
        ));
  }
}
