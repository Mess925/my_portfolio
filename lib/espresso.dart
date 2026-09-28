import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'theme/app_theme.dart';
import 'theme/tokens.dart';
import 'widgets/hover_link.dart';

/// A tip tier shown on [EspressoPage] — no payment processor is wired up
/// yet, so tapping one just surfaces a "coming soon" toast instead of a
/// broken checkout link.
class _Shot {
  const _Shot(this.label, this.price, this.blurb);

  final String label;
  final String price;
  final String blurb;
}

const List<_Shot> _shots = [
  _Shot('Single Shot', '\$3', 'A quick espresso between commits.'),
  _Shot('Double Shot', '\$5', 'For the late-night debugging sessions.'),
  _Shot('Whole Bag', '\$10', 'Keeps me caffeinated for the week.'),
];

/// Standalone support page — reached via Navigator from the Contact
/// section, styled to match the rest of the editorial layout rather than
/// embedding a third-party widget.
class EspressoPage extends StatelessWidget {
  const EspressoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.extension<AppPalette>()!;
    final isMobile = MediaQuery.sizeOf(context).width < 700;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? AppSpacing.lg : AppSpacing.xl,
            vertical: AppSpacing.xl,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HoverLink(
                    text: '← Back',
                    underlineAtRest: false,
                    style: theme.textTheme.labelLarge,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  FaIcon(
                    FontAwesomeIcons.mugSaucer,
                    size: 40,
                    color: palette.accent,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Buy me an espresso',
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontSize: isMobile ? 40 : 56,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    "I run on black coffee and espresso. If something I "
                    "built helped you out, you can chip in for my next cup "
                    "— no third-party page, just this one.",
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  for (final shot in _shots) ...[
                    _ShotTile(shot: shot),
                    const SizedBox(height: AppSpacing.md),
                  ],
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Payments aren’t hooked up yet — check back soon.',
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShotTile extends StatefulWidget {
  const _ShotTile({required this.shot});

  final _Shot shot;

  @override
  State<_ShotTile> createState() => _ShotTileState();
}

class _ShotTileState extends State<_ShotTile> {
  bool _hovered = false;

  void _onTap(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Coming soon — thanks for the thought!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.extension<AppPalette>()!;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _onTap(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: _hovered ? palette.hoverTint : Colors.transparent,
            border: Border.all(color: palette.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.shot.label, style: theme.textTheme.titleSmall),
                    const SizedBox(height: 2),
                    Text(widget.shot.blurb, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                widget.shot.price,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
