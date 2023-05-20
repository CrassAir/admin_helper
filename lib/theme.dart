import 'package:flutter/material.dart';

class Styles {
  static ThemeData darkMode(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.green,
      primaryColor: Colors.black,
      backgroundColor: Colors.black,
      indicatorColor: const Color(0xff0E1D36),
      hintColor: Colors.white70,
      // highlightColor: const Color(0xff372901),
      hoverColor: const Color(0xff3A3A3B),
      focusColor: const Color(0xff0B2512),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
      ),
      disabledColor: Colors.grey,
      cardColor: Colors.black,
      cardTheme: const CardTheme(color: Color(0xff3A3A3B)),
      canvasColor: Colors.black,
      brightness: Brightness.dark,
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff3A3A3B)))),
      // appBarTheme: AppBarTheme(
      //   elevation: 0.0,
      // ),
      textTheme: const TextTheme(
        headline1: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 4),
        headline2: TextStyle(fontWeight: FontWeight.bold),
        headline3: TextStyle(fontWeight: FontWeight.bold),
        headline4: TextStyle(),
        headline5: TextStyle(),
        headline6: TextStyle(),
        subtitle1: TextStyle(),
        subtitle2: TextStyle(),
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
        button: TextStyle(),
      ),
      textSelectionTheme: const TextSelectionThemeData(selectionColor: Colors.white),
    );
  }

  static ThemeData lightMode(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      primarySwatch: Colors.green,
      primaryColor: Colors.white,
      backgroundColor: const Color(0xffe8e8e8),
      canvasColor: const Color(0xffe8e8e8),
      cardColor: const Color(0xffe8e8e8),
      cardTheme: const CardTheme(color: Color(0xffd4d4d5)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
      ),
    );
  }
}
