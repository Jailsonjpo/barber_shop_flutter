import 'package:flutter/material.dart';
import 'RouteGenerator.dart';
import 'package:firebase_core/firebase_core.dart';

final ThemeData temaPadrao = ThemeData(
    primaryColor: Color(0xff151515),
    accentColor: Colors.black12,
    cardColor: Color(0xff242424),
    textSelectionColor: Color(0xff867638),
);


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    initialRoute: "/",
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}
