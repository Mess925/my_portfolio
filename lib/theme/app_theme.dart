import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Semantic color ladder for the editorial layout — background/surface,
/// a graduated ink ramp (full contrast down to faint meta text), border,
/// and an accent + its hover variant. Doesn't map onto Material's
/// `ColorScheme` roles cleanly, so it's a `ThemeExtension` instead: widgets
/// read `Theme.of(context).extension<AppPalette>()!` for both light and
/// dark values instead of branching on `Theme.of(context).brightness`.
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.background,
    required this.surface,
    required this.ink,
    required this.inkParagraph,
    required this.inkBody,
    required this.inkMuted,
    required this.inkFaint,
    required this.inkDate,
    required this.inkTag,
    required this.border,
    required this.accent,
    required this.accentHover,
    required this.shadow,
  });

  final Color background;
  final Color surface;
  final Color ink;
  final Color inkParagraph;
  final Color inkBody;
  final Color inkMuted;
  final Color inkFaint;
  final Color inkDate;
  final Color inkTag;
  final Color border;
  final Color accent;
  final Color accentHover;
  final Color shadow;

  static const light = AppPalette(
    background: Color(0xFFF8FAFD),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF0E1217),
    inkParagraph: Color(0xFF292929),
    inkBody: Color(0xFF3A3D45),
    inkMuted: Color(0xFF4A4D56),
    inkFaint: Color(0xFF54575F),
    inkDate: Color(0xFF60636B),
    inkTag: Color(0xFF6C6F78),
    border: Color(0xFFE3E4E8),
    accent: Color(0xFFBD4334),
    accentHover: Color(0xFFA3391F),
    shadow: Color(0x14000000),
  );

  static const dark = AppPalette(
    background: Color(0xFF15110F),
    surface: Color(0xFF1F1916),
    ink: Color(0xFFF4EFE9),
    inkParagraph: Color(0xFFE6DFD6),
    inkBody: Color(0xFFC9C1B5),
    inkMuted: Color(0xFFAAA194),
    inkFaint: Color(0xFF8F877A),
    inkDate: Color(0xFF7D766A),
    inkTag: Color(0xFF847C70),
    border: Color(0xFF332A24),
    accent: Color(0xFFBD4334),
    accentHover: Color(0xFFD2604A),
    shadow: Color(0x00000000),
  );

  @override
  AppPalette copyWith({
    Color? background,
    Color? surface,
    Color? ink,
    Color? inkParagraph,
    Color? inkBody,
    Color? inkMuted,
    Color? inkFaint,
    Color? inkDate,
    Color? inkTag,
    Color? border,
    Color? accent,
    Color? accentHover,
    Color? shadow,
  }) {
    return AppPalette(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      ink: ink ?? this.ink,
      inkParagraph: inkParagraph ?? this.inkParagraph,
      inkBody: inkBody ?? this.inkBody,
      inkMuted: inkMuted ?? this.inkMuted,
      inkFaint: inkFaint ?? this.inkFaint,
      inkDate: inkDate ?? this.inkDate,
      inkTag: inkTag ?? this.inkTag,
      border: border ?? this.border,
      accent: accent ?? this.accent,
      accentHover: accentHover ?? this.accentHover,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      inkParagraph: Color.lerp(inkParagraph, other.inkParagraph, t)!,
      inkBody: Color.lerp(inkBody, other.inkBody, t)!,
      inkMuted: Color.lerp(inkMuted, other.inkMuted, t)!,
      inkFaint: Color.lerp(inkFaint, other.inkFaint, t)!,
      inkDate: Color.lerp(inkDate, other.inkDate, t)!,
      inkTag: Color.lerp(inkTag, other.inkTag, t)!,
      border: Color.lerp(border, other.border, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentHover: Color.lerp(accentHover, other.accentHover, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
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
    final display = GoogleFonts.spaceGrotesk(
      fontWeight: FontWeight.w700,
      color: palette.ink,
      letterSpacing: -1.2,
      height: 1.1,
    );
    final body = GoogleFonts.spaceGrotesk(
      fontWeight: FontWeight.w400,
      color: palette.inkBody,
      height: 1.6,
    );
    final title = GoogleFonts.spaceGrotesk(
      fontWeight: FontWeight.w600,
      color: palette.ink,
      height: 1.3,
    );
    final mono = GoogleFonts.ibmPlexMono(color: palette.inkDate);

    return TextTheme(
      displayLarge: display.copyWith(fontSize: 56),
      titleMedium: title.copyWith(fontSize: 17),
      titleSmall: title.copyWith(fontSize: 15),
      bodyLarge: body.copyWith(fontSize: 19, color: palette.inkMuted),
      bodyMedium: body.copyWith(fontSize: 17, color: palette.inkParagraph),
      bodySmall: body.copyWith(fontSize: 15, color: palette.inkBody),
      labelLarge: mono.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.65,
        color: palette.accent,
      ),
      labelMedium: mono.copyWith(fontSize: 13, color: palette.inkTag),
      labelSmall: mono.copyWith(fontSize: 12, color: palette.inkTag),
    );
  }
}
