import 'package:catalogo/Caja.dart';
import 'package:flutter/material.dart';

class TemplateColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        verticalDirection: VerticalDirection.down,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Caja(Colors.red, 1, 100.0),
          Caja(Colors.blue, 2, 100.0),
          Caja(Colors.yellow, 3, 100.0),
          Caja(Colors.green, 4, 100.0),
        ]);
  }
}
