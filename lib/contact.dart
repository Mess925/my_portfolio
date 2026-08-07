import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'theme/tokens.dart';
import 'widgets/section_badge.dart';
import 'widgets/surface_card.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 600;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.lg : AppSpacing.xxl,
        vertical: isMobile ? AppSpacing.xl : AppSpacing.xxxl,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Header(),
              const SizedBox(height: AppSpacing.xxl),
              _ContactCard(
                icon: Icons.mail_outline_rounded,
                label: 'Email',
                subtitle: 'hanminthant222@gmail.com',
                accentColor: const Color(0xFF3D9BE0),
                onTap: () => _openUrl('mailto:hanminthant222@gmail.com'),
              ),
              const SizedBox(height: AppSpacing.md),
              _ContactCard(
                icon: Icons.chat_bubble_outline_rounded,
                label: 'WhatsApp',
                subtitle: '+65 8824 7721',
                accentColor: const Color(0xFF3FA66A),
                onTap: () =>
                    _openUrl('https://wa.me/6588247721?text=Hello%20Han!'),
              ),
              const SizedBox(height: AppSpacing.md),
              _ContactCard(
                icon: Icons.work_outline_rounded,
                label: 'LinkedIn',
                subtitle: 'linkedin.com/in/hanminthant',
                accentColor: cs.primary,
                onTap: () =>
                    _openUrl('https://www.linkedin.com/in/hanminthant/'),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Center(
                child: Text(
                  'Usually responds within 24 hours ✦',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: cs.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Header ────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionBadge('GET IN TOUCH'),
        const SizedBox(height: AppSpacing.md),
        Text(
          "Let's work together.",
          style: textTheme.headlineLarge?.copyWith(fontSize: 40),
        ),
        const SizedBox(height: 14),
        Text(
          "Have a project in mind or just want to say hello?\nI'm always open to new opportunities.",
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 15,
            color: cs.onSurface.withOpacity(0.55),
          ),
        ),
      ],
    );
  }
}

// ─── Contact Card ──────────────────────────────────────────────────────────

class _ContactCard extends StatelessWidget {
  const _ContactCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.accentColor,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final Color accentColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      onTap: onTap,
      accentColor: accentColor,
      showAccentBar: false,
      borderRadius: AppRadius.lg,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      builder: (context, hovered) {
        final theme = Theme.of(context);
        final cs = theme.colorScheme;
        final isDark = theme.brightness == Brightness.dark;

        return Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: accentColor.withOpacity(
                  hovered ? (isDark ? 0.2 : 0.15) : (isDark ? 0.12 : 0.1),
                ),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(icon, color: accentColor, size: 22),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: theme.textTheme.titleSmall),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onSurface.withOpacity(isDark ? 0.5 : 0.6),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSlide(
              duration: const Duration(milliseconds: 180),
              offset: hovered ? const Offset(0.15, 0) : Offset.zero,
              child: Icon(
                Icons.arrow_forward_rounded,
                size: 18,
                color: hovered
                    ? accentColor
                    : cs.onSurface.withOpacity(isDark ? 0.3 : 0.35),
              ),
            ),
          ],
        );
      },
    );
  }
}
