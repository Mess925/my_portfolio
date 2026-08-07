import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 600;

    final nameSize = isMobile ? 52.0 : 92.0;
    final padding = isMobile ? 24.0 : 56.0;

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
                // Greeting badge
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
                    'AVAILABLE FOR WORK',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.8,
                      color: cs.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Name
                Text(
                  "Hi, I'm",
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 20,
                    color: cs.onSurface.withOpacity(0.5),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Han Min Thant",
                  style: TextStyle(
                    fontSize: nameSize,
                    letterSpacing: -1.5,
                    fontWeight: FontWeight.w800,
                    height: 1.0,
                    color: cs.onSurface,
                  ),
                ),
                const SizedBox(height: 16),

                // Role line
                Row(
                  children: [
                    Container(
                      width: 3,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2979FF),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Software Engineer  ·  Mobile & Systems',
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 17,
                        fontWeight: FontWeight.w500,
                        color: cs.onSurface.withOpacity(isDark ? 0.65 : 0.7),
                        letterSpacing: 0.2,
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
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    height: 1.7,
                    color: cs.onSurface.withOpacity(isDark ? 0.5 : 0.6),
                  ),
                ),
                const SizedBox(height: 32),

                // Skill pills
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
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
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
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
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
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
