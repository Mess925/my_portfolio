import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Semantic color ladder for the editorial layout — background, a
/// graduated ink ramp (full contrast down to faint meta text), border,
/// hover tint, and accent. Doesn't map onto Material's `ColorScheme` roles
/// cleanly, so it's a `ThemeExtension`: widgets read
/// `Theme.of(context).extension<AppPalette>()!` for both light and dark
/// values instead of branching on `Theme.of(context).brightness`.
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.background,
    required this.hoverTint,
    required this.ink,
    required this.inkParagraph,
    required this.inkBody,
    required this.inkMuted,
    required this.inkFaint,
    required this.border,
    required this.accent,
  });

  final Color background;
  final Color hoverTint;
  final Color ink;
  final Color inkParagraph;
  final Color inkBody;
  final Color inkMuted;
  final Color inkFaint;
  final Color border;
  final Color accent;

  static const light = AppPalette(
    background: Color(0xFFFAFAF7),
    hoverTint: Color(0xFFF2F1EA),
    ink: Color(0xFF111111),
    inkParagraph: Color(0xFF444444),
    inkBody: Color(0xFF555555),
    inkMuted: Color(0xFF666666),
    inkFaint: Color(0xFF888888),
    border: Color(0xFFE5E2DA),
    accent: Color(0xFF568100),
  );

  static const dark = AppPalette(
    background: Color(0xFF111110),
    hoverTint: Color(0xFF1C1C19),
    ink: Color(0xFFF2F0EA),
    inkParagraph: Color(0xFFB8B6AE),
    inkBody: Color(0xFFA8A6A0),
    inkMuted: Color(0xFFA3A19A),
    inkFaint: Color(0xFF7D7B74),
    border: Color(0xFF2A2A26),
    accent: Color(0xFF94CD2B),
  );

  @override
  AppPalette copyWith({
    Color? background,
    Color? hoverTint,
    Color? ink,
    Color? inkParagraph,
    Color? inkBody,
    Color? inkMuted,
    Color? inkFaint,
    Color? border,
    Color? accent,
  }) {
    return AppPalette(
      background: background ?? this.background,
      hoverTint: hoverTint ?? this.hoverTint,
      ink: ink ?? this.ink,
      inkParagraph: inkParagraph ?? this.inkParagraph,
      inkBody: inkBody ?? this.inkBody,
      inkMuted: inkMuted ?? this.inkMuted,
      inkFaint: inkFaint ?? this.inkFaint,
      border: border ?? this.border,
      accent: accent ?? this.accent,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      background: Color.lerp(background, other.background, t)!,
      hoverTint: Color.lerp(hoverTint, other.hoverTint, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      inkParagraph: Color.lerp(inkParagraph, other.inkParagraph, t)!,
      inkBody: Color.lerp(inkBody, other.inkBody, t)!,
      inkMuted: Color.lerp(inkMuted, other.inkMuted, t)!,
      inkFaint: Color.lerp(inkFaint, other.inkFaint, t)!,
      border: Color.lerp(border, other.border, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
    );
  }
}

class AppTheme {
  AppTheme._();

  static ThemeData light() => _build(AppPalette.light, Brightness.light);
  static ThemeData dark() => _build(AppPalette.dark, Brightness.dark);

  static ThemeData _build(AppPalette palette, Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: palette.accent,
      brightness: brightness,
    ).copyWith(
      primary: palette.accent,
      onPrimary: Colors.white,
      surface: palette.background,
      onSurface: palette.ink,
      outlineVariant: palette.border,
    );

    return ThemeData(
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: palette.background,
      textTheme: _textTheme(palette),
      extensions: [palette],
      appBarTheme: AppBarTheme(
        backgroundColor: palette.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  static TextTheme _textTheme(AppPalette palette) {
    final serif = GoogleFonts.instrumentSerif(
      fontWeight: FontWeight.w400,
      color: palette.ink,
      height: 1.0,
    );
    final body = GoogleFonts.inter(fontWeight: FontWeight.w400, height: 1.6);
    final mono = GoogleFonts.ibmPlexMono(color: palette.inkFaint);

    return TextTheme(
      displayLarge: serif.copyWith(fontSize: 96, letterSpacing: -0.96),
      titleLarge: serif.copyWith(fontSize: 28, height: 1.2),
      bodyLarge: body.copyWith(fontSize: 18, color: palette.inkParagraph),
      bodyMedium: body.copyWith(fontSize: 16, color: palette.inkParagraph),
      bodySmall: body.copyWith(fontSize: 15, color: palette.inkBody),
      titleSmall: body.copyWith(
        fontSize: 15,
        color: palette.inkMuted,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: mono.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: palette.ink,
      ),
      labelMedium: mono.copyWith(fontSize: 13, color: palette.inkMuted),
      labelSmall: mono.copyWith(fontSize: 12, color: palette.inkFaint),
    );
  }
}
