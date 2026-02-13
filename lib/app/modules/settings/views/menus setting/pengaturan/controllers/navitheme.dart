import 'package:flutter/material.dart';

final ThemeData darkThemeCustom = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF1A1F36), // Navy gelap
  primaryColor: Colors.blueGrey[800],
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1A1F36),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF3F51B5),
    secondary: Color(0xFF7986CB),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white70),
  ),
);
