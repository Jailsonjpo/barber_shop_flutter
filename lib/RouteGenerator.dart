

import 'package:barber_shop_flutter/views/Home.dart';
import 'package:barber_shop_flutter/views/Login.dart';
import 'package:flutter/material.dart';

class RouteGenerator{

  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){

      case "/":
        return MaterialPageRoute(
            builder: (_) => Login()
        );

      case "home":
        return MaterialPageRoute(
            builder: (_) => Home()
        );

    }


  }


}