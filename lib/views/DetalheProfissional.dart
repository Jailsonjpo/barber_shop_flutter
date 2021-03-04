import 'package:barber_shop_flutter/main.dart';
import 'package:barber_shop_flutter/models/Usuario.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class DetalheProfissional extends StatefulWidget {
  @override
  _DetalheProfissionalState createState() => _DetalheProfissionalState();
}

class _DetalheProfissionalState extends State<DetalheProfissional> {

  Usuario _usuario;

  List<Widget> _getListaImagens() {
    List<String> listaUrlImagens = _usuario.photos;

    return listaUrlImagens.map((url) {
      return Container(
        height: 250,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(url), fit: BoxFit.fitWidth)),
      );
    }).toList();
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
                child: Carousel(
                  images: _getListaImagens(),
                  dotSize: 8,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.white,
                  autoplay: false,
                  dotIncreasedColor: temaPadrao.primaryColor,



                ),
              )
            ],
          )
        ],



      ),

    );
  }
}
