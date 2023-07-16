import 'package:flutter/material.dart';

Color colorOne = Colors.deepPurple;
Color colorTwo = Colors.deepPurple[300];
Color colorThree = Colors.deepPurple[100];

final appTheme = ThemeData(
    fontFamily: "HappyMonkey",
    visualDensity: VisualDensity.adaptivePlatformDensity,
  primarySwatch: Colors.deepPurple,
  canvasColor: Color(0x31394c),
  cardTheme: CardTheme(
    color: Color(0xFF363636),
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: Color(0xFF181818),
  )
);
 extension ContextExtensions on BuildContext{
   ThemeData get theme => appTheme;
 }