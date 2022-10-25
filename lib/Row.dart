import 'package:catalogo/Caja.dart';
import 'package:flutter/material.dart';

class TemplateRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        verticalDirection: VerticalDirection.down,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Caja(Colors.red, 1, 40.0),
          Caja(Colors.blue, 2, 40.0),
          Caja(Colors.yellow, 3, 40.0),
          Caja(Colors.green, 4, 40.0),
        ]);
  }
}
