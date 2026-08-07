import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ───────────────────────────────────────────────
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
                  'SELECTED WORK',
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
                'Things I have built.',
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
                'A collection of projects across systems programming,\ngraphics, and app development.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: cs.onSurface.withOpacity(isDark ? 0.5 : 0.6),
                ),
              ),
              const SizedBox(height: 48),

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
                            child: ProjectCard(project: p, isDark: isDark),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              const SizedBox(height: 56),

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
            borderRadius: BorderRadius.circular(16),
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
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
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

class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.project, required this.isDark});
  final ProjectItem project;
  final bool isDark;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  Future<void> _open() async {
    final Uri uri = Uri.parse(widget.project.githubUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ${widget.project.githubUrl}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final idleBg = widget.isDark
        ? cs.surfaceContainerHighest.withOpacity(0.5)
        : cs.surfaceContainerLowest;

    final idleBorder = widget.isDark
        ? cs.outlineVariant.withOpacity(0.4)
        : cs.outlineVariant;

    final hoveredBg = cs.primary.withOpacity(widget.isDark ? 0.06 : 0.04);
    final hoveredBorder = cs.primary.withOpacity(widget.isDark ? 0.5 : 0.55);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _open,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: _hovered ? hoveredBg : idleBg,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hovered ? hoveredBorder : idleBorder,
              width: 1.5,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: cs.primary.withOpacity(widget.isDark ? 0.1 : 0.08),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    if (!widget.isDark)
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
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 3,
                  color: _hovered
                      ? cs.primary
                      : cs.primary.withOpacity(widget.isDark ? 0.25 : 0.2),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + arrow
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.project.title,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: cs.onSurface,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ),
                          AnimatedSlide(
                            duration: const Duration(milliseconds: 200),
                            offset: _hovered
                                ? const Offset(0.1, -0.1)
                                : Offset.zero,
                            child: Icon(
                              Icons.north_east_rounded,
                              size: 16,
                              color: _hovered
                                  ? cs.primary
                                  : cs.onSurface.withOpacity(
                                      widget.isDark ? 0.25 : 0.3,
                                    ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Description
                      Text(
                        widget.project.description,
                        style: TextStyle(
                          fontSize: 13.5,
                          height: 1.55,
                          color: cs.onSurface.withOpacity(
                            widget.isDark ? 0.55 : 0.65,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Tags
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: widget.project.tags
                            .map(
                              (tag) => AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(999),
                                  color: _hovered
                                      ? cs.primary.withOpacity(
                                          widget.isDark ? 0.12 : 0.09,
                                        )
                                      : cs.onSurface.withOpacity(
                                          widget.isDark ? 0.06 : 0.07,
                                        ),
                                  border: Border.all(
                                    color: _hovered
                                        ? cs.primary.withOpacity(
                                            widget.isDark ? 0.3 : 0.35,
                                          )
                                        : widget.isDark
                                        ? Colors.transparent
                                        : cs.outlineVariant.withOpacity(0.6),
                                  ),
                                ),
                                child: Text(
                                  tag,
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.2,
                                    color: _hovered
                                        ? cs.primary
                                        : cs.onSurface.withOpacity(
                                            widget.isDark ? 0.55 : 0.6,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
