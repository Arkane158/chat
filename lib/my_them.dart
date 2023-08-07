import 'package:flutter/material.dart';

class MyTheme {
  static var theme = ThemeData(
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
          color: Colors.transparent, elevation: 0, centerTitle: true),
      textTheme: const TextTheme(
          headlineMedium: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
          headlineLarge: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)));
}
