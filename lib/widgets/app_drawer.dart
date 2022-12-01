import 'package:flutter/material.dart';

import '../screens/orders_screen.dart';
import '../screens/user_movies_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hola Usuario!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Catálogo de Peliculas'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          /*
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),*/
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Administrar Peliculas'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserMoviesScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
