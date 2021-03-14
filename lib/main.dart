import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'RouteGenerator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xff151515),
  accentColor: Colors.black12,
  cardColor: Color(0xff242424),
  // ignore: deprecated_member_use
  textSelectionColor: Color(0xff867638),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  initializeDateFormatting().then((_) {
    Intl.defaultLocale = 'pt_BR';
    // initializeDateFormatting('pt_BR');

    runApp(MaterialApp(
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    ));
  });
}
