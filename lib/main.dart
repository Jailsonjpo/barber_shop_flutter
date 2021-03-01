import 'package:barber_shop_flutter/views/Home.dart';
import 'package:flutter/material.dart';

import 'RouteGenerator.dart';

void main(){

  runApp(MaterialApp(

   // home: Home(),
    initialRoute: "/",
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,

  ));

}