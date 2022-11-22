import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  // final String title;
  // final double year;

  // MovieDetailScreen(this.title, this.year);
  static const routeName = 'product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
    );
  }
}
