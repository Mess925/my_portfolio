import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'theme/app_theme.dart';
import 'theme/tokens.dart';
import 'widgets/hover_link.dart';

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
    final theme = Theme.of(context);
    final palette = theme.extension<AppPalette>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's talk.",
          style: theme.textTheme.displayLarge?.copyWith(fontSize: 56),
        ),
        const SizedBox(height: AppSpacing.xl),
        HoverLink(
          text: 'hanminthant222@gmail.com',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: 22,
            color: palette.ink,
          ),
          onTap: () => _openUrl('mailto:hanminthant222@gmail.com'),
        ),
        const SizedBox(height: AppSpacing.xxl),
        Row(
          children: [
            _SocialButton(
              icon: FontAwesomeIcons.github,
              tooltip: 'GitHub',
              onTap: () => _openUrl('https://github.com/Mess925'),
            ),
            const SizedBox(width: AppSpacing.md),
            _SocialButton(
              icon: FontAwesomeIcons.linkedin,
              tooltip: 'LinkedIn',
              onTap: () =>
                  _openUrl('https://www.linkedin.com/in/hanminthant/'),
            ),
            const SizedBox(width: AppSpacing.md),
            _SocialButton(
              icon: FontAwesomeIcons.whatsapp,
              tooltip: 'WhatsApp',
              onTap: () =>
                  _openUrl('https://wa.me/6588247721?text=Hello%20Han!'),
            ),
            const SizedBox(width: AppSpacing.md),
            _SocialButton(
              icon: FontAwesomeIcons.linktree,
              tooltip: 'Linktree',
              onTap: () => _openUrl('https://linktr.ee/han_min'),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  const _SocialButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final FaIconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;

    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _hovered ? palette.ink : Colors.transparent,
              border: Border.all(color: palette.ink),
            ),
            child: FaIcon(
              widget.icon,
              size: 18,
              color: _hovered ? palette.background : palette.ink,
            ),
          ),
        ),
      ),
    );
  }
}
