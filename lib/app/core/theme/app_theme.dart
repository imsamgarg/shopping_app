import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'color_theme.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    textTheme: GoogleFonts.nunitoTextTheme(),
    scaffoldBackgroundColor: ColorTheme.whiteColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorTheme.primaryColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: ColorTheme.primaryColor,
      centerTitle: true,
      elevation: 0,
    ),
    backgroundColor: ColorTheme.whiteColor,
    primarySwatch: ColorTheme.primarySwatch,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(primary: ColorTheme.primaryColor),
    primaryColorLight: ColorTheme.primaryColor,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: ColorTheme.primaryColor,
      selectionColor: ColorTheme.primaryColor,
      selectionHandleColor: ColorTheme.primaryColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateColor.resolveWith(
          (states) => Vx.white,
        ),
        backgroundColor: MaterialStateColor.resolveWith(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return ColorTheme.primaryColor.withOpacity(0.7);
            }
            return ColorTheme.primaryColor;
          },
        ),
      ),
    ),
  );
}
