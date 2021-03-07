import 'package:barber_shop_flutter/main.dart';
import 'package:flutter/material.dart';

class Servicos extends StatefulWidget {
  @override
  _ServicosState createState() => _ServicosState();
}

class _ServicosState extends State<Servicos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: temaPadrao.primaryColor,
      appBar: AppBar(title: Text("Serviços"),
      backgroundColor: temaPadrao.accentColor,
      ),
    );
  }
}
