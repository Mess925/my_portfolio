// constants.dart
import 'package:flutter/material.dart';

class AppColors {
  static const primaryCyan = Color(0xFF00BCD4);
  static const darkCyan = Color(0xFF0097A7);
  static const accentOrange = Color(0xFFFF6F00);
  static const darkBackground = Color(0xFF1A1A1A);
  static const darkerBackground = Color(0xFF0D0D0D);

  static const primaryGradient = LinearGradient(
    colors: [primaryCyan, darkCyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white.withOpacity(0.08), Colors.white.withOpacity(0.03)],
  );

  static LinearGradient glassmorphicGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white.withOpacity(0.15), Colors.white.withOpacity(0.05)],
  );
}

class AppSizes {
  static const double mobileBreakpoint = 800.0;
  static const double tabletBreakpoint = 1200.0;

  static const double mobilePadding = 24.0;
  static const double tabletPadding = 56.0;
  static const double desktopPadding = 80.0;

  static const double borderRadiusSmall = 12.0;
  static const double borderRadiusMedium = 16.0;
  static const double borderRadiusLarge = 20.0;
  static const double borderRadiusXLarge = 24.0;
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
