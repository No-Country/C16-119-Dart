import 'package:flutter/material.dart';

// refreshListenable: goRouterNotifier,
const colorPrimary = Color.fromARGB(0xFF, 0x3E, 0x54, 0x81);
const colorSecondary = Color(0xff1FCC79);
const colorTerciario = Color.fromARGB(0xFF, 0x9F, 0xA5, 0xC0);
const colorPrincipal = Colors.white;

class AppTheme {
  ThemeData getTheme() => ThemeData(
        ///* General
        useMaterial3: true,
        colorSchemeSeed: colorSecondary,
        iconTheme: const IconThemeData(color: colorPrimary),

        ///* Buttons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(colorSecondary),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(colorSecondary),
          ),
        ),

        ///* Texts
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: colorPrimary),
          bodyMedium: TextStyle(
            fontSize: 18,
          ),
          bodySmall: TextStyle(
            fontSize: 16,
            color: colorTerciario,
          ),
          labelSmall: TextStyle(fontSize: 18, color: colorPrincipal),
        ),

        ///* Scaffold Background Color
        scaffoldBackgroundColor: colorPrincipal,

        ///* AppBar
        appBarTheme: const AppBarTheme(
          color: colorPrincipal,
        ),
      );
}
