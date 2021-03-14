import 'package:barber_shop_flutter/views/Agendar.dart';
import 'package:barber_shop_flutter/views/Cadastrar.dart';
import 'package:barber_shop_flutter/views/Configuracoes.dart';
import 'package:barber_shop_flutter/views/DetalheProfissional.dart';
import 'package:barber_shop_flutter/views/EditarServicos.dart';
import 'package:barber_shop_flutter/views/Home.dart';
import 'package:barber_shop_flutter/views/Login.dart';
import 'package:barber_shop_flutter/views/Profissional.dart';
import 'package:barber_shop_flutter/views/Servicos.dart';
import 'package:flutter/material.dart';
import 'models/Usuario.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {

    final args = settings.arguments;

    switch (settings.name) {

      case "/":
        return MaterialPageRoute(builder: (_) => Login());

     /*case "/":
        return MaterialPageRoute(builder: (_) => Agendar());*/

      case "/home":
        return MaterialPageRoute(builder: (_) => Home());

      case "/Serviços":
        return MaterialPageRoute(builder: (_) => Servicos());

        case "/Profissional":
        return MaterialPageRoute(builder: (_) => Profissional());

      case "/detalhes":
        return MaterialPageRoute(builder: (_) => DetalheProfissional(args as Usuario?));

      case "/cadastrar":
        return MaterialPageRoute(builder: (_) => Cadastrar());

      case "/configuracoes":
        return MaterialPageRoute(builder: (_) => Configuracoes());

      case "/editarServicos":
        return MaterialPageRoute(builder: (_) => EditarServicos());

      case "/Agendar":
        return MaterialPageRoute(builder: (_) => Agendar());

    }

    return null;
  }
}
