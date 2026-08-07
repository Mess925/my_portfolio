import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'theme/app_theme.dart';
import 'theme/tokens.dart';
import 'widgets/eyebrow_label.dart';

Future<void> _openUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EyebrowLabel('Contact'),
        const SizedBox(height: AppSpacing.lg),
        _TextLink(
          text: 'hanminthant222@gmail.com',
          style: textTheme.bodyMedium,
          onTap: () => _openUrl('mailto:hanminthant222@gmail.com'),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.xs,
          children: [
            _TextLink(
              text: 'GitHub',
              style: textTheme.bodySmall,
              onTap: () => _openUrl('https://github.com/Mess925'),
            ),
            _TextLink(
              text: 'LinkedIn',
              style: textTheme.bodySmall,
              onTap: () => _openUrl('https://www.linkedin.com/in/hanminthant/'),
            ),
            _TextLink(
              text: 'WhatsApp',
              style: textTheme.bodySmall,
              onTap: () =>
                  _openUrl('https://wa.me/6588247721?text=Hello%20Han!'),
            ),
          ],
        ),
      ],
    );
  }
}

class _TextLink extends StatefulWidget {
  const _TextLink({required this.text, required this.style, required this.onTap});

  final String text;
  final TextStyle? style;
  final VoidCallback onTap;

  @override
  State<_TextLink> createState() => _TextLinkState();
}

class _TextLinkState extends State<_TextLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          style: (widget.style ?? const TextStyle()).copyWith(
            color: _hovered ? palette.accentHover : palette.accent,
            decoration: _hovered ? TextDecoration.underline : TextDecoration.none,
            decorationColor: palette.accentHover,
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}
