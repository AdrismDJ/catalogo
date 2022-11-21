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
          title: Text("Catálogo de Películas"),
        ),
        body: Center(
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage('assets/images/Background.png'),
                  //height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Hello World',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0),
                  )),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(30.0),
                child: Icon(
                  Icons.star,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
