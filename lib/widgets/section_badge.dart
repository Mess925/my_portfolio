import 'package:flutter/material.dart';

import '../theme/tokens.dart';

/// Small monospace pill label used at the top of every section
/// (`AVAILABLE FOR WORK`, `SELECTED WORK`, `EXPERIENCE`, `GET IN TOUCH`).
class SectionBadge extends StatelessWidget {
  const SectionBadge(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: cs.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: cs.primary),
      ),
    );
  }
}
