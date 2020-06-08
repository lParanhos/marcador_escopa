import 'package:flutter/material.dart';
import 'package:marcador_escopa/utils/colors.dart';

Widget field(String label, int index, bool showButton, Function takeName,
    [Function removePlayer]) {
  return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(children: <Widget>[
        Flexible(
          child: TextFormField(
            validator: (String value) =>
                value.trim().isEmpty ? 'Insira um nome' : null,
            cursorColor: primary,
            onChanged: (text) {
              takeName(text, index);
            },
            decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(color: primary),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: primary))),
          ),
        ),
        if (removePlayer.toString() != "null")
          IconButton(
            color: primary,
            icon: Icon(Icons.delete),
            onPressed: removePlayer,
          )
      ]));
}
