import 'package:flutter/material.dart';

var orange = const Color.fromARGB(220, 218, 165, 61);
var white = const Color.fromARGB(220, 251, 248, 255);
var red =const Color.fromARGB(220, 209, 50, 35);

var orangeDarkmode = const Color.fromARGB(220, 180, 127, 24);
var whiteDarkmode = const Color.fromARGB(220, 251, 248, 255);
var redDarkmode =const Color.fromARGB(220, 83, 20, 13);

var titleTextStyle = const TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold
);

var listTitleTextStyle = const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

var postTitleTextStyle = const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold
);

var commentAuthorTextStyle = const TextStyle(
  fontSize: 14,
);

var commentContentTextStyle = const TextStyle(
  fontSize: 14,
);

var buttonTextStyle = TextStyle(
  color: white,
  fontSize: 16
);

var subTextStyle = const TextStyle(
  fontSize: 12
);

var lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: orange, 
    primary: orange,
    secondary: Colors.black,
    background: white,
    tertiary: red,
  ),
  textTheme: const TextTheme().apply(bodyColor: Colors.black, displayColor: Colors.black),
  useMaterial3: true,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: red,
    foregroundColor: white,
    iconSize: 36
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(red),
      foregroundColor: MaterialStateProperty.all(white),
      textStyle: MaterialStateProperty.all(buttonTextStyle),
      padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(16, 0, 16, 0)),
      elevation: MaterialStateProperty.all(3.0),
      shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
    )
  ),
  cardTheme: const CardTheme(
    color: Colors.white
  ),
);

var darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: orangeDarkmode, 
    primary: orangeDarkmode,
    secondary: Colors.white,
    background: const Color.fromARGB(255, 14, 14, 14),
    tertiary: redDarkmode
  ),
  textTheme: const TextTheme().apply(bodyColor: Colors.white, displayColor: Colors.white),
  useMaterial3: true,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: redDarkmode,
    foregroundColor: whiteDarkmode,
    iconSize: 36
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(redDarkmode),
      foregroundColor: MaterialStateProperty.all(whiteDarkmode),
      textStyle: MaterialStateProperty.all(buttonTextStyle),
      padding: MaterialStateProperty.all(const EdgeInsets.fromLTRB(16, 0, 16, 0)),
      elevation: MaterialStateProperty.all(3.0),
      shape: MaterialStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
    )
  ),
  cardTheme: const CardTheme(
    color: Colors.black
  )
);

bool isDarkTheme = false;
Function(bool dark)? callback;

void callThemeChanged(bool dark) {
  callback!(dark);
}