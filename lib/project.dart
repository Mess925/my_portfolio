import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'theme/app_theme.dart';
import 'theme/tokens.dart';
import 'widgets/hover_link.dart';
import 'widgets/section_header.dart';

Future<void> _openUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}

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

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(number: '02', title: 'Projects'),
        const SizedBox(height: AppSpacing.xl),
        Container(
          decoration: BoxDecoration(border: Border.all(color: palette.border)),
          child: Column(
            children: [
              for (int i = 0; i < _projects.length; i++)
                _ProjectRow(
                  index: i + 1,
                  project: _projects[i],
                  isLast: i == _projects.length - 1,
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        HoverLink(
          text: 'See more on GitHub →',
          style: Theme.of(context).textTheme.labelMedium,
          onTap: () => _openUrl('https://github.com/Mess925'),
        ),
      ],
    );
  }
}

class _ProjectRow extends StatefulWidget {
  const _ProjectRow({
    required this.index,
    required this.project,
    required this.isLast,
  });

  final int index;
  final ProjectItem project;
  final bool isLast;

  @override
  State<_ProjectRow> createState() => _ProjectRowState();
}

class _ProjectRowState extends State<_ProjectRow> {
  bool _hovered = false;

  Future<void> _open() async {
    final Uri uri = Uri.parse(widget.project.githubUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ${widget.project.githubUrl}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final palette = theme.extension<AppPalette>()!;
    final isMobile = MediaQuery.sizeOf(context).width < 700;

    final indexLabel = Text(
      widget.index.toString().padLeft(2, '0'),
      style: textTheme.labelMedium,
    );

    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.project.title,
          style: textTheme.titleLarge?.copyWith(fontSize: 24),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(widget.project.description, style: textTheme.bodySmall),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: widget.project.tags
              .map(
                (tag) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: palette.border),
                  ),
                  child: Text(
                    tag.toUpperCase(),
                    style: textTheme.labelSmall,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );

    final viewMore = Text('View →', style: textTheme.labelLarge);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: Container(
        decoration: BoxDecoration(
          color: _hovered ? palette.hoverTint : Colors.transparent,
          border: widget.isLast
              ? null
              : Border(bottom: BorderSide(color: palette.border)),
        ),
        child: InkWell(
          onTap: _open,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [indexLabel, viewMore],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      body,
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 48, child: indexLabel),
                      Expanded(child: body),
                      const SizedBox(width: AppSpacing.lg),
                      viewMore,
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
