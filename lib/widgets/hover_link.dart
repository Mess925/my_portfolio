import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Text link that turns accent-colored and underlined on hover — the base
/// state uses `palette.ink` with a permanent underline (matching the
/// reference's `border-bottom: 1px solid currentColor` link style) unless
/// [underlineAtRest] is false.
class HoverLink extends StatefulWidget {
  const HoverLink({
    super.key,
    required this.text,
    required this.onTap,
    this.style,
    this.underlineAtRest = true,
  });

  final String text;
  final VoidCallback onTap;
  final TextStyle? style;
  final bool underlineAtRest;

  @override
  State<HoverLink> createState() => _HoverLinkState();
}

class _HoverLinkState extends State<HoverLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.extension<AppPalette>()!;
    final base = widget.style ?? theme.textTheme.bodyMedium!;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: base.copyWith(
            color: _hovered ? palette.accent : palette.ink,
            decoration: (_hovered || widget.underlineAtRest)
                ? TextDecoration.underline
                : TextDecoration.none,
            decorationColor: _hovered ? palette.accent : palette.ink,
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}
