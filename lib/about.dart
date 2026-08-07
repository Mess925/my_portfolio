import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'theme/tokens.dart';
import 'widgets/eyebrow_label.dart';

class HeroHeader extends StatelessWidget {
  const HeroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EyebrowLabel('hthant.dev'),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Han Min Thant',
          style: textTheme.displayLarge?.copyWith(
            fontSize: isMobile ? 40 : 56,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Software engineer building cross-platform mobile apps and the '
          'systems behind them.',
          style: textTheme.bodyLarge?.copyWith(
            fontSize: isMobile ? 17 : 19,
          ),
        ),
      ],
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EyebrowLabel('About'),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'I build cross-platform mobile applications and low-level systems '
          'software. I enjoy working close to the hardware — from APDU '
          'smartcard protocols and native C layers to polished Flutter UIs '
          'on Android and iOS.',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const _skills = [
    'Flutter',
    'Dart',
    'C',
    'Swift',
    'Kotlin',
    'Python',
    'Next.js',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final palette = theme.extension<AppPalette>()!;
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EyebrowLabel('Skills'),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: _skills
              .map(
                (skill) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? palette.surface : palette.background,
                    border: Border.all(color: palette.border),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    boxShadow: isDark
                        ? null
                        : [
                            BoxShadow(
                              color: palette.shadow,
                              blurRadius: 6,
                              offset: const Offset(0, 1),
                            ),
                          ],
                  ),
                  child: Text(skill, style: textTheme.labelMedium),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
