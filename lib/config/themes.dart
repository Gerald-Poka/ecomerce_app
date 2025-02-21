import 'package:flutter/material.dart';

class AppTheme {
  static const binanceYellow = Color(0xFFF0B90B);

  static ThemeData lightTheme = ThemeData(
    // ignore: deprecated_member_use
    primarySwatch: MaterialColor(binanceYellow.value, {
      50: Color.fromRGBO(240, 185, 11, 0.1),
      100: Color.fromRGBO(240, 185, 11, 0.2),
      200: Color.fromRGBO(240, 185, 11, 0.3),
      300: Color.fromRGBO(240, 185, 11, 0.4),
      400: Color.fromRGBO(240, 185, 11, 0.5),
      500: Color.fromRGBO(240, 185, 11, 0.6),
      600: Color.fromRGBO(240, 185, 11, 0.7),
      700: Color.fromRGBO(240, 185, 11, 0.8),
      800: Color.fromRGBO(240, 185, 11, 0.9),
      900: binanceYellow,
    }),
    colorScheme: ColorScheme.fromSeed(seedColor: binanceYellow),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: binanceYellow,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    // ignore: deprecated_member_use
    primarySwatch: MaterialColor(binanceYellow.value, {
      50: Color.fromRGBO(240, 185, 11, 0.1),
      100: Color.fromRGBO(240, 185, 11, 0.2),
      200: Color.fromRGBO(240, 185, 11, 0.3),
      300: Color.fromRGBO(240, 185, 11, 0.4),
      400: Color.fromRGBO(240, 185, 11, 0.5),
      500: Color.fromRGBO(240, 185, 11, 0.6),
      600: Color.fromRGBO(240, 185, 11, 0.7),
      700: Color.fromRGBO(240, 185, 11, 0.8),
      800: Color.fromRGBO(240, 185, 11, 0.9),
      900: binanceYellow,
    }),
    colorScheme: ColorScheme.fromSeed(
      seedColor: binanceYellow,
      brightness: Brightness.dark,
    ),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.grey[900],
      iconTheme: const IconThemeData(color: binanceYellow),
      titleTextStyle: const TextStyle(color: binanceYellow, fontSize: 20),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
