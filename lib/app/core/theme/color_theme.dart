import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ColorTheme {
  static MaterialColor primarySwatch = MaterialColor(
    primaryColor.value,
    <int, Color>{
      50: Color(0xFFFFF0E6),
      100: Color(0xFFF7D9C4),
      200: Color(0xFFFFCEB8),
      300: Color(0xFFF9AC9D),
      400: Color(0xFFFFB190),
      500: Color(primaryColor.value),
      600: Color(0xFFE56189),
      700: Color(0xFFB44C78),
      800: Color(0xFF903A73),
      900: Color(0xFF6B2A5F),
    },
  );

  static const Color whiteColor = Vx.white;

  static const Color successColor = Vx.green500;

  static const Color errorColor = Vx.red500;

  static const Color primaryColor = Color(0xFFFF7079);

  static const Color textColor = Color(0xff878787);
}
