import 'package:catalogo/Caja.dart';
import 'package:flutter/material.dart';

class TemplateStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomRight, children: <Widget>[
      Caja(Colors.red, 1, 400.0),
      Caja(Colors.blue, 2, 150.0),
      Caja(Colors.yellow, 3, 50.0),
    ]);
  }
}
