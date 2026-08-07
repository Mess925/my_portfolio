import 'package:flutter/material.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 600;
    final horizontalPadding = isMobile
        ? 24.0
        : screenWidth < 1000
        ? 32.0
        : 56.0;

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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: cs.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'EXPERIENCE',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.8,
                    color: cs.primary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Where I have worked.',
                style: TextStyle(
                  fontSize: isMobile ? 36 : 48,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                  letterSpacing: -1.5,
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Professional experience in software engineering.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: cs.onSurface.withOpacity(isDark ? 0.5 : 0.6),
                ),
              ),
              const SizedBox(height: 48),

              // ── Experience card ───────────────────────────────────────
              _ExperienceCard(isDark: isDark),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Experience Card ───────────────────────────────────────────────────────

class _ExperienceCard extends StatefulWidget {
  const _ExperienceCard({required this.isDark});
  final bool isDark;

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _expanded = false;

  static const _accent = Color(0xFF2979FF);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: widget.isDark
            ? cs.surfaceContainerHighest.withOpacity(0.5)
            : cs.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: widget.isDark
              ? cs.outlineVariant.withOpacity(0.4)
              : cs.outlineVariant,
          width: 1.5,
        ),
        boxShadow: widget.isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Accent top bar
            Container(height: 3, color: _accent),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
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
                          color: _accent.withOpacity(
                            widget.isDark ? 0.15 : 0.1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.security_rounded,
                          color: _accent,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Software Engineer Intern · Middleware',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: cs.onSurface,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Thales DIS · Singapore',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: _accent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Date badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: cs.onSurface.withOpacity(
                            widget.isDark ? 0.08 : 0.06,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Feb – Jul 2026',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: cs.onSurface.withOpacity(
                              widget.isDark ? 0.6 : 0.65,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ── Summary ─────────────────────────────────────────
                  Text(
                    'Built a cross-platform Flutter application for Thales smartcard interaction, '
                    'deployed on Android and iOS. The app communicates with smartcards via APDU commands '
                    'and surfaces a reusable SDK so the next developer can pick up where I left off. '
                    'Also worked on the native layers in C and adapted behavior per OS.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.65,
                      color: cs.onSurface.withOpacity(
                        widget.isDark ? 0.55 : 0.65,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Tech tags ────────────────────────────────────────
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
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

                  const SizedBox(height: 20),

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
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _accent,
                            ),
                          ),
                          const SizedBox(width: 4),
                          AnimatedRotation(
                            turns: _expanded ? 0.5 : 0,
                            duration: const Duration(milliseconds: 220),
                            child: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: _accent,
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
                            padding: const EdgeInsets.only(top: 20),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Tag chip ──────────────────────────────────────────────────────────────

class _Tag extends StatelessWidget {
  const _Tag({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: cs.onSurface.withOpacity(isDark ? 0.06 : 0.07),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
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

  static const _accent = Color(0xFF2979FF);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                      color: _accent.withOpacity(isDark ? 0.12 : 0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: _accent, size: 18),
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
                padding: EdgeInsets.only(
                  top: 6,
                  bottom: isLast ? 0 : 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: cs.onSurface.withOpacity(
                          isDark ? 0.5 : 0.6,
                        ),
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
