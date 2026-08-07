import 'package:flutter/material.dart';

import 'about.dart';
import 'contact.dart';
import 'experience.dart';
import 'project.dart';
import 'theme/app_theme.dart';
import 'theme/tokens.dart';
import 'widgets/hover_link.dart';
import 'widgets/reveal_on_load.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.toggleTheme,
    required this.themeMode,
  });

  final VoidCallback toggleTheme;
  final ThemeMode themeMode;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _workKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();

  Future<void> _scrollTo(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
      alignment: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < 700;
    final horizontalPadding = isMobile ? AppSpacing.lg : AppSpacing.xl;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1080),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _NavBar(
                    themeMode: widget.themeMode,
                    onToggleTheme: widget.toggleTheme,
                    onWorkTap: () => _scrollTo(_workKey),
                    onProjectsTap: () => _scrollTo(_projectsKey),
                    onContactTap: () => _scrollTo(_contactKey),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  const RevealOnLoad(child: HeroHeader()),
                  SizedBox(height: isMobile ? AppSpacing.section : 96),
                  Container(key: _workKey, child: const ExperienceSection()),
                  const SizedBox(height: AppSpacing.section),
                  Container(
                    key: _projectsKey,
                    child: const ProjectsSection(),
                  ),
                  const SizedBox(height: AppSpacing.section),
                  const SkillsSection(),
                  const SizedBox(height: AppSpacing.section),
                  Container(key: _contactKey, child: const ContactSection()),
                  const SizedBox(height: AppSpacing.section),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  const _NavBar({
    required this.themeMode,
    required this.onToggleTheme,
    required this.onWorkTap,
    required this.onProjectsTap,
    required this.onContactTap,
  });

  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;
  final VoidCallback onWorkTap;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('H THANT', style: textTheme.labelLarge),
          Row(
            children: [
              HoverLink(
                text: 'Work',
                underlineAtRest: false,
                style: textTheme.labelLarge,
                onTap: onWorkTap,
              ),
              const SizedBox(width: AppSpacing.lg),
              HoverLink(
                text: 'Projects',
                underlineAtRest: false,
                style: textTheme.labelLarge,
                onTap: onProjectsTap,
              ),
              const SizedBox(width: AppSpacing.lg),
              HoverLink(
                text: 'Contact',
                underlineAtRest: false,
                style: textTheme.labelLarge,
                onTap: onContactTap,
              ),
              const SizedBox(width: AppSpacing.lg),
              _ThemeToggle(themeMode: themeMode, onTap: onToggleTheme),
            ],
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
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: palette.ink),
          ),
          child: Icon(
            isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            size: 15,
            color: _hovered ? palette.accent : palette.ink,
          ),
        ),
      ),
    );
  }
}
