import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Single source of truth for the portfolio's color palette.
///
/// One accent (a refined blue) drives primary/interactive color everywhere —
/// badges, tab indicators, links, hover states, and card accents all pull
/// from `colorScheme.primary` instead of hardcoding their own blue inline.
class AppColors {
  AppColors._();

  static const accent = Color(0xFF3D7AFF);

  static const darkBackground = Color(0xFF0B0D10);
  static const darkSurface = Color(0xFF14171B);
  static const darkOutline = Color(0xFF262A31);

  static const lightBackground = Color(0xFFFAFAFA);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightOutline = Color(0xFFE6E7EA);
}

/// Builds the light/dark [ThemeData] for the app, including a shared
/// [TextTheme] (Sora for display/headings, Inter for body, JetBrains Mono
/// for badges/tags/meta — reinforcing the minimal dev/terminal aesthetic).
class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.accent,
      onPrimary: Colors.white,
      surface: AppColors.lightBackground,
      onSurface: const Color(0xFF15181C),
      surfaceContainerLowest: AppColors.lightSurface,
      surfaceContainerHighest: AppColors.lightSurface,
      outlineVariant: AppColors.lightOutline,
    );

    return _base(colorScheme, AppColors.lightBackground);
  }

  static ThemeData dark() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AppColors.accent,
      onPrimary: Colors.white,
      surface: AppColors.darkBackground,
      onSurface: const Color(0xFFE7E9EC),
      surfaceContainerLowest: AppColors.darkSurface,
      surfaceContainerHighest: AppColors.darkSurface,
      outlineVariant: AppColors.darkOutline,
    );

    return _base(colorScheme, AppColors.darkBackground);
  }

  static ThemeData _base(ColorScheme colorScheme, Color background) {
    return ThemeData(
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      textTheme: _textTheme(colorScheme.onSurface),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        shadowColor: Colors.transparent,
      ),
    );
  }

  static TextTheme _textTheme(Color onSurface) {
    final display = GoogleFonts.sora(
      fontWeight: FontWeight.w800,
      color: onSurface,
      height: 1.05,
      letterSpacing: -1.5,
    );
    final heading = GoogleFonts.sora(
      fontWeight: FontWeight.w700,
      color: onSurface,
      letterSpacing: -0.3,
    );
    final body = GoogleFonts.inter(color: onSurface, height: 1.6);
    final mono = GoogleFonts.jetBrainsMono(color: onSurface);

    return TextTheme(
      displayLarge: display.copyWith(fontSize: 92),
      headlineLarge: display.copyWith(fontSize: 48, letterSpacing: -1.5),
      titleLarge: heading.copyWith(fontSize: 20),
      titleMedium: heading.copyWith(fontSize: 17),
      titleSmall: heading.copyWith(fontSize: 15),
      bodyLarge: body.copyWith(fontSize: 16),
      bodyMedium: body.copyWith(fontSize: 14, height: 1.6),
      bodySmall: body.copyWith(fontSize: 13),
      labelLarge: mono.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.8,
      ),
      labelMedium: mono.copyWith(
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
      labelSmall: mono.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
    );
  }
}
