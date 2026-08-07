import 'package:flutter/material.dart';

import 'theme/tokens.dart';
import 'widgets/section_badge.dart';
import 'widgets/surface_card.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 600;
    final horizontalPadding = isMobile
        ? AppSpacing.lg
        : screenWidth < 1000
        ? AppSpacing.xl
        : AppSpacing.xxxl;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: isMobile ? 36 : 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header badge ─────────────────────────────────────────
              const SectionBadge('EXPERIENCE'),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Where I have worked.',
                style: textTheme.headlineLarge?.copyWith(
                  fontSize: isMobile ? 36 : 48,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Professional experience in software engineering.',
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                  color: cs.onSurface.withOpacity(isDark ? 0.5 : 0.6),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // ── Experience card ───────────────────────────────────────
              const _ExperienceCard(),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Experience Card ───────────────────────────────────────────────────────

class _ExperienceCard extends StatefulWidget {
  const _ExperienceCard();

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    return SurfaceCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      builder: (context, hovered) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Role + company row ──────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Company icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: cs.primary.withOpacity(isDark ? 0.15 : 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Icon(
                    Icons.security_rounded,
                    color: cs.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Software Engineer Intern · Middleware',
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Thales DIS · Singapore',
                        style: textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: cs.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                // Date badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: cs.onSurface.withOpacity(isDark ? 0.08 : 0.06),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Text(
                    'Feb – Jul 2026',
                    style: textTheme.labelSmall?.copyWith(
                      color: cs.onSurface.withOpacity(isDark ? 0.6 : 0.65),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.lg),

            // ── Summary ─────────────────────────────────────────
            Text(
              'Built a cross-platform Flutter application for Thales smartcard interaction, '
              'deployed on Android and iOS. The app communicates with smartcards via APDU commands '
              'and surfaces a reusable SDK so the next developer can pick up where I left off. '
              'Also worked on the native layers in C and adapted behavior per OS.',
              style: textTheme.bodyMedium?.copyWith(
                height: 1.65,
                color: cs.onSurface.withOpacity(isDark ? 0.55 : 0.65),
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // ── Tech tags ────────────────────────────────────────
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: const [
                'Flutter',
                'Dart',
                'Android',
                'iOS',
                'C',
                'Swift',
                'Kotlin',
                'APDU',
                'SDK',
              ].map((tag) => _Tag(label: tag)).toList(),
            ),

            const SizedBox(height: AppSpacing.lg),

            // ── Expand toggle ────────────────────────────────────
            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              behavior: HitTestBehavior.opaque,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _expanded ? 'Hide modules' : 'View app modules',
                      style: textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: cs.primary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 220),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: cs.primary,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Expandable modules ───────────────────────────────
            AnimatedSize(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              child: _expanded
                  ? Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.lg),
                      child: Column(
                        children: const [
                          _ModuleRow(
                            icon: Icons.person_outline_rounded,
                            title: 'Demographic Data',
                            description:
                                'Reads and displays personal data stored on the smartcard.',
                          ),
                          _ModuleRow(
                            icon: Icons.pin_outlined,
                            title: 'PIN Management',
                            description:
                                'Verify, change, and unblock PIN via APDU commands.',
                          ),
                          _ModuleRow(
                            icon: Icons.verified_outlined,
                            title: 'Certificate Viewer',
                            description:
                                'Retrieves and displays X.509 certificates from the card.',
                          ),
                          _ModuleRow(
                            icon: Icons.draw_outlined,
                            title: 'Document Signing & Encryption',
                            description:
                                'Sign digital files using card certificates; RSA and ECC encrypt/decrypt.',
                          ),
                          _ModuleRow(
                            icon: Icons.fingerprint_rounded,
                            title: 'Biometric Verification',
                            description:
                                'On-card biometric match for identity verification.',
                            isLast: true,
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }
}

// ─── Tag chip ──────────────────────────────────────────────────────────────

class _Tag extends StatelessWidget {
  const _Tag({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.pill),
        color: cs.onSurface.withOpacity(isDark ? 0.06 : 0.07),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelMedium?.copyWith(
          color: cs.onSurface.withOpacity(isDark ? 0.55 : 0.6),
        ),
      ),
    );
  }
}

// ─── Module row (timeline item) ────────────────────────────────────────────

class _ModuleRow extends StatelessWidget {
  const _ModuleRow({
    required this.icon,
    required this.title,
    required this.description,
    this.isLast = false,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 4),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline column
            SizedBox(
              width: 36,
              child: Column(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: cs.primary.withOpacity(isDark ? 0.12 : 0.08),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Icon(icon, color: cs.primary, size: 18),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 1.5,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        color: cs.outlineVariant.withOpacity(
                          isDark ? 0.35 : 0.5,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 6, bottom: isLast ? 0 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: 14,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        height: 1.5,
                        color: cs.onSurface.withOpacity(isDark ? 0.5 : 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
