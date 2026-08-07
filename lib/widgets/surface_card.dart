import 'package:flutter/material.dart';

import '../theme/tokens.dart';

/// Shared bordered/shadowed card used across About, Experience, Projects,
/// and Contact — a thin accent top bar, hover tint, and consistent
/// radius/shadow so the pattern renders identically everywhere instead of
/// via slightly-drifted copies per page.
///
/// Pass [onTap] to make the card interactive (adds ripple + hover state).
/// Without it, the card renders as a static container with its accent bar
/// always at full strength (used for the non-interactive Experience card).
class SurfaceCard extends StatefulWidget {
  const SurfaceCard({
    super.key,
    required this.builder,
    this.onTap,
    this.accentColor,
    this.showAccentBar = true,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.borderRadius = AppRadius.xl,
  });

  /// Builds the card's inner content. [hovered] lets content react to the
  /// same hover state driving the card's border/background (e.g. an arrow
  /// icon sliding, a tag chip tinting) — always `false` for non-interactive
  /// cards (no [onTap]).
  final Widget Function(BuildContext context, bool hovered) builder;
  final VoidCallback? onTap;
  final Color? accentColor;
  final bool showAccentBar;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  @override
  State<SurfaceCard> createState() => _SurfaceCardState();
}

class _SurfaceCardState extends State<SurfaceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final accent = widget.accentColor ?? cs.primary;
    final interactive = widget.onTap != null;
    final accentBarActive = _hovered || !interactive;

    final idleBg = isDark
        ? cs.surfaceContainerHighest.withOpacity(0.5)
        : cs.surfaceContainerLowest;
    final idleBorder = isDark
        ? cs.outlineVariant.withOpacity(0.4)
        : cs.outlineVariant;
    final hoveredBg = accent.withOpacity(isDark ? 0.08 : 0.05);
    final hoveredBorder = accent.withOpacity(isDark ? 0.5 : 0.55);

    return MouseRegion(
      onEnter: interactive ? (_) => setState(() => _hovered = true) : null,
      onExit: interactive ? (_) => setState(() => _hovered = false) : null,
      cursor: interactive ? SystemMouseCursors.click : MouseCursor.defer,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: _hovered ? hoveredBg : idleBg,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: _hovered ? hoveredBorder : idleBorder,
            width: 1.5,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: accent.withOpacity(isDark ? 0.1 : 0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  if (!isDark)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.showAccentBar)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 3,
                      color: accentBarActive
                          ? accent
                          : accent.withOpacity(isDark ? 0.25 : 0.2),
                    ),
                  Padding(
                    padding: widget.padding,
                    child: widget.builder(context, _hovered),
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
