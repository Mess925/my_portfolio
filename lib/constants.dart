// constants.dart
import 'package:flutter/material.dart';

class AppColors {
  // Classic 1990s Terminal Colors - True CRT Green on Black
  static const primary = Color(0xFF00FF00); // Pure terminal green
  static const primaryLight = Color(0xFF33FF33); // Bright phosphor green
  static const primaryDark = Color(0xFF00CC00); // Dark green
  static const secondary = Color(0xFF00FF00); // Green accent
  static const accent = Color(0xFF00DD00); // Phosphor glow

  // CRT scan effect color
  static const scanlineColor = Color(
    0xFF003300,
  ); // Very dark green for scanlines

  // Background colors - Pure CRT black
  static const darkBackground = Color(0xFF000000); // Pure black
  static const darkerBackground = Color(0xFF000000); // Pure black
  static const cardBackground = Color(0xFF001100); // Very dark green tint

  // Text colors - Phosphor green variations
  static const textPrimary = Color(0xFF00FF00); // Bright terminal green
  static const textSecondary = Color(0xFF00DD00); // Medium phosphor
  static const textMuted = Color(0xFF009900); // Dim green

  // Gradient combinations - Classic phosphor glow
  static const primaryGradient = LinearGradient(
    colors: [Color(0xFF00FF00), Color(0xFF00CC00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const accentGradient = LinearGradient(
    colors: [Color(0xFF33FF33), Color(0xFF00FF00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF00FF00).withOpacity(0.05),
      Color(0xFF00CC00).withOpacity(0.02),
    ],
  );

  static LinearGradient glassmorphicGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF00FF00).withOpacity(0.1),
      Color(0xFF00CC00).withOpacity(0.05),
    ],
  );

  // CRT Glow effects - Phosphor bloom
  static BoxShadow primaryGlow = BoxShadow(
    color: Color(0xFF00FF00).withOpacity(0.6),
    blurRadius: 40,
    spreadRadius: 2,
  );

  static BoxShadow accentGlow = BoxShadow(
    color: Color(0xFF00FF00).withOpacity(0.5),
    blurRadius: 30,
    spreadRadius: 1,
  );
}

class AppSizes {
  static const double mobileBreakpoint = 800.0;
  static const double tabletBreakpoint = 1200.0;

  static const double mobilePadding = 24.0;
  static const double tabletPadding = 56.0;
  static const double desktopPadding = 80.0;

  // Sharp 90s edges - no rounded corners!
  static const double borderRadiusSmall = 0.0;
  static const double borderRadiusMedium = 0.0;
  static const double borderRadiusLarge = 0.0;
  static const double borderRadiusXLarge = 0.0;
}

class AppAnimations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 600);
  static const Duration verySlow = Duration(milliseconds: 1200);

  static const Curve defaultCurve = Curves.easeInOutCubic;
  static const Curve bounceCurve = Curves.easeOutBack;
}

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < AppSizes.mobileBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppSizes.mobileBreakpoint &&
      MediaQuery.of(context).size.width < AppSizes.tabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppSizes.tabletBreakpoint;

  static double fontSize(
    BuildContext context, {
    required double mobile,
    required double tablet,
    required double desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }

  static EdgeInsets pagePadding(BuildContext context) {
    if (isMobile(context)) return const EdgeInsets.all(AppSizes.mobilePadding);
    if (isTablet(context)) return const EdgeInsets.all(AppSizes.tabletPadding);
    return const EdgeInsets.all(AppSizes.desktopPadding);
  }

  static double horizontalPadding(BuildContext context) {
    if (isMobile(context)) return 16.0;
    if (isTablet(context)) return 40.0;
    return 80.0;
  }

  static double verticalPadding(BuildContext context) {
    if (isMobile(context)) return 20.0;
    return 40.0;
  }
}
