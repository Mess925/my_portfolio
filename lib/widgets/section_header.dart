import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../theme/tokens.dart';

/// Numbered section header row ("01 — Experience") with a rule line
/// filling the rest of the row, matching the reference design's motif.
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.number, required this.title});

  final String number;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.extension<AppPalette>()!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$number — ${title.toUpperCase()}',
          style: theme.textTheme.labelMedium?.copyWith(letterSpacing: 0.65),
        ),
        const SizedBox(width: AppSpacing.xl),
        Expanded(child: Divider(color: palette.ink, height: 1, thickness: 1)),
      ],
    );
  }
}
