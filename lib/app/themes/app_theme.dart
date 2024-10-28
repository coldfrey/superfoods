import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    accentColor: Colors.orange,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.blueGrey[900],
      iconTheme: IconThemeData(color: Colors.white),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.black),
      headline1: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
      headline2: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
      headline3: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
      headline4: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      headline5: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      headline6: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      filled: true,
      fillColor: Colors.grey[200],
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.blue,
    accentColor: Colors.orange,
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.blueGrey[900],
      iconTheme: IconThemeData(color: Colors.white),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.white),
      headline1: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
      headline2: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
      headline3: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      headline4: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      headline5: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      headline6: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      filled: true,
      fillColor: Colors.grey[800],
    ),
  );
}
