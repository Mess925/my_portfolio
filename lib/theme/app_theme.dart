import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Palette matching the reference design (`hthant-portfolio.dc.html`), which
/// specifies colors in OKLCH. Flutter's `Color` has no OKLCH support, and
/// pulling in a conversion package isn't worth it for a fixed palette, so
/// these are the OKLCH values converted to sRGB hex by hand:
///   background   oklch(0.985 0.004 250) -> #F8FAFD
///   ink          oklch(0.18  0.012 250) -> #0E1217
///   accent       oklch(0.55  0.16  30)  -> #BD4334
///   accentDark   oklch(0.45  0.18  30)  -> #A3391F
///   border       oklch(0.9   0.005 250) -> #E3E4E8
/// The gray text ladder (oklch L .28/.35/.4/.45/.5/.55, ~0 chroma) converts
/// to a near-neutral charcoal ramp.
class AppColors {
  AppColors._();

  static const background = Color(0xFFF8FAFD);
  static const ink = Color(0xFF0E1217);
  static const inkParagraph = Color(0xFF292929); // L .28
  static const inkBody = Color(0xFF3A3D45); // L .35
  static const inkMuted = Color(0xFF4A4D56); // L .4
  static const inkFaint = Color(0xFF54575F); // L .45
  static const inkDate = Color(0xFF60636B); // L .5
  static const inkTag = Color(0xFF6C6F78); // L .55
  static const border = Color(0xFFE3E4E8);
  static const accent = Color(0xFFBD4334);
  static const accentDark = Color(0xFFA3391F);
}

/// Single light theme (the reference design has no dark mode). Space
/// Grotesk for display/body text, IBM Plex Mono for the uppercase eyebrow
/// labels, tags, and dates/stack meta.
class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.accent,
      onPrimary: Colors.white,
      surface: AppColors.background,
      onSurface: AppColors.ink,
      outlineVariant: AppColors.border,
    );

    return ThemeData(
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: _textTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  static TextTheme _textTheme() {
    final display = GoogleFonts.spaceGrotesk(
      fontWeight: FontWeight.w600,
      color: AppColors.ink,
      letterSpacing: -0.96,
      height: 1.15,
    );
    final body = GoogleFonts.spaceGrotesk(
      fontWeight: FontWeight.w400,
      color: AppColors.inkBody,
      height: 1.6,
    );
    final title = GoogleFonts.spaceGrotesk(
      fontWeight: FontWeight.w600,
      color: AppColors.ink,
      height: 1.3,
    );
    final mono = GoogleFonts.ibmPlexMono(color: AppColors.inkDate);

    return TextTheme(
      displayLarge: display.copyWith(fontSize: 48),
      titleMedium: title.copyWith(fontSize: 17),
      titleSmall: title.copyWith(fontSize: 15),
      bodyLarge: body.copyWith(fontSize: 19, color: AppColors.inkMuted),
      bodyMedium: body.copyWith(fontSize: 17, color: AppColors.inkParagraph),
      bodySmall: body.copyWith(fontSize: 15, color: AppColors.inkBody),
      labelLarge: mono.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.65,
        color: AppColors.accent,
      ),
      labelMedium: mono.copyWith(fontSize: 13, color: AppColors.inkTag),
      labelSmall: mono.copyWith(fontSize: 12, color: AppColors.inkTag),
    );
  }
}
