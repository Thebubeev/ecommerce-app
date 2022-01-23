import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Avenir',
      textTheme: textTheme());
}

TextTheme textTheme() {
  return const TextTheme(
    headline1: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 32),
    headline2: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 24),
    headline3: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
    headline4: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
    headline5: TextStyle(
        fontWeight: FontWeight.normal, color: Colors.black, fontSize: 14),
    headline6: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
    bodyText1: TextStyle(
        fontWeight: FontWeight.normal, color: Colors.black, fontSize: 12),
    bodyText2: TextStyle(
        fontWeight: FontWeight.normal, color: Colors.black, fontSize: 10),
  );
}
