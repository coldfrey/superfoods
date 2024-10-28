import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Colors.blue,
      secondary: Colors.orange,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blueGrey[800],
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      displayLarge: TextStyle(
          color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(
          color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
      ),
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
    colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
      primary: Colors.blue,
      secondary: Colors.orange,
    ),
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blueGrey[900],
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      displayLarge: TextStyle(
          color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(
          color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
      ),
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
