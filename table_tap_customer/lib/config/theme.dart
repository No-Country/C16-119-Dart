import 'package:flutter/material.dart';

const colorSeed = Color(0xff1FCC79);
const scaffoldBackgroundColor = Color(0xFFFFFEFF);

class AppTheme {
  final bool isDarkmode;

  AppTheme({required this.isDarkmode});
  ThemeData getTheme() {
    ThemeColors palette = ThemeColors.palette();
    return ThemeData(

        ///* General
        useMaterial3: true,
        colorSchemeSeed: colorSeed,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,

        ///* Texts
        textTheme: const TextTheme(
            // titleLarge: GoogleFonts.montserratAlternates()
            //   .copyWith( fontSize: 40, fontWeight: FontWeight.bold ),
            // titleMedium: GoogleFonts.montserratAlternates()
            //   .copyWith( fontSize: 30, fontWeight: FontWeight.bold ),
            // titleSmall: GoogleFonts.montserratAlternates()
            //   .copyWith( fontSize: 20 )
            ),

        ///* Scaffold Background Color
        scaffoldBackgroundColor: scaffoldBackgroundColor,

        ///* Buttons
        filledButtonTheme: const FilledButtonThemeData(
            style: ButtonStyle(
                // textStyle: MaterialStatePropertyAll(
                //   GoogleFonts.montserratAlternates()
                //     .copyWith(fontWeight: FontWeight.w700)
                //   )
                )),

        ///* AppBar
        appBarTheme: const AppBarTheme(
          color: scaffoldBackgroundColor,
          // titleTextStyle: GoogleFonts.montserratAlternates()
          //   .copyWith( fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: palette.main,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ));
  }
}

class ThemeColors {
  final Color main;
  final Color light;
  final Color dark;
  final Color warning;
  final Color primaryTitle;
  final Color primaryText;
  final Color secondaryText;
  final Color border;
  final Color bg;
  final Color form;
  final Color white;
  ThemeColors({
    this.main = const Color(0xff1FCC79),
    this.light = const Color(0xffdbfdec),
    this.dark = const Color(0xff13824d),
    this.warning = const Color(0xffFF6464),
    this.primaryTitle = const Color(0xff3E5481),
    this.primaryText = const Color(0xff2E3E5C),
    this.secondaryText = const Color(0xff9FA5C0),
    this.border = const Color(0xffD0DBEA),
    this.bg = const Color(0xffffffff),
    this.form = const Color(0xffF4F5F7),
    this.white = Colors.white,
  });

  static ThemeColors palette() => ThemeColors();
}

class ThemeTextStyle {
  final TextStyle h1 = TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 22,
      color: ThemeColors.palette().primaryText);
  final TextStyle h2 = TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 17,
      color: ThemeColors.palette().primaryText);
  final TextStyle h3 = TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 16,
      color: ThemeColors.palette().primaryText);
  final TextStyle p1 = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 17,
      color: ThemeColors.palette().secondaryText);
  final TextStyle p2 = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15,
      color: ThemeColors.palette().secondaryText);
}
