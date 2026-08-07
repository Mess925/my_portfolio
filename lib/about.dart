import 'package:flutter/material.dart';

import 'theme/tokens.dart';
import 'widgets/section_badge.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 600;

    final nameSize = isMobile ? 52.0 : 92.0;
    final padding = isMobile ? AppSpacing.lg : AppSpacing.xxxl;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 400),
        child: Align(
          alignment: Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionBadge('AVAILABLE FOR WORK'),
                const SizedBox(height: AppSpacing.lg),

                // Name
                Text(
                  "Hi, I'm",
                  style: textTheme.bodyLarge?.copyWith(
                    fontSize: isMobile ? 16 : 20,
                    color: cs.onSurface.withOpacity(0.5),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Han Min Thant",
                  style: textTheme.displayLarge?.copyWith(fontSize: nameSize),
                ),
                const SizedBox(height: AppSpacing.md),

                // Role line — terminal-prompt style
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '>',
                      style: textTheme.labelSmall?.copyWith(
                        fontSize: isMobile ? 14 : 16,
                        fontWeight: FontWeight.w700,
                        color: cs.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        'Software Engineer · Mobile & Systems',
                        style: textTheme.labelSmall?.copyWith(
                          fontSize: isMobile ? 14 : 16,
                          color: cs.onSurface.withOpacity(isDark ? 0.65 : 0.7),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Bio
                Text(
                  'I build cross-platform mobile applications and low-level systems software. '
                  'I enjoy working close to the hardware — from APDU smartcard protocols and native C layers '
                  'to polished Flutter UIs on Android and iOS.',
                  style: textTheme.bodyLarge?.copyWith(
                    fontSize: isMobile ? 14 : 16,
                    height: 1.7,
                    color: cs.onSurface.withOpacity(isDark ? 0.5 : 0.6),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // Skill pills
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children:
                      const [
                            'Flutter',
                            'Dart',
                            'C',
                            'Swift',
                            'Kotlin',
                            'Python',
                            'Next.js',
                          ]
                          .map(
                            (s) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  AppRadius.pill,
                                ),
                                color: cs.onSurface.withOpacity(
                                  isDark ? 0.06 : 0.07,
                                ),
                                border: Border.all(
                                  color: cs.onSurface.withOpacity(
                                    isDark ? 0.1 : 0.12,
                                  ),
                                ),
                              ),
                              child: Text(
                                s,
                                style: textTheme.labelMedium?.copyWith(
                                  color: cs.onSurface.withOpacity(
                                    isDark ? 0.6 : 0.65,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
