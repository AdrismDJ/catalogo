//import 'dart:html';

import 'package:flutter/semantics.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

import '../widgets/movies_grid.dart';

class MoviesOverviewScreen extends StatelessWidget {
  const MoviesOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Películas'),
      ),
      body: MoviesGrid(),
    );
  }
}
