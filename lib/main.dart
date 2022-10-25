import 'package:catalogo/Column.dart';
import 'package:catalogo/Row.dart';
import 'package:catalogo/Stack.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Catálogo de Películas'),
          ),
          body: Container(
            width: double.infinity,
            color: Colors.black,
            child: TemplateColumn(),
          )),
    );
  }
}
