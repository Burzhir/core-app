import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        secondary: AppColors.teal,
        surface: AppColors.surface,
        error: Color(0xFFFF6B6B),
      ),
      fontFamily: 'Outfit',
      textTheme: const TextTheme(
        displayLarge:
            TextStyle(color: AppColors.textPrimary, fontFamily: 'Outfit'),
        displayMedium:
            TextStyle(color: AppColors.textPrimary, fontFamily: 'Outfit'),
        displaySmall:
            TextStyle(color: AppColors.textPrimary, fontFamily: 'Outfit'),
        headlineLarge:
            TextStyle(color: AppColors.textPrimary, fontFamily: 'Outfit'),
        headlineMedium:
            TextStyle(color: AppColors.textPrimary, fontFamily: 'Outfit'),
        headlineSmall:
            TextStyle(color: AppColors.textPrimary, fontFamily: 'Outfit'),
        titleLarge: TextStyle(
            color: AppColors.textPrimary,
            fontFamily: 'Outfit',
            fontWeight: FontWeight.w700),
        titleMedium:
            TextStyle(color: AppColors.textSecondary, fontFamily: 'Outfit'),
        titleSmall:
            TextStyle(color: AppColors.textSecondary, fontFamily: 'Outfit'),
        bodyLarge:
            TextStyle(color: AppColors.textPrimary, fontFamily: 'Outfit'),
        bodyMedium:
            TextStyle(color: AppColors.textSecondary, fontFamily: 'Outfit'),
        bodySmall: TextStyle(color: AppColors.textMuted, fontFamily: 'Outfit'),
        labelLarge: TextStyle(
            color: AppColors.textPrimary,
            fontFamily: 'Outfit',
            fontWeight: FontWeight.w700),
        labelMedium:
            TextStyle(color: AppColors.textSecondary, fontFamily: 'Outfit'),
        labelSmall: TextStyle(color: AppColors.textMuted, fontFamily: 'Outfit'),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: 'Outfit',
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surface,
        contentTextStyle: const TextStyle(
          color: AppColors.textPrimary,
          fontFamily: 'Outfit',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.border),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
      ),
      iconTheme: const IconThemeData(color: AppColors.textSecondary),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.accent,
      ),
    );
  }

  /// Light mode mirrors dark — CORE is a dark-first app.
  static ThemeData light() => dark();
}
