import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.red,
  primaryColor: Colors.red[900],
  primaryColorLight: Colors.red,
  buttonTheme: ButtonThemeData(
    padding: EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        25.0,
      ),
    ),
    disabledColor: Colors.white.withOpacity(0.1),
  ),
  cursorColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      color: Color(0x99ffffff),
    ),
    errorStyle: TextStyle(
      color: Colors.white,
    ),
    contentPadding: EdgeInsets.only(left: 30, bottom: 18, top: 18, right: 30),
    fillColor: Color(0x33ffffff),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(25.0),
      ),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(25.0),
      ),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(25.0),
      ),
      borderSide: BorderSide(
        width: 2,
        color: Colors.white,
        style: BorderStyle.solid,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(25.0),
      ),
      borderSide: BorderSide(
        width: 2,
        color: Colors.white,
        style: BorderStyle.solid,
      ),
    ),
  ),
);
