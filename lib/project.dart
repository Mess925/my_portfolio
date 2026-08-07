import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'theme/app_theme.dart';
import 'theme/tokens.dart';
import 'widgets/eyebrow_label.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EyebrowLabel('Projects'),
        const SizedBox(height: AppSpacing.lg),
        for (int i = 0; i < _projects.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.md + 8),
          _ProjectRow(project: _projects[i]),
        ],
      ],
    );
  }
}

class _ProjectRow extends StatefulWidget {
  const _ProjectRow({required this.project});
  final ProjectItem project;

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
    final textTheme = Theme.of(context).textTheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          border: Border.all(
            color: _hovered ? AppColors.accent : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _open,
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.project.title,
                          style: textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        widget.project.tags.join(' / '),
                        style: textTheme.labelSmall,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(widget.project.description, style: textTheme.bodySmall),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
