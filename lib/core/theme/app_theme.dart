import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.customWhite,
    colorScheme: const ColorScheme.light(
      primary: AppColors.customPrimaryBlue,
      onPrimary: Colors.white,
      secondary: AppColors.customMintGreen,
      onSecondary: Colors.white,
      background: AppColors.customWhite,
      onBackground: Colors.black,
    ),
  );
}
