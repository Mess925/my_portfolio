import 'package:flutter/material.dart';

import 'about.dart';
import 'contact.dart';
import 'experience.dart';
import 'project.dart';
import 'theme/app_theme.dart';
import 'theme/tokens.dart';
import 'widgets/reveal_on_load.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.toggleTheme,
    required this.themeMode,
  });

  final VoidCallback toggleTheme;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 600;
    final horizontalPadding = isMobile ? AppSpacing.lg : AppSpacing.xxl;

    const sectionDelayStep = Duration(milliseconds: 90);
    final sections = <Widget>[
      const HeroHeader(),
      const AboutSection(),
      const ExperienceSection(),
      const ProjectsSection(),
      const SkillsSection(),
      const ContactSection(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                isMobile ? AppSpacing.xxxl : 120,
                horizontalPadding,
                isMobile ? AppSpacing.xxxl : AppSpacing.section * 2,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < sections.length; i++) ...[
                        if (i > 0) const SizedBox(height: AppSpacing.section),
                        RevealOnLoad(
                          delay: sectionDelayStep * i,
                          child: sections[i],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: horizontalPadding,
            child: SafeArea(
              child: _ThemeToggle(themeMode: themeMode, onTap: toggleTheme),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeToggle extends StatefulWidget {
  const _ThemeToggle({required this.themeMode, required this.onTap});

  final ThemeMode themeMode;
  final VoidCallback onTap;

  @override
  State<_ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<_ThemeToggle> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    final isDark = widget.themeMode == ThemeMode.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Icon(
            isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            key: ValueKey(isDark),
            size: 20,
            color: _hovered ? palette.accent : palette.inkFaint,
          ),
        ),
      ),
    );
  }
}
