import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData DartTheme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColorDark: defoultColor,
  colorScheme: ColorScheme.dark(primary: Colors.white),
  // scaffoldBackgroundColor: const Color.fromARGB(255, 176, 175, 170),
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),

  scaffoldBackgroundColor: HexColor('333739'),
  textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18.0,
        letterSpacing: 2.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
      )
      // subtitle1: TextStyle(
      //   fontSize: 16.0,
      //   letterSpacing: 2.0,
      //   fontWeight: FontWeight.w400,
      //   color: Colors.white,
      // )
      ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defoultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
  ),
  // floatingActionButtonTheme: FloatingActionButtonThemeData(
  //   backgroundColor: Colors.amber[300],
  //   foregroundColor: Colors.white,
  // ),

  fontFamily: 'Jannah',
);
ThemeData LightTheme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColorLight: defoultColor,
  colorScheme: ColorScheme.light(primary: Colors.black),

  // scaffoldBackgroundColor: const Color.fromARGB(255, 176, 175, 170),
  primaryColor: defoultColor,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defoultColor,
    unselectedItemColor: Colors.grey,
    elevation: 0.0,
    backgroundColor: Colors.white,
  ),
  // floatingActionButtonTheme: FloatingActionButtonThemeData(
  //   backgroundColor: Colors.amber[300],
  //   foregroundColor: Colors.white,
  // ),

  fontFamily: 'Jannah',
);

Color defoultColor = Colors.blue;
