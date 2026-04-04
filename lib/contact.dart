import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 600;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: isMobile ? 32 : 56,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(cs: cs),
              const SizedBox(height: 40),
              _ContactCard(
                icon: Icons.mail_outline_rounded,
                label: 'Email',
                subtitle: 'hanminthant222@gmail.com',
                accentColor: const Color(0xFF0288D1),
                isDark: isDark,
                onTap: () => _openUrl('mailto:hanminthant222@gmail.com'),
              ),
              const SizedBox(height: 16),
              _ContactCard(
                icon: Icons.chat_bubble_outline_rounded,
                label: 'WhatsApp',
                subtitle: '+65 8824 7721',
                accentColor: const Color(0xFF2E7D32),
                isDark: isDark,
                onTap: () =>
                    _openUrl('https://wa.me/6588247721?text=Hello%20Han!'),
              ),
              const SizedBox(height: 16),
              _ContactCard(
                icon: Icons.work_outline_rounded,
                label: 'LinkedIn',
                subtitle: 'linkedin.com/in/hanminthant',
                accentColor: const Color(0xFF1565C0),
                isDark: isDark,
                onTap: () =>
                    _openUrl('https://www.linkedin.com/in/hanminthant/'),
              ),
              const SizedBox(height: 48),
              Center(
                child: Text(
                  'Usually responds within 24 hours ✦',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blueAccent,
                    letterSpacing: 0.3,
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
  const _Header({required this.cs});
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: cs.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'GET IN TOUCH',
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
          "Let's work together.",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w800,
            height: 1.1,
            letterSpacing: -1,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          "Have a project in mind or just want to say hello?\nI'm always open to new opportunities.",
          style: TextStyle(
            fontSize: 15,
            height: 1.6,
            color: cs.onSurface.withOpacity(0.55),
          ),
        ),
      ],
    );
  }
}

// ─── Contact Card ──────────────────────────────────────────────────────────

class _ContactCard extends StatefulWidget {
  const _ContactCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.accentColor,
    required this.isDark,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final Color accentColor;
  final bool isDark;
  final VoidCallback onTap;

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Light mode needs stronger borders and surface contrast
    final idleBorderColor = widget.isDark
        ? cs.outlineVariant.withOpacity(0.4)
        : cs.outlineVariant;

    final idleBgColor = widget.isDark
        ? cs.surfaceContainerHighest.withOpacity(0.5)
        : cs.surfaceContainerLowest;

    final hoveredBgColor = widget.accentColor.withOpacity(
      widget.isDark ? 0.08 : 0.06,
    );
    final hoveredBorderColor = widget.accentColor.withOpacity(
      widget.isDark ? 0.5 : 0.6,
    );

    final iconBgColor = widget.accentColor.withOpacity(
      _hovered ? (widget.isDark ? 0.2 : 0.15) : (widget.isDark ? 0.12 : 0.1),
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: _hovered ? hoveredBgColor : idleBgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered ? hoveredBorderColor : idleBorderColor,
            width: 1.5,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: widget.accentColor.withOpacity(
                      widget.isDark ? 0.12 : 0.1,
                    ),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  // Subtle resting shadow on light mode so cards have depth
                  if (!widget.isDark)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.accentColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.label,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: cs.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.subtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: cs.onSurface.withOpacity(
                              widget.isDark ? 0.5 : 0.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedSlide(
                    duration: const Duration(milliseconds: 180),
                    offset: _hovered ? const Offset(0.15, 0) : Offset.zero,
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: _hovered
                          ? widget.accentColor
                          : cs.onSurface.withOpacity(
                              widget.isDark ? 0.3 : 0.35,
                            ),
                    ),
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
