import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'theme/tokens.dart';
import 'widgets/section_header.dart';

class ExperienceItem {
  const ExperienceItem({
    required this.period,
    required this.role,
    required this.company,
    required this.description,
  });

  final String period;
  final String role;
  final String company;
  final String description;
}

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  static const _experience = [
    ExperienceItem(
      period: 'Feb – Jul 2026',
      role: 'Software Engineer Intern',
      company: 'Thales DIS · Singapore',
      description:
          'Built a cross-platform Flutter application for Thales smartcard '
          'interaction, deployed on Android and iOS — demographic data, PIN '
          'management, certificate viewer, document signing with RSA/ECC '
          'encryption, and biometric verification, all via APDU commands. '
          'Also implemented the native layers in C and built a reusable SDK '
          'for the next developer to pick up.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final isMobile = MediaQuery.sizeOf(context).width < 700;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(number: '01', title: 'Experience'),
        const SizedBox(height: AppSpacing.xl),
        for (int i = 0; i < _experience.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: palette.border)),
            ),
            child: _ExperienceRow(item: _experience[i], isMobile: isMobile),
          ),
      ],
    );
  }
}

class _ExperienceRow extends StatelessWidget {
  const _ExperienceRow({required this.item, required this.isMobile});

  final ExperienceItem item;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final period = Text(item.period, style: textTheme.labelMedium);

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          spacing: AppSpacing.md,
          children: [
            Text(item.role, style: textTheme.titleLarge?.copyWith(fontSize: 24)),
            Text(item.company, style: textTheme.titleSmall),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(item.description, style: textTheme.bodySmall),
      ],
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [period, const SizedBox(height: AppSpacing.xs), content],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 140, child: period),
        const SizedBox(width: AppSpacing.xl),
        Expanded(child: content),
      ],
    );
  }
}
