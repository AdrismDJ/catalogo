import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_movie_screen.dart';
import '../providers/movies.dart';

class UserMovieItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserMovieItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditMovieScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<Movies>(context, listen: false)
                      .deleteMovie(id);
                } catch (error) {
                  /*
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text(
                        'Deleting failed!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                */
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
