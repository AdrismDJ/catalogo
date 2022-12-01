import 'package:catalogo/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/movie_detail_screen.dart';
import '../providers/movie.dart';
import '../providers/cart.dart';

class MovieItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // MovieItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final movie = Provider.of<Movie>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        // ignore: sort_child_properties_last
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              MovieDetailScreen.routeName,
              arguments: movie.id,
            );
          },
          child: Image.network(
            movie.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          /*leading: Consumer<Movie>(
            builder: (ctx, movie, _) => IconButton(
              icon: Icon(
                movie.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                movie.toggleFavoriteStatus();
              },
            ),
          ),*/
          title: Text(
            movie.title,
            textAlign: TextAlign.center,
          ), /*
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              cart.addItem(movie.id, movie.price, movie.title);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added item to cart!',
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(movie.id);
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).colorScheme.secondary,
          ),*/
        ),
      ),
    );
  }
}
