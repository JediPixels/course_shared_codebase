import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme() {
    return ThemeData.light(useMaterial3: true).copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: ThemeColors.lightBlue,
        brightness: Brightness.light,
        error: ThemeColors.error,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData.dark(useMaterial3: true).copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: ThemeColors.lightBlue,
        brightness: Brightness.dark,
        error: ThemeColors.error,
      ),
    );
  }
}

class ThemeColors {
  static const Color lightBlue = Colors.lightBlue;
  static const Color error = Colors.red;
  static Color washedOutLightWhite = Colors.white.withOpacity(0.1);
  static const Color black = Colors.black;
}
