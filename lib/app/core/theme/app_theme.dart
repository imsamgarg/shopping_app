import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'color_theme.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    textTheme: GoogleFonts.latoTextTheme(),
    scaffoldBackgroundColor: ColorTheme.whiteColor,
    backgroundColor: ColorTheme.whiteColor,
    primarySwatch: ColorTheme.primarySwatch,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(primary: ColorTheme.primaryColor),
    primaryColorLight: ColorTheme.primaryColor,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorTheme.primaryColor,
      selectionColor: ColorTheme.primaryColor,
      selectionHandleColor: ColorTheme.primaryColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle:
            MaterialStateProperty.resolveWith((states) => GoogleFonts.inter()),
      ),
    ),
  );
}
