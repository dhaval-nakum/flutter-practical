import 'package:flutter/material.dart';
import 'package:flutter_practical/constants/app_colors.dart';

// A class to define the app's theme settings.
class AppTheme {
  // Light theme configuration.
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor), // Set the color scheme based on the primary color.
    useMaterial3: true, // Enable Material 3 design components.

    // Customize the AppBar appearance globally.
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor, // Set the global AppBar color.
      iconTheme: IconThemeData(color: AppColors.whiteColor), // Set the back button icon color.
      foregroundColor: AppColors.whiteColor, // Set the color of the text (title) on the AppBar.
    ),
  );
}
