import 'package:flutter/material.dart';

final kTheme = ThemeData(
    colorScheme: ColorScheme(
  primary: Colors.black45,
  primaryVariant: Colors.black,
  secondary: Colors.orangeAccent,
  secondaryVariant: Colors.amberAccent,
  surface: Colors.white70,
  background: Colors.white,
  error: Colors.black45,
  onPrimary: Colors.black54,
  onSecondary: Colors.orangeAccent,
  onError: Colors.white70,
  onBackground: Colors.white,
  onSurface: Colors.black45,
  brightness: Brightness.light,
));

final kNumberTheme = TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 20,
);

final kTextTheme = TextStyle();

final kFormStyle = InputDecoration(
  labelText: 'Name',
);
