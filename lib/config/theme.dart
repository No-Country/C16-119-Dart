import 'package:flutter/material.dart';

const colorSeed = Color(0xff1FCC79);
const scaffoldBackgroundColor = Color(0xFFFEFEFF);
//  Map<String, Color> palette() => {
//       "main": const Color(0xff1FCC79),
//       "warning": const Color(0xffFF6464),
//       "primaryText": const Color(0xff2E3E5C),
//       "secondaryText": const Color(0xff9FA5C0),
//       "border": const Color(0xffD0DBEA),
//     };

class AppTheme {
  final bool isDarkmode;

  AppTheme({required this.isDarkmode});
  ThemeData getTheme() {
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
  ThemeColors({
    this.main = const Color(0xff1FCC79),
    this.light = const Color(0xffbaf8d9),
    this.dark = const Color(0xff13824d),
    this.warning = const Color(0xffFF6464),
    this.primaryTitle = const Color(0xff3E5481),
    this.primaryText = const Color(0xff2E3E5C),
    this.secondaryText = const Color(0xff9FA5C0),
    this.border = const Color(0xffD0DBEA),
  });

  static ThemeColors palette() => ThemeColors();
}

// class ThemeTextStyle {
//   final TextStyle h1;
//   final TextStyle h2;
//   final TextStyle h3;
//   final TextStyle p1;
//   final TextStyle p2;
//   final palette = ThemeColors.palette();
//    ThemeTextStyle(
//       {this.h1 =  TextStyle(
//           fontWeight: FontWeight.w800,
//           fontSize: 16,
//           color: palette.primaryText),
//       this.h2,
//       this.h3,
//       this.p1,
//       this.p2
//       });

//   static ThemeColors text() => ThemeColors();
// }
