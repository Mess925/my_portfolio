import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'theme/tokens.dart';
import 'widgets/section_header.dart';

class HeroHeader extends StatelessWidget {
  const HeroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 700;

    final headline = Text(
      'Mobile developer\n& software\nengineer.',
      style: textTheme.displayLarge?.copyWith(
        fontSize: isMobile ? 52 : 96,
      ),
    );

    final subtitle = Text(
      'I build cross-platform mobile applications and the low-level '
      'systems behind them — from APDU smartcard protocols and native C '
      'layers to polished Flutter UIs on Android and iOS.',
      style: textTheme.bodyLarge,
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headline,
          const SizedBox(height: AppSpacing.lg),
          subtitle,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(flex: 13, child: headline),
        const SizedBox(width: AppSpacing.xxl),
        Expanded(flex: 10, child: subtitle),
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
    'Python',
    'Next.js',
    'Supabase',
    'RevenueCat',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final palette = theme.extension<AppPalette>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(number: '03', title: 'Skills'),
        const SizedBox(height: AppSpacing.xl),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: _skills
              .map(
                (skill) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: palette.ink),
                  ),
                  child: Text(
                    skill,
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
