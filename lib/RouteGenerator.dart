import 'package:barber_shop_flutter/views/Cadastrar.dart';
import 'package:barber_shop_flutter/views/Configuracoes.dart';
import 'package:barber_shop_flutter/views/DetalheProfissional.dart';
import 'package:barber_shop_flutter/views/Home.dart';
import 'package:barber_shop_flutter/views/Login.dart';
import 'package:barber_shop_flutter/views/Profissional.dart';
import 'package:barber_shop_flutter/views/Servicos.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Login());

      case "/home":
        return MaterialPageRoute(builder: (_) => Home());

      case "/Serviços":
        return MaterialPageRoute(builder: (_) => Servicos());

        case "/Profissional":
        return MaterialPageRoute(builder: (_) => Profissional());

      case "/detalhes":
        return MaterialPageRoute(builder: (_) => DetalheProfissional(args));

      case "/cadastrar":
        return MaterialPageRoute(builder: (_) => Cadastrar());

      case "/configuracoes":
        return MaterialPageRoute(builder: (_) => Configuracoes());

    }
  }
}
