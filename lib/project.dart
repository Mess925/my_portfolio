import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'theme/tokens.dart';
import 'widgets/section_badge.dart';
import 'widgets/surface_card.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  static const List<ProjectItem> _projects = [
    ProjectItem(
      title: 'Thales SmartCard SDK',
      description:
          'Cross-platform Flutter app for Thales smartcard interaction deployed on Android and iOS. Features demographic data, PIN management, certificate viewer, document signing with RSA/ECC encryption, and biometric verification — all via APDU commands. Built the internal SDK for future developers and implemented native layers in C.',
      tags: ['Flutter', 'Dart', 'Android', 'iOS', 'C', 'APDU', 'SDK'],
      githubUrl: 'https://github.com/Mess925',
    ),
    ProjectItem(
      title: 'Third Eye',
      description:
          'An AI-powered fact-checker that classifies news as true or false, provides related articles, and helps users make informed decisions.',
      tags: ['Next.js', 'Python', 'AI', 'Fact-Checking'],
      githubUrl: 'https://github.com/Th1rd3yE',
    ),
    ProjectItem(
      title: 'Knoverse',
      description:
          'Collaborative platform enabling teams to interact with AI-driven chat systems using internal documents for enhanced productivity.',
      tags: ['Next.js', 'Python', 'AI', 'Collaboration'],
      githubUrl: 'https://github.com/thanthtetaung4/Knoverse',
    ),
    ProjectItem(
      title: 'WebServ',
      description:
          'A simple multi-service web server built from scratch with Linux and Nginx, designed to handle HTTP requests efficiently.',
      tags: ['C', 'Linux', 'Nginx', 'Web Server'],
      githubUrl: 'https://github.com/thanthtetaung4/webserv',
    ),
    ProjectItem(
      title: 'miniRT',
      description:
          'A lightweight ray tracer implementing lighting, normals, and reflections for 3D rendering experiments.',
      tags: ['C', 'Graphics', 'Ray Tracing', 'Math'],
      githubUrl: 'https://github.com/Mess925/miniRT',
    ),
    ProjectItem(
      title: 'MiniShell',
      description:
          'Custom Unix shell supporting pipes, redirection, and built-in commands, designed for systems programming learning.',
      tags: ['C', 'Unix', 'Shell', 'Parsing'],
      githubUrl: 'https://github.com/Mess925',
    ),
    ProjectItem(
      title: 'Protective Path',
      description:
          'iOS application implementing threaded navigation with strict timing constraints and object detection for safety applications.',
      tags: ['iOS', 'Swift', 'Threading', 'Object Detection'],
      githubUrl: 'https://github.com/Mess925/ProtectivePath',
    ),
  ];

  static Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

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
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ───────────────────────────────────────────────
              const SectionBadge('SELECTED WORK'),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Things I have built.',
                style: textTheme.headlineLarge?.copyWith(
                  fontSize: isMobile ? 36 : 48,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'A collection of projects across systems programming,\ngraphics, and app development.',
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                  color: cs.onSurface.withOpacity(isDark ? 0.5 : 0.6),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // ── Grid ─────────────────────────────────────────────────
              LayoutBuilder(
                builder: (context, constraints) {
                  final cols = constraints.maxWidth < 560
                      ? 1
                      : constraints.maxWidth < 900
                      ? 2
                      : 3;
                  const spacing = 20.0;
                  final cardWidth =
                      (constraints.maxWidth - spacing * (cols - 1)) / cols;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: _projects
                        .map(
                          (p) => SizedBox(
                            width: cardWidth,
                            child: ProjectCard(project: p),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // ── CTA ──────────────────────────────────────────────────
              Center(
                child: _GithubButton(
                  onTap: () => _openUrl('https://github.com/Mess925'),
                  cs: cs,
                  isDark: isDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Github CTA Button ────────────────────────────────────────────────────

class _GithubButton extends StatefulWidget {
  const _GithubButton({
    required this.onTap,
    required this.cs,
    required this.isDark,
  });
  final VoidCallback onTap;
  final ColorScheme cs;
  final bool isDark;

  @override
  State<_GithubButton> createState() => _GithubButtonState();
}

class _GithubButtonState extends State<_GithubButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            color: _hovered
                ? widget.cs.primary
                : widget.isDark
                ? widget.cs.primary.withOpacity(0.1)
                : widget.cs.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: _hovered
                  ? widget.cs.primary
                  : widget.isDark
                  ? widget.cs.primary.withOpacity(0.3)
                  : widget.cs.primary.withOpacity(0.5),
              width: 1.5,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: widget.cs.primary.withOpacity(
                        widget.isDark ? 0.25 : 0.2,
                      ),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [
                    if (!widget.isDark)
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.code_rounded,
                size: 18,
                color: _hovered ? widget.cs.onPrimary : widget.cs.primary,
              ),
              const SizedBox(width: 10),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 14,
                  color: _hovered ? widget.cs.onPrimary : widget.cs.primary,
                ),
                child: const Text('View Full GitHub Profile'),
              ),
              const SizedBox(width: 8),
              AnimatedSlide(
                duration: const Duration(milliseconds: 180),
                offset: _hovered ? const Offset(0.2, 0) : Offset.zero,
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                  color: _hovered ? widget.cs.onPrimary : widget.cs.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Data Model ───────────────────────────────────────────────────────────

class ProjectItem {
  const ProjectItem({
    required this.title,
    required this.description,
    required this.tags,
    required this.githubUrl,
  });

  final String title;
  final String description;
  final List<String> tags;
  final String githubUrl;
}

// ─── Project Card ─────────────────────────────────────────────────────────

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});
  final ProjectItem project;

  Future<void> _open() async {
    final Uri uri = Uri.parse(project.githubUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ${project.githubUrl}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      onTap: _open,
      padding: const EdgeInsets.all(20),
      builder: (context, hovered) {
        final theme = Theme.of(context);
        final cs = theme.colorScheme;
        final textTheme = theme.textTheme;
        final isDark = theme.brightness == Brightness.dark;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + arrow
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    project.title,
                    style: textTheme.titleMedium,
                  ),
                ),
                AnimatedSlide(
                  duration: const Duration(milliseconds: 200),
                  offset: hovered ? const Offset(0.1, -0.1) : Offset.zero,
                  child: Icon(
                    Icons.north_east_rounded,
                    size: 16,
                    color: hovered
                        ? cs.primary
                        : cs.onSurface.withOpacity(isDark ? 0.25 : 0.3),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),

            // Description
            Text(
              project.description,
              style: textTheme.bodySmall?.copyWith(
                fontSize: 13.5,
                height: 1.55,
                color: cs.onSurface.withOpacity(isDark ? 0.55 : 0.65),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Tags
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: project.tags
                  .map(
                    (tag) => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        color: hovered
                            ? cs.primary.withOpacity(isDark ? 0.12 : 0.09)
                            : cs.onSurface.withOpacity(isDark ? 0.06 : 0.07),
                        border: Border.all(
                          color: hovered
                              ? cs.primary.withOpacity(isDark ? 0.3 : 0.35)
                              : isDark
                              ? Colors.transparent
                              : cs.outlineVariant.withOpacity(0.6),
                        ),
                      ),
                      child: Text(
                        tag,
                        style: textTheme.labelMedium?.copyWith(
                          color: hovered
                              ? cs.primary
                              : cs.onSurface.withOpacity(
                                  isDark ? 0.55 : 0.6,
                                ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
