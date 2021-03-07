import 'dart:ui';
import 'package:barber_shop_flutter/main.dart';
import 'package:barber_shop_flutter/models/Usuario.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalheProfissional extends StatefulWidget {
  Usuario usuario;

  DetalheProfissional(this.usuario);

  @override
  _DetalheProfissionalState createState() => _DetalheProfissionalState();
}

class _DetalheProfissionalState extends State<DetalheProfissional> {

  Usuario _usuario;

  _ligarTelefone(String telefone) async {
    if (await canLaunch("tel:$telefone")) {
      await launch("tel:$telefone");
    } else {
      print("Não pode fazer a ligação");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usuario = widget.usuario;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: temaPadrao.primaryColor,
      appBar: AppBar(
        title: Text("Perfil"),
        backgroundColor: temaPadrao.accentColor,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(
                height: 250,
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: _usuario.photos != null ? NetworkImage(_usuario.photos) : NetworkImage("https://st3.depositphotos.com/1767687/16607/v/600/depositphotos_166074422-stock-illustration-default-avatar-profile-icon-grey.jpg"), fit: BoxFit.cover
                      )
                  ),
                )
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${_usuario.name}",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: temaPadrao.textSelectionColor),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider(),
                    ),
                    Text(
                      "${_usuario.email}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider(),
                    ),
                    Text(
                      "Sobre mim",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Divider(),
                    ),
                    Text(
                      "${_usuario.descricao}",
                      textAlign: TextAlign.justify,
                      style: TextStyle(

                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(),
                    ),
                    Text(
                      "Contato",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 66),
                      child: Text(
                        "${_usuario.phoneNumber}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),

          //botao ligar
          Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: GestureDetector(
                child: Container(
                  child: Text(
                    "Ligar",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  padding: EdgeInsets.all(16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: temaPadrao.textSelectionColor,
                      borderRadius: BorderRadius.circular(30)),
                ),
                onTap: () {
                  _ligarTelefone(_usuario.phoneNumber);
                },
              ))


        ],
      ),
    );
  }
}
