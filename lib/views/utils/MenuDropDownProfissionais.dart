import 'package:flutter/material.dart';

class MenuDropDownProfissionais {

  static List<DropdownMenuItem<String>> getCategoriasProfissionais() {
    List<DropdownMenuItem<String>> itensDropCategoriasProfissionais = [];

    //Categorias
    itensDropCategoriasProfissionais.add(DropdownMenuItem(
      child: Text(
        "Profissionais Disponíveis",
        style: TextStyle(color: Color(0xff9c27b0)),
      ),
      value: null,
    ));

    itensDropCategoriasProfissionais.add(DropdownMenuItem(
      child: Text("Jailson Pereira Oliveira"),
      value: "jailson",
    ));

    itensDropCategoriasProfissionais.add(DropdownMenuItem(
      child: Text("Jaqueline de Lima"),
      value: "Jaqueline",
    ));

    itensDropCategoriasProfissionais.add(DropdownMenuItem(
      child: Text("Mislene Teles"),
      value: "Mislene",
    ));

    itensDropCategoriasProfissionais.add(DropdownMenuItem(
      child: Text("Arthur Oliveira"),
      value: "Arthur",
    ));

    itensDropCategoriasProfissionais.add(DropdownMenuItem(
      child: Text("Hellen Ganzarolli"),
      value: "Hellen",
    ));

    itensDropCategoriasProfissionais.add(DropdownMenuItem(
      child: Text("Letícia Spiller"),
      value: "Leticia",
    ));

    return itensDropCategoriasProfissionais;
  }
}
