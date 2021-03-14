import 'package:flutter/material.dart';

class Configuracoes {

  static List<DropdownMenuItem<String>> getCategorias() {
    List<DropdownMenuItem<String>> itensDropCategorias = [];

    //Categorias
    itensDropCategorias.add(DropdownMenuItem(
      child: Text(
        "Disponíveis",
        style: TextStyle(color: Color(0xff9c27b0)),
      ),
      value: null,
    ));

    itensDropCategorias.add(DropdownMenuItem(
      child: Text("08:00"),
      value: "08:00",
    ));

    itensDropCategorias.add(DropdownMenuItem(
      child: Text("08:30"),
      value: "08:30",
    ));

    itensDropCategorias.add(DropdownMenuItem(
      child: Text("09:00"),
      value: "09:00",
    ));

    itensDropCategorias.add(DropdownMenuItem(
      child: Text("09:30"),
      value: "09:30",
    ));

    itensDropCategorias.add(DropdownMenuItem(
      child: Text("10:00"),
      value: "10:00",
    ));

    itensDropCategorias.add(DropdownMenuItem(
      child: Text("10:30"),
      value: "10:30",
    ));

    return itensDropCategorias;
  }
}
