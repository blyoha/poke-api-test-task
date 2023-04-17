import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFEF5350);
  static const Color secondary = Color(0xFFFECA1C);
  static const Color background = Color(0xFFDFF0D8);
}

ThemeData appTheme() {
  return ThemeData(
    splashColor: Colors.transparent,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: Colors.black,
      secondary: AppColors.secondary,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.red.withOpacity(0.5),
      background: AppColors.background,
      onBackground: Colors.black,
      surface: AppColors.background,
      onSurface: Colors.black,
    ),
  );
}
